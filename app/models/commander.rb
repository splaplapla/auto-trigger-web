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
  end

  def run
    loop do
      if not Setting.instance.capture_enabled
        sleep(2)
        redo
      end
      Rails.logger.info '処理を開始します'

      @capture_enabled = true
      procon_bypass_man_host = Setting.instance.procon_bypass_man_host

      video_file = OpenCV::cv::VideoCapture.new(0)
      frame = OpenCV::cv::Mat.new
      width, height = Camera::TARGET_SIZE.split('x').map(&:to_i)

      # TODO: 1秒間に何回実行しているかをみたい
      # TODO: 同じ画像をframeに書き出していないかハッシュ値を使ってチェックしたい
      while video_file.read(frame) && @capture_enabled
        OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
        # TODO: 360pでできないか検討する
        # TODO: 画像サイズを小さくしたら早くなるかも？
        if ProconBypassManCommander::Splatoon3::EnemyTargetDetectorHDLiter.detect?(frame) # TODO: load detect class
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

      Rails.logger.info  '一時停止しました'
    end
  end
end
