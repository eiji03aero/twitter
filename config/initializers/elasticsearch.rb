Elasticsearch::Model.client = Elasticsearch::Client.new(
  host:  ENV['ELASTICSEARCH_HOST'] || "localhost",
  port:  ENV['ELASTICSEARCH_PORT'] || "9200",
  user:  ENV['ELASTICSEARCH_USER'] || "",
  password:  ENV['ELASTICSEARCH_PASSWORD'] || ""
)
