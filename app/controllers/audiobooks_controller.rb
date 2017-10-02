class AudiobooksController < ApplicationController
  AUDIOBOOK_ROOT_DIR = Rails.root.join('app', 'assets', 'audiobooks')

  def index
    files = Dir.entries(AUDIOBOOK_ROOT_DIR) - ['.', '..']
    @directories, @audiobooks = files.partition do |name|
      File.directory?(File.join(AUDIOBOOK_ROOT_DIR, name))
    end
  end

  def show
    name = params[:id]
    @audiobook = AUDIOBOOK_ROOT_DIR.join(name)
    unless File.exist?(@audiobook)
      render '404'
      return
    end
    @chapters = (Dir.entries(@audiobook) - ['.', '..'])
    @audiobook = @audiobook.to_s.gsub(@audiobook.dirname.to_s + '/', '')
  end

  def stream
    audiobook = params[:audiobook_id].to_s
    chapter = params[:chapter_id].to_s
    @audio_file = AUDIOBOOK_ROOT_DIR.join(audiobook, chapter+'.mp3')
    unless File.exist?(@audio_file)
      render '404'
      return
    end
    send_file @audio_file
  end
end
