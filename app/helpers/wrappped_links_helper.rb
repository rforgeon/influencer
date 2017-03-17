module WrapppedLinksHelper

  def rebrandly_link(rebrandly_id)
    url = "https://api.rebrandly.com/v1/links/#{rebrandly_id}"

    response = HTTParty.get('https://api.rebrandly.com/v1/domains',
    :headers => { 'Content-Type' => 'application/json', 'apikey' => "#{accessToken}" } )

    json = JSON.parse(response.body)

    return json

  end

end
