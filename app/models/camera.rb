class Camera
  # @param [Integer] device_index
  # @param [String] size
  def self.capture(device_index: 0, size: '320x240')
    video_file = OpenCV::cv::VideoCapture.new(device_index)
    frame = OpenCV::cv::Mat.new
    width, height = size.split('x').map(&:to_i)
    if video_file.read(frame)
      OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
      OpenCV::cv::imwrite "captured_image.png", frame
    end
  end
end
