class CapturedImagesController < ApplicationController
  def create
    device_index = Setting.instance.capture_device_name
    size = Camera::TARGET_SIZE

    @base64_encoded_image = nil
    Tempfile.new(['', '.png']).tap do |file|
      Camera.capture(device_index: device_index, size: size, file_path: file.path)
      file.rewind
      @base64_encoded_image = Base64.strict_encode64(file.read)
      file.close
    end
  rescue => e
    @error = e
  end
end
