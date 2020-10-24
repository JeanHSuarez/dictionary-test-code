class OxfordDictionaryController < ApplicationController
  
  
  def index


  end

  def lookup
  	client =  OxfordApiClient.new(app_key: Rails.configuration.x.oxford_dictionary.app_key, app_id: Rails.configuration.x.oxford_dictionary.app_id)
    @entries = client.lookup(params[:word])


  end
end
