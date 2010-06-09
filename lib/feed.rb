class Feed
  def initialize(url)
    @url = url
  end

  def perform
    json = JSON.parse( open(@url + "&format=json&jsoncallback=?").read[1..-2] )
    json["items"].each do |item|
      puts ("Enqueueing thumbnail for #{item["title"]}.")
      Delayed::Job.enqueue Thumbnail.new(item["media"]["m"], 300, 300)
    end
  end
end
