class BrandsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index,:show]

  helper_method :get_user
  helper_method :linkSales


  def index
    @brands = Brand.all
  end

  def dashboard
    #@brands = policy_scope(Brand)
    @brand = Brand.find(params[:brand_id])

    @wrapped_links = WrappedLink.where(brand_id: params[:brand_id])

    WrappedLink.reindex

    @search_results = WrappedLink.search(params[:search]) unless params[:search].blank?
    #, where: {brand_id: params[:brand_id]}

    if @search_results == nil
      @search_results = WrappedLink.where(brand_id: params[:brand_id])
    end

    @wrapped_links_sponsored = @wrapped_links.where(is_sponsored: true)

    @wrapped_links_supporter = @wrapped_links.where(is_sponsored: false)

    def get_user(id)
       @user = User.where(id: id)
       return @user
    end

    @totalLicks = @wrapped_links.sum(:link_clicks)

    @startDate = (Date.today.beginning_of_month).strftime("%Y-%m-%d")
    @endDate = Time.now.strftime("%Y-%m-%d")

    #GA calls##
    @gaController = GoogleAnalyticsController.new
    def linkSales(link)
      @link_earnings = @gaController.user_earnings_from_brand(link.user_id, link.brand_id, @startDate, @endDate)
      return @link_earnings
    end

    @totalSales = @gaController.brand_sales_total(@brand.id, @startDate, @endDate)


  end


  def register
    @brand = Brand.find(params[:brand_id])

  end

  def show
    @brand = Brand.find(params[:id])
  end

  def benefits
    @brand = Brand.find(params[:brand_id])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.user_id = current_user.id #add mainUserID to brand model

    if @brand.save
      redirect_to brand_register_path(@brand), notice: "Your brand was added successfully."
    else
      flash.now[:alert] = "Error creating brand profile. Please try again"
      render :new
    end
  end

  def edit
    @brand = Brand.find(params[:id])
    @collaborators = Collaborator.all #create collaborators model/controller
  end

  def update
    @brand = Brand.find(params[:id])

    @brand.assign_attributes(brand_params)

    if @brand.save
      flash[:notice] = "Brand profile was updated."
       redirect_to brand_path(@brand)
     else
       flash.now[:alert] = "Error saving brand profile. Please try again."
       render :edit
     end
   end

   def destroy
     @brand = Brand.find(params[:id])

     if @brand.destroy
       flash[:notice] = "\"#{@brand.companyName}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the brand."
      render :show
    end
  end

  private

  def brand_params
    params.require(:brand).permit(
      :photo,
      :domain,
      :companyName,
      :mainContactName,
      :mainContactEmail,
      :description,
      :giftDescription,
      :giftReferralThreshold,
      :sponsorSalesPercent,
      :bankNum,
      :bankRoutting,
      :campaignURL)
  end



end
