class WrapppedLinksController < ApplicationController
  before_filter :authenticate_user!


  def create
    @link = WrappedLink.new

    @brand = Brand.find(params[:brand_id])
    @link.link = "https://licklink.com/#{current_user.name}-#{@brand.companyName}"
    @link.user_id = current_user.id
    @link.brand_id = @brand.id

    if @link.save
      redirect_to root, notice: "Your lickable link was created successfully."
    else
      flash.now[:alert] = "Error creating link. Please try again"
      render :new
    end

  end



    private

    def wrapped_link_params
      params.require(:wrapped_link).permit(
        :link,
        :user_id,
        :brand_id
      )
    end

end
