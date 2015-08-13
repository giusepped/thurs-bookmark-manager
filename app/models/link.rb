class Link

      include DataMapper::Resource

      property :id,     Serial
      property :title,  String, required: true
      property :url,    String, required: true

      has n, :tags, through: Resource

      validates_presence_of :title, :url

end