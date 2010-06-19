# Show a collection
get "/database/:database/:collection" do
  @db = Database.find(params[:database])
  @collection = @db.db[params[:collection]]
  haml :collection, {:layout => true}
end

# Show a database
get "/database/:database" do
  @db = Database.find(params[:database])

  haml :database, {:layout => true}
end

# Drop a database
get "/drop/database/:database" do
  Database.drop params[:database]
  redirect "/"
end

# Add a database
post "/add/database" do
  redirect "/database/#{params[:dbname]}"
end
