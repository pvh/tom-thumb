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
    thumbs = MongoConnection.mongo.collection('thumbs')
    thumbs.insert("url" => @url)
  end

  def read
    data = ""
    MongoConnection.gfs.open(@url, 'r') do |f|
      data += f.read
    end
    data
  end

  def self.list
    MongoConnection.mongo.collection('thumbs').find().collect { |i| i["url"] }
  end
end

