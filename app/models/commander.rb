# bundle exec rails r 'Commander.new.run'
#
# * params
#   * SAVE_DETECTED_IMAGE
#     * 補足した画像を書き込む
#   * CAPTURE_ANOTHER_SIZE
#     * 別サイズで画像を保存する
#
# * cleanup
#  * rm -rf tmp/detected_images/*.png

class Commander
  class Measurement
    class Span
      def initialize
        @table = {}
      end

      def measure(key)
        @table[key] = Benchmark.realtime { yield }.floor(3)
      end

      def total
        @table.values.sum.floor(3)
      end

      def inspect
        @table.merge(total: total)
      end
    end

    def initialize
      @bucket = {}
    end

    def measure
      current_second = Time.now.to_i
      span = Span.new
      yield(span)

      if @bucket[current_second].nil?
        update_statistics(@bucket.values.first) if @bucket.values.present?
        @bucket = {}
        @bucket[current_second] = []
      end

      @bucket[current_second] << span
      true
    end

    private

    def update_statistics(spans)
      puts "Processed per second: #{spans.size}, Max time: #{spans.max_by(&:total).inspect}, Min time: #{spans.min_by(&:total).inspect}"
    end
  end

  def initialize
    puts 'start Commander'

    Thread.new do
      loop do
        Rails.cache.fetch('cache capture_enabled', expires_in: 3.seconds) do
          if not Setting.instance.capture_enabled
            @capture_enabled = false
          end
        end
        sleep(3)
      end
    end

    @measurement = Measurement.new
  end

  def run
    loop do
      if not Setting.instance.capture_enabled
        sleep(2)
        redo
      end
      Rails.logger.info '処理を開始します'

      @capture_enabled = true
      setting = Setting.instance
      procon_bypass_man_host = setting.procon_bypass_man_host
      video_file = OpenCV::cv::VideoCapture.new(setting.capture_device_name)
      frame = OpenCV::cv::Mat.new
      width, height = Camera::TARGET_SIZE.split('x').map(&:to_i)

      # TODO: 同じ画像をframeに書き出していないかハッシュ値を使ってチェックしたい
      while @capture_enabled
        @measurement.measure do |measurement|
          measurement.measure('read video_file') do
            video_file.read(frame)
          end
          next if frame.empty # cameraデバイスが繋がっていなくて書き込めない場合がある

          measurement.measure('resize frame') do
            OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
          end

          result = nil
          measurement.measure('process detect target') do
            result = ProconBypassManCommander::Splatoon3::EnemyTargetDetectorHDLiter.detect?(frame)
          end

          measurement.measure('send_command to client') do
            if result # TODO: load detect class
              procon_bypass_man_host.client.send_command(buttons: ['unzr'])

              if ENV['SAVE_DETECTED_IMAGE']
                time = Time.now
                OpenCV::cv::imwrite "./tmp/detected_images/#{time.to_i}#{time.usec}.png", frame
              end

              if(size = ENV['CAPTURE_ANOTHER_SIZE']) # ex: 360p, 640x360を撮影したい時に使う
                width, height = size.split('x').map(&:to_i)
                OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
                OpenCV::cv::imwrite "./tmp/aothoer_size_detected_images/#{time.to_i}#{time.usec}.png", frame
              end
            end
          end
        end
      end

      Rails.logger.info  '一時停止しました'
    end
  end
end
