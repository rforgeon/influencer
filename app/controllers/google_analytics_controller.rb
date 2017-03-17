class GoogleAnalyticsController < ApplicationController

  require 'json'

  #helper_method :ga_request

  def ga_request(request)
    require 'google/apis/analyticsreporting_v4'
    analytics = Google::Apis::AnalyticsreportingV4::AnalyticsReportingService.new
    credentials = Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: IO.new(IO.sysopen('/Users/RJ/bloc/influencer/influencerApp/config/influencer-rep-86e8c1ab1821.json')))
    credentials.scope = 'https://www.googleapis.com/auth/analytics.readonly'
    analytics.authorization = credentials.fetch_access_token!({})["access_token"]

    results = analytics.batch_get_reports Google::Apis::AnalyticsreportingV4::GetReportsRequest.new(request)


    return results

  end


  def sessions_total(ga_user_id,ga_brand_id)

    require 'google/apis/analyticsreporting_v4'
    analytics = Google::Apis::AnalyticsreportingV4::AnalyticsReportingService.new
    credentials = Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: IO.new(IO.sysopen('/Users/RJ/bloc/influencer/influencerApp/config/influencer-rep-86e8c1ab1821.json')))
    credentials.scope = 'https://www.googleapis.com/auth/analytics.readonly'
    analytics.authorization = credentials.fetch_access_token!({})["access_token"]

    request = {report_requests:[
            {metric:[{expession: "ga:sessions"}],
             dimensions:[{name:"ga:date"},{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: (Date.today - 30).strftime("%Y-%m-%d"), end_date: Time.now.strftime("%Y-%m-%d")}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id},ga:dimension3==#{ga_brand_id}"
    }]}

    results = analytics.batch_get_reports Google::Apis::AnalyticsreportingV4::GetReportsRequest.new(request)

    json = JSON.parse(results.to_json)

    return json["reports"][0]["data"]["totals"][0]["values"][0]

  end

  #TODO: Endpoints

  #user_earnings_total
  #user_earnings_from_brand

  #brand_sales_total
  #brand_sales_from_reps


  #brand_metric_total
  #brand_metric_from_rep

  def user_earnings_from_brand(ga_user_id, ga_brand_id, start_date, end_date)
    request = {report_requests:[
              {metric:[{expession: "ga:metric2"}],
             dimensions:[{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: start_date, end_date: end_date}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id},ga:dimension3==#{ga_brand_id}"
    }]}

    response = ga_request(request)

    return response["reports"][0]["data"]["totals"][0]["values"][0]

  end

  def user_earnings_total(ga_user_id, start_date, end_date)
    request = {report_requests:[
              {metric:[{expession: "ga:metric2"}],
             dimensions:[{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: start_date, end_date: end_date}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id}"
    }]}

    response = ga_request(request)

    json = JSON.parse(response.to_json)

    return json

  end


end
