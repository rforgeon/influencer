class WrappedLinksController < ApplicationController
  before_action :authenticate_user!


  def create
    @link = WrappedLink.new

    @brand = Brand.find(params[:brand_id])
    @generatedUser = current_user.id


    accessToken = ENV['REBRANDLY_API_KEY']

    custom_link = "#{current_user.user_name.delete(' ')}-#{@brand.companyName.delete(' ').delete(',')}"

    domain_response = HTTParty.get('https://api.rebrandly.com/v1/domains',
    :headers => { 'Content-Type' => 'application/json', 'apikey' => "#{accessToken}" } )

    domain_json = JSON.parse(domain_response.body)


    url = "https://api.rebrandly.com/v1/links"

    response = HTTParty.post(url,
    :body => { :title =>  "#{@link.id}",
               :domain => domain_json[0],
               :slashtag => custom_link,
               :destination => "#{@brand.campaignURL}"
             }.to_json,
    :headers => { 'Content-Type' => 'application/json', 'apikey' => "#{accessToken}" } )

     json = JSON.parse(response.body)
     #render json: json

    @link.link = json["shortUrl"]
    @link.rebrandly_id = json['linkId']
    @link.user_id = @generatedUser
    @link.brand_id = @brand.id
    @link.rank = "Supporter"

    #binding.pry

    if @link.save
      redirect_to user_path(@link.user_id), notice: "Your lickable link was created successfully."
    else
      #flash.now[:alert] = "Error creating link. Please try again"
      redirect_to :back, alert: "Error creating link. Please try again"
      #:BACK IS DEPRICATED Please use `redirect_back(fallback_location: fallback_location)` where `fallback_location` represents the location to use if the request has no HTTP referer information.
    end

  end

  def rebrandly_link(arg)
    accessToken = ENV['REBRANDLY_API_KEY']
    url = "https://api.rebrandly.com/v1/links/#{arg}"

    response = HTTParty.get('https://api.rebrandly.com/v1/domains',
    :headers => { 'Content-Type' => 'application/json', 'apikey' => "#{accessToken}" } )

    json = JSON.parse(response.body)

    return json

  end



    private

    def wrapped_link_params
      params.require(:wrapped_link).permit(
        :link,
        :user_id,
        :brand_id,
        # :rebrandly_id,
        # :rank
      )
    end

end
