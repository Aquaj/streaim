class AudiobooksController < ApplicationController
   http_basic_authenticate_with name: "aim",
                                password: ENV['STREAM_PASSWORD']

  def show
    @current = find_content
  end

  def stream
    @audio = find_content
    send_file @audio.full_path
  end

  def find_content
    if request.format.symbol != :html && params[:path]
      path = "#{params[:path]}.#{request.format.symbol}"
    end
    path ||= params[:path]

    content = Content.new(path || '/')
    raise ActiveRecord::RecordNotFound if content == Content::NoSuchFile
    content
  end
end
