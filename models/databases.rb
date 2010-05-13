class Database
  attr_accessor :collections
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.find(query)
    db = Mongo::Connection.new

    @@databases = []
    db.database_names.each {|name| @@databases << Database.new(name)}
    find_collections_for_databases
    @@databases
  end

  private
    def self.find_collections_for_databases
      @@databases.each do |db|
        tmp_db = Mongo::Connection.new.db(db.name)
        db.collections = tmp_db.collection_names
      end
    end
end
