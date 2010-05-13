require 'sinatra'
require 'mongo'
require 'models/databases'

get "/" do
  @databases = Database.find(:all)
  haml :index, {:layout => true}
end
