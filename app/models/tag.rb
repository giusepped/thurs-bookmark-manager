class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  has n, :links, through: Resource

  validates_presence_of :name
end