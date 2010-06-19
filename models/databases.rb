require 'mongo'

class Database
  attr_accessor :collections, :db
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.find(query)
    if query == :all
      mongo = Mongo::Connection.new

      @@databases = []
      mongo.database_names.each do |name|
        db = Database.new(name)
        db.db = Mongo::Connection.new.db(name)
        @@databases << db
      end
      return @@databases
    end

    db = Database.new(query)
    db.db = Mongo::Connection.new.db(query)
    db
  end

  def self.drop(name)
    Mongo::Connection.new.drop_database name
  end
end
