class Camera
  # @param [Integer] device_index
  # @param [String] size default 360p
  # @param [String] file_path
  # @return [void]
  def self.capture(device_index: 0, size: '640x360', file_path: Rails.root.join('tmp', 'captured_image.png').to_s)
    video_file = OpenCV::cv::VideoCapture.new(device_index)
    frame = OpenCV::cv::Mat.new
    width, height = size.split('x').map(&:to_i)
    if video_file.read(frame)
      OpenCV::cv::resize(frame, frame, OpenCV::cv::Size.new(width, height))
      OpenCV::cv::imwrite(file_path, frame)
    end
  end
end
