require 'lib/tom'
require 'sinatra'

get "/" do
  erb :index
end

post "/" do
  if params[:feed_url]
    Delayed::Job.enqueue Feed.new(params[:feed_url])
  end
  erb :index
end

get "/thumb" do
  t = Thumbnail.new(params[:photo_url], 300, 300)

  begin
    t.read
  rescue
    halt 404
  end
end

