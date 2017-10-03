class Content
  NoSuchFile = Struct.new(:path, :name)
                     .new('/',   '')

  CONTENT_ROOT_DIR = Rails.root.join('app', 'assets', 'audiobooks')

  class << self
    def new(*args, &block)
      content = super
      return content if content.exist?
      NoSuchFile
    end
  end

  def path
    @path.join('/')
  end

  def initialize(path)
    @path      = path.split('/')
    @path[-1] += '.mp3' unless directory?
  end
  delegate :exist?, :directory?, to: :full_path

  def full_path
    CONTENT_ROOT_DIR.join(*@path)
  end

  def files
    return nil unless directory?
    paths = Dir.entries(full_path) - ['.', '..']
    paths.map { |path| Content.new(path) }
  end

  def audios
    return nil unless directory?
    files.sort.reject { |f| f.directory? }
  end

  def directories
    return nil unless directory?
    files.sort.select { |f| f.directory? }
  end

  def name
    return nil if @path.empty?
    full_path.to_s.gsub(full_path.dirname.to_s + '/', '')
  end
  delegate :<=>, to: :name
end
