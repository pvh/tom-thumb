require 'lib/thumb'
require 'sinatra'

get "/" do
  erb :index
end

helpers do
  def photoset
   JSON.parse( open("http://api.flickr.com/services/feeds/photoset.gne?set=72157624231740192&nsid=43850926@N08&lang=en-us&format=json&jsoncallback=?").read[1..-2] )
  end
end
