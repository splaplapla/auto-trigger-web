class Commander
  def run
    loop do
      if not Setting.instance.capture_enabled
        sleep(1)
        redo
      end

      # TODO: load detect class
      @capture_enabled = true
      procon_bypass_man_host = Setting.instance.procon_bypass_man_host

      video_file = OpenCV::cv::VideoCapture.new(0)
      frame = OpenCV::cv::Mat.new
      frame_rate = 90.0
      frame_duration = 1.0 / frame_rate
      puts "writing video as single images at #{frame_rate} FPS"
      start_time = Time.now
      width, height = Camera::TARGET_SIZE.split('x').map(&:to_i)

      while video_file.read(frame) && @capture_enabled
        elapsed_time = Time.now - start_time
        if elapsed_time >= frame_duration
          OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
          start_time = Time.now
        end

        # TODO: 360pでできないか検討する
        # TODO: 画像サイズを小さくしたら早くなるかも？
        if ProconBypassManCommander::Splatoon3::EnemyTargetDetectorHDLiter.detect?(frame)
          # TODO: trueの時にスクショを保存する
          procon_bypass_man_host.client.send_command(buttons: ['unzr'])
          puts 'true'
        else
          puts 'false'
        end

        # TODO: Threadで取得する
        Rails.cache.fetch('cache capture_enabled', expires_in: 3.seconds) do
          if not Setting.instance.capture_enabled
            @capture_enabled = false
          end
        end
      end
    end
  end
end
