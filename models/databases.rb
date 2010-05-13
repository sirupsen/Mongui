require 'mongo'

class Database
  attr_accessor :collections, :db
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.find(query)
    db = Mongo::Connection.new
    

    if query = :all
      @@databases = []
      db.database_names.each {|name| @@databases << Database.new(name)}
      find_collections_for_databases
      @@databases
    end
  end

  private
    def self.find_collections_for_databases
      @@databases.each do |db|
        tmp_db = Mongo::Connection.new.db(db.name)
        db.db = tmp_db
      end
    end
end
