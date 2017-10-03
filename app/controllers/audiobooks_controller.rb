class AudiobooksController < ApplicationController
   http_basic_authenticate_with name: "aim",
                                password: ENV['STREAM_PASSWORD']

  def show
    @current = Content.new(params[:path] || '/')
    raise ActiveRecord::RecordNotFound if @current == Content::NoSuchFile
  end

  def stream
    @audio = Content.new(params[:path] || '/')
    raise ActiveRecord::RecordNotFound if @current == Content::NoSuchFile
    send_file @audio.full_path
  end
end
