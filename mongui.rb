require 'rubygems'
require 'sinatra'
require 'mongo'
require 'models/databases'

# Index
get "/" do
  @databases = Database.find(:all)
  haml :index, {:layout => true}
end

%w{collections databases documents}.each {|route| require "routes/#{route}"}
