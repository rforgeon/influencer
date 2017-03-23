class TransactionsController < ApplicationController

  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging



  # create array of brands ✅
  #
  # for each brand, collect sponsors ✅
  #
  # for each brand sponsor, collect $ ammount ✅
  #
  # send invoice to each brand

  def test
    amount = total_payment_for_sponsors('84af46ae-c664-438d-976f-0ee469703724')
    render json: amount

  end


  def sponsored_list(brand_id)
    @brand = Brand.find(brand_id)
    sponsoredArray = []
    @brand.wrapped_links.each do |s|
      if s.is_sponsored
        sponsoredArray.push(s)
      end
    end
    return sponsoredArray
  end

  def payment_amount(brand_id,user)

    @startDate = (Date.today.beginning_of_month).strftime("%Y-%m-%d")
    @endDate = Time.now.strftime("%Y-%m-%d")

    #GA Sessions##
    @gaController = GoogleAnalyticsController.new
    @total_earnings = @gaController.user_earnings_from_brand(user.user_id, brand_id, @startDate, @endDate)


    return (@total_earnings.to_i)*user.sponsorship_percent

  end

  def total_payment_for_sponsors(brand_id)
    @arrayOfSponsors = sponsored_list(brand_id)
    sum = 0
    @arrayOfSponsors.each do |s|
      @earnings = payment_amount(brand_id,s)
      sum = sum + @earnings
    end
    return sum
  end


  def send_invoice
    # brandEmail = params['brandEmail']
    # lickLinkEmail = params['lickLickEmail']
    # repUserName = params['repUserName']
    # repPayment = params['repPayment']

    @invoice = Invoice.new({
      "merchant_info" => {
        "email" => "rforgeon@gmail.com",
        "first_name" => "Ralph",
        "last_name" => "Forgeon",
        "business_name" => "Lick Link",
        "phone" => {
          "country_code" => "001",
          "national_number" => "2087210021"
        },
          "address" => {
          "line1" => "1234 Main St.",
          "city" => "Portland",
          "state" => "OR",
          "postal_code" => "97217",
          "country_code" => "US"
        }
      },
      "billing_info" => [ { "email" => "rforgeon@gmail.com" } ],
      "items" => [
        {
          "name" => "Ralph",
          "quantity" => 1,
          "unit_price" => {
            "currency" => "USD",
            "value" => 10
          }
        }
      ],
      "note" => "Medical Invoice 16 Jul, 2013 PST",
      "payment_term" => {
        "term_type" => "NET_45"
      },
      "shipping_info" => {
        "first_name" => "Sally",
        "last_name" => "Patient",
        "business_name" => "Not applicable",
        "phone" => {
          "country_code" => "001",
          "national_number" => "5039871234"
        },
        "address" => {
          "line1" => "1234 Broad St.",
          "city" => "Portland",
          "state" => "OR",
          "postal_code" => "97216",
          "country_code" => "US"
        }
      }
    })

    if @invoice.create
      logger.info "Invoice[#{@invoice.id}] created successfully"
      #if invoice created successfully - send the invoice
      if @invoice.send_invoice
         logger.info "Invoice[#{@invoice.id}] send successfully"
       else
         logger.error @invoice.error.inspect
       end
    else
      logger.error @invoice.error.inspect
    end


 end


end
