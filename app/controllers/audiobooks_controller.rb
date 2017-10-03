class AudiobooksController < ApplicationController
   http_basic_authenticate_with name: "aim",
                                password: ENV['STREAM_PASSWORD']

  def show
    @current = find_content
  end

  def stream
    params[:path] += ".#{request.format.symbol}"
    @audio = find_content
    send_file @audio.full_path
  end

  def find_content
    content = Content.new(params[:path] || '/')
    raise ActiveRecord::RecordNotFound if content == Content::NoSuchFile
    content
  end
end
