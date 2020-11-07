
class DictionaryFactory
    

  def self.provide(provider)
    providers = {
      oxford: provide_oxford
    }
    providers[provider] || provide_oxford
  end

  def self.provide_oxford
    OxfordApiClient.new(app_key: Rails.configuration.x.oxford_dictionary.app_key, app_id: Rails.configuration.x.oxford_dictionary.app_id)
  end

end 