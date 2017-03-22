class UsersController < ApplicationController

  require 'date'
  require 'json'

  include WrapppedLinksHelper

  helper_method :linkEarnings

  def show


    @user = User.find(params[:id])

    @wrapped_links = WrappedLink.where(user_id: params[:id])

    # @wrapped_links = WrappedLink.user

    @wrapped_links.each do |link|

      #Rebrandly Link Clicks
      my_link = rebrandly_link(link.rebrandly_id)


      rebrandly_clicks = my_link["clicks"]

      link.link_clicks = rebrandly_clicks
      link.save
    end

    @wrapped_links_sponsored = @wrapped_links.where(is_sponsored: true)

    @wrapped_links_supporter = @wrapped_links.where(is_sponsored: false)

  end





  def dashboard

    @user = User.find(params[:user_id])

    @wrapped_links = WrappedLink.where(user_id: params[:user_id])

    @wrapped_links.each do |link|

      #Rebrandly Link Clicks
      my_link = rebrandly_link(link.rebrandly_id)

      rebrandly_clicks = my_link["clicks"]
      last_clicked = my_link["lastClickAt"]

      link.link_clicks = rebrandly_clicks
      link.last_clicked = last_clicked
      link.save
    end

    @wrapped_links_sponsored = @wrapped_links.where(is_sponsored: true)

    @wrapped_links_supporter = @wrapped_links.where(is_sponsored: false)


    @startDate = (Date.today.beginning_of_month).strftime("%Y-%m-%d")
    @endDate = Time.now.strftime("%Y-%m-%d")

    #GA Sessions##
    @gaController = GoogleAnalyticsController.new
    @total_earnings = @gaController.user_earnings_total(current_user.id,@startDate, @endDate)

    def linkEarnings(link)
      @link_earnings = @gaController.user_earnings_from_brand(link.user_id, link.brand_id, @startDate, @endDate)
      return @link_earnings
    end



  end

  def metrics
    @user = User.find(params[:user_id])

    @brand = Brand.find(params[:brand_id])

  end


  def rebrandly_link(rebrandly_id)
    accessToken = ENV['REBRANDLY_API_KEY']
    url = "https://api.rebrandly.com/v1/links/#{rebrandly_id}"

    response = HTTParty.get(url,
    :headers => { 'Content-Type' => 'application/json', 'apikey' => "#{accessToken}" } )

    json = JSON.parse(response.body)

    return json

  end



end
