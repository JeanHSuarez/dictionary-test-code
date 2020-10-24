class OxfordApiClient
    class Error < StandardError

    end 

    def initialize(app_key:, app_id:)
      @app_key = app_key
      @app_id = app_id
    end
  
    def lookup(word, language: 'en-us')
      uri_template = 'https://od-api.oxforddictionaries.com/api/v2/entries/%s/%s?fields=definitions&strictMatch=false'
      uri = URI(format(uri_template, language, ERB::Util.url_encode(word)))
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri
        request['app_key'] = @app_key
        request['app_id'] = @app_id
        http.request request
      end
  
      case response
      when Net::HTTPSuccess

        api_result = JSON.parse response.body
 
        extract_definitions(api_result)

      when Net::HTTPServerError, Net::HTTPClientError
        raise OxfordApiClient::Error, response



  
      else
        puts response.inspect
        return nil
      end



    end

    private
    def extract_definitions(api_result)
      definitions = []
      api_result["results"].each do |result|
        result["lexicalEntries"].each do |lexical_entry|
          lexical_entry["entries"].each do |entry|
            entry["senses"].each do |sense|
              sense["definitions"].each do |definition|
                definitions.push(definition)
              end
            end
          end
        end
      end
      return definitions

    end
  
  end