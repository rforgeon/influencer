class UsersController < ApplicationController

  require 'date'
  require 'json'

  include WrapppedLinksHelper

  def show


    @user = User.find(params[:id])

    @wrapped_links = WrappedLink.where(user_id: params[:id])


    @wrapped_links.each do |link|

      ##GA Sessions##
      # @gaController = GoogleAnalyticsController.new
      # response = @gaController.sessions('userIDfiddle','brandIDfiddle')

      #Rebrandly Link Clicks
      my_link = rebrandly_link(link.rebrandly_id)

      rebrandly_clicks = my_link["clicks"]

      link.link_clicks = rebrandly_clicks
      link.save
    end

  end



  def dashboard

    @user = User.find(params[:user_id])

    @wrapped_links = WrappedLink.where(user_id: params[:user_id])



    @gaController = GoogleAnalyticsController.new
    request = {report_requests:[
              {metric:[{expession: "ga:metric2"}],
             dimensions:[{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: Date.today.beginning_of_month.strftime("%Y-%m-%d"), end_date: Time.now.strftime("%Y-%m-%d")}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==userID-Ralphy"
    }]}

    #total_earnings = @gaController.ga_request('userID-Ralphy',Date.today.beginning_of_month.strftime("%Y-%m-%d"),Time.now.strftime("%Y-%m-%d"))
    total_earnings = @gaController.ga_request(request)

    json = JSON.parse(response.to_json)

    render json: json

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
