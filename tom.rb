require 'lib/thumb'
require 'sinatra'

get "/" do
  erb :index
end

get "/thumb" do
  img = Magick::Image::from_blob(open(params[:photo_url]).read).first
  img.crop!(params[:x].to_i, params[:y].to_i, params[:width].to_i, params[:width].to_i)
  img.resize!(275, 275)
  img.to_blob
end

helpers do
  def photoset
   JSON.parse( open("http://api.flickr.com/services/feeds/photoset.gne?set=72157624231740192&nsid=43850926@N08&lang=en-us&format=json&jsoncallback=?").read[1..-2] )
  end
end
