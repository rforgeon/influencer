class BrandsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index,:show]

  def index
    @brands = Brand.all
  end

  def dashboard
    @brands = policy_scope(Brand)
  end

  def register
    @brand = Brand.find(params[:id])

  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    #@brand.user_id = current_user.id #add mainUserID to brand model

    if @brand.save
      redirect_to @brand, notice: "Your brand profile was created successfully."
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
       redirect_to dashboard
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
