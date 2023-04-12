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

      while video_file.read(frame) && @capture_enabled
        OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
        # TODO: 360pでできないか検討する
        # TODO: 画像サイズを小さくしたら早くなるかも？
        if ProconBypassManCommander::Splatoon3::EnemyTargetDetectorHDLiter.detect?(frame) # TODO: load detect class
          procon_bypass_man_host.client.send_command(buttons: ['unzr'])
          time = Time.now
          OpenCV::cv::imwrite "./tmp/detected_images/#{time.to_i}#{time.usec}.png", frame
          puts 'true'
        else
          puts 'false'
        end
      end

      Rails.logger.info  '一時停止しました'
    end
  end
end
