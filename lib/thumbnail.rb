class Thumbnail
  def initialize(url, width, height)
    @url = url
    @width = width
    @height = height
  end

  def render
    img = Magick::Image::from_blob(open(@url).read).first
    img.resize!(@width, @height)
    img.to_blob
  end

  def perform
    MongoConnection.gfs.open(@url, 'w', :delete_old => true) do |f|
      f.write render
    end
  end

  def read
    MongoConnection.gfs.open(@url, 'r') do |f|
      f.read
    end
  end

end

