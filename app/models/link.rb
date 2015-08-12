# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declarations set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String, required: true
  property :url,    String, required: true

  has n, :tags, through: Resource

  validates_presence_of :title, :url

end