#This is a class that abstracts away the integration with oxford api
#into an easy to use object
class OxfordApiClient
 
    #Chose to accept key and id as parameter so that the class can be used
    #with different keys in different objects. 
    def initialize(app_key:, app_id:)
      @app_key = app_key
      @app_id = app_id
    end
    
    #This does the heavy lifting of the integration.
    #This method knows all about oxford dictionary api
    #from the url, to the field that are going to be displayed
    #and how the authentication is done. 
    #Uses the standard library's Net::HTTP
    def lookup(word, language: 'en-us')
      uri_template = 'https://od-api.oxforddictionaries.com/api/v2/entries/%s/%s?fields=definitions&strictMatch=false'
      uri = URI(format(uri_template, language, ERB::Util.url_encode(word))) #to get rid of space and other entities that are supposed to be escaped. 
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
        raise DictionaryApiClient::Error, response
  
      else
        return nil
      end
    end

    private

    #Opted to use a different method as it is a bit complicated.
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