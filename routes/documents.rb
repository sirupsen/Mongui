# Add a document
get "/add/document/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]

  haml :add_document, {:layout => true}
end

# Edit a document
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

# Edit a document
post "/edit/document/:database/:collection/:id" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @doc = @collection.find_one({:_id => BSON::ObjectID.from_string(params[:id])})

  @collection.update({:_id => @doc["_id"]}, params[:document]) if @doc

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

# Wipe a collection of documents
get "/remove/documents/:database/:collection" do
  @db = Database.find(params[:database])
  @db.db[params[:collection]].remove

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

# Remove single document
get "/remove/document/:database/:collection/:id" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @collection.remove({:_id => BSON::ObjectID.from_string(params[:id])})

  redirect "/database/#{params[:database]}/#{params[:collection]}"
end
