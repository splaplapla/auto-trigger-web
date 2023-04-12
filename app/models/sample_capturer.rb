class SampleCapturer
  def run
    video_file = OpenCV::cv::VideoCapture.new(0)
    frame = OpenCV::cv::Mat.new
    id = 0
    frame_rate = 80.0
    frame_duration = 1.0 / frame_rate

    puts "writing video as single images at #{frame_rate} FPS"
    start_time = Time.now
    width, height = Camera::TARGET_SIZE.split('x').map(&:to_i)

    while video_file.read(frame)
      elapsed_time = Time.now - start_time
      if elapsed_time >= frame_duration
        OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
        OpenCV::cv::imwrite "./tmp/name_#{start_time.to_i}#{"%05d" % id }.png", frame
        id += 1
        start_time = Time.now
      end
    end
  end
end
