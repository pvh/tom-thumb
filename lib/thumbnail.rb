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

end

