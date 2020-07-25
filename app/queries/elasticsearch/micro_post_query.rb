class Elasticsearch::MicroPostQuery
  def initialize(params)
    @text = params[:text]
  end

  def call
    search.records
  end

  private
    attr_accessor :text

    def search
      case text
      when /^#[^\s]+$/
        search_hash_tag
      else
        search_content
      end
    end

    def search_hash_tag
      MicroPost.__elasticsearch__.search(
        query: {
          bool: {
            must: {
              match: { content: text }
            }
          }
        }
      )
    end

    def search_content
      MicroPost.__elasticsearch__.search(text)
    end
end
