class SendInvoicesJob < ActiveJob::Base

  queue_as :default

  require 'paypal-sdk-rest'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  def perform(*args)
    
    puts "enter perform"
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

  def send_invoice
    brandEmail = params['brandEmail']
    lickLinkEmail = params['lickLickEmail']
    repUserName = params['repUserName']
    repPayment = params['repPayment']


 end

end
