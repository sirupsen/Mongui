require 'rubygems'
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

get "/database/:database" do
  @db = Database.find(params[:database])

  haml :database, {:layout => true}
end

get "/drop/database/:database" do
  "Due to a bug in the Mongo driver, this is not possible currently"
end

post "/add/collection/:database" do
  redirect "/add/document/#{params[:database]}/#{params[:collname]}"
end

get "/add/document/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]

  haml :add_document, {:layout => true}
end

get "/edit/document/:database/:collection/:id" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @doc = @collection.find_one({:_id => BSON::ObjectID.from_string(params[:id])})

  if @doc
    haml :edit_document, {:layout => true}
  else
    redirect "/database/#{params[:database]}/#{params[:collection]}"
  end
end

post "/edit/document/:database/:collection/:id" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @doc = @collection.find_one({:_id => BSON::ObjectID.from_string(params[:id])})

  if @doc
     @collection.update({:_id => @doc["_id"]}, params[:document])
  end

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

post "/add/document/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @collection.insert(params[:document])
  
  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

get "/drop/collection/:database/:collection" do
  @db = Database.find(params[:database])
  @db.db[params[:collection]].drop

  redirect "/"
end

get "/remove/documents/:database/:collection" do
  @db = Database.find(params[:database])
  @db.db[params[:collection]].remove

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

get "/remove/document/:database/:collection/:id" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @collection.remove({:_id => BSON::ObjectID.from_string(params[:id])})

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end
