# Add a collection
post "/add/collection/:database" do
  redirect "/add/document/#{params[:database]}/#{params[:collname]}"
end

# Add a collection
post "/add/document/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  @collection.insert(params[:document])
  
  redirect "/database/#{params[:database]}/#{params[:collection]}"
end

# Drop collection
get "/drop/collection/:database/:collection" do
  @db = Database.find(params[:database])
  @db.db[params[:collection]].drop

  redirect "/"
end
