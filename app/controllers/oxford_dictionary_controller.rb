class OxfordDictionaryController < ApplicationController

  rescue_from OxfordApiClient::Error, with: :handle_api_error
  
  
  def index
  	@recent_searches =  SearchedTerm.limit(5).order(created_at: :desc)

  end

  def lookup
  	client =  OxfordApiClient.new(app_key: Rails.configuration.x.oxford_dictionary.app_key, app_id: Rails.configuration.x.oxford_dictionary.app_id)
    @defined_word = params[:word].downcase
    @entries = client.lookup(@defined_word)
    SearchedTerm.create(term: @defined_word)


  end

  private
  def handle_api_error(exception)
  	response = exception.message
  	Rails.logger.error("An error has occurred: #{exception.class}")
  	Rails.logger.error("Parameters: #{params.inspect}")
  	Rails.logger.error("Response: #{response.inspect}")
  	redirect_to :root, notice: "An error has occurred. Please try again"

  end	


end
