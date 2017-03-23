class GoogleAnalyticsController < ApplicationController

  require 'json'


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

    request = {report_requests:[
            {metrics:[{expression: "ga:sessions"}],
             dimensions:[{name:"ga:date"},{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: (Date.today - 30).strftime("%Y-%m-%d"), end_date: Time.now.strftime("%Y-%m-%d")}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id},ga:dimension3==#{ga_brand_id}"
    }]}

    results = ga_request(request)

    json = JSON.parse(results.to_json)

    return json["reports"][0]["data"]["totals"][0]["values"][0]

  end


  #TODO: MULTIPLY BY PERCENTAGE DESIGNATED BY COMPANY
  def user_earnings_from_brand(ga_user_id, ga_brand_id, start_date, end_date)

    request = {report_requests:[
              {metrics:[{expression: "ga:metric2"}],
             dimensions:[{name:"ga:dimension1"},{name:"ga:dimension3"}],
             date_ranges:[{start_date: start_date, end_date: end_date}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id},ga:dimension3==#{ga_brand_id}"
    }]}

    results = ga_request(request)

    json = JSON.parse(results.to_json)["reports"][0]["data"]["totals"][0]["values"][0]

    return json

  end

  #TODO: MULTIPLY BY PERCENTAGE DESIGNATED BY COMPANY
  def user_earnings_total(ga_user_id, startDate, endDate)

    request = {report_requests:[
              {metrics:[{expression:"ga:metric2"}],
             dimensions:[{name:"ga:dimension1"}],
             date_ranges:[{start_date: startDate, end_date: endDate}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension1==#{ga_user_id}"
    }]}

    results = ga_request(request)

    json = JSON.parse(results.to_json)["reports"][0]["data"]["totals"][0]["values"][0]

    return json

  end

  def brand_sales_total(ga_brand_id, startDate, endDate)

    request = {report_requests:[
              {metrics:[{expression:"ga:metric2"}],
             dimensions:[{name:"ga:dimension3"}],
             date_ranges:[{start_date: startDate, end_date: endDate}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension3==#{ga_brand_id}"
    }]}

    results = ga_request(request)

    json = JSON.parse(results.to_json)["reports"][0]["data"]["totals"][0]["values"][0]

    return json

  end

  def brand_sales_from_rep(ga_brand_id, ga_user_id, startDate, endDate)

    request = {report_requests:[
              {metrics:[{expression:"ga:metric2"}],
             dimensions:[{name:"ga:dimension3"},{name:"ga:dimension1"}],
             date_ranges:[{start_date: startDate, end_date: endDate}],
             view_id:"ga:141580290",
             filters_expression: "ga:dimension3==#{ga_brand_id},ga:dimension1==#{ga_user_id}"
    }]}

    results = ga_request(request)

    json = JSON.parse(results.to_json)["reports"][0]["data"]["totals"][0]["values"][0]

    return json

  end



end
