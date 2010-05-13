require 'sinatra'
require 'mongo'
require 'models/databases'

get "/" do
  @databases = Database.find(:all)
  haml :index, {:layout => true}
end

get "/database/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  haml :collection, {:layout => true}
end
