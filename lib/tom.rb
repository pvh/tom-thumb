require 'json'
require 'net/http'
require 'RMagick'
require 'uri'
require 'open-uri'

require 'lib/thumbnail'

require 'delayed_job'
require 'mongo_mapper'

module MongoConnection
  extend self
  def connection
    @conn ||= Mongo::Connection.from_uri(db_url)
  end
  def mongo
    @mongo ||= connection.db(db_name)
  end
  def gfs
    @gfs ||= Mongo::GridFileSystem.new(mongo)
  end
  def db_name
    db_url.split('/').last
  end
  def db_url
    ENV['MONGO_URL'] || 'mongodb://localhost:localhost@localhost/test'
  end
end

MongoMapper.connection = MongoConnection.connection
MongoMapper.database = MongoConnection.db_name
Delayed::Worker.backend = :mongo_mapper

