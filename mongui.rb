require 'sinatra'
require 'mongo'

get "/" do
  db = Mongo::Connection.new

  @databases = db.database_names
  haml :index, {:layout => true}
end
