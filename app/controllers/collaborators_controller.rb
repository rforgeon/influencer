class CollaboratorsController < ApplicationController

  def create

      @brand = Brand.find(params[:brand_id])
      @collaborator = Collaborator.new(collaborator_params)
      @collaborator.brand_id = @brand.id
      @allCollabs = Collaborator.all
      #check if collaborator is already on brand
      @allCollabs.each do |c|
        if @collaborator.email == c.email
          flash[:alert] ="#{@collaborator.email} is already a collaborator on this brand."
          redirect_to edit_brand_path(@brand.id) and return
        end
      end

      #add user in reference to email
      @users = User.all
      @user_emails = @users.map{|u|u.email}
        if @user_emails.any?{@collaborator.email}
          @users.each do |u|
            if u.email == @collaborator.email
              @brand.user_id = u.id
            end
          end
        else
          flash[:alert] ="Please add the email of a current registered user."
          redirect_to edit_brand_path(@brand.id) and return
        end



      if @collaborator.save
        redirect_to edit_brand_path(@brand.id), notice: "collaborator was saved successfully."
      else
        flash.now[:alert] = "Error creating collaborator. Please try again."
        render :new
      end
    end

    def new
      @collaborator = Collaborator.new
    end

    def destroy
     @collaborator = Collaborator.find(params[:id])

     if @collaborator.destroy
       flash[:notice] = "#{@collaborator.email} was removed as a collaborator."
       redirect_to brands_path
     else
       flash.now[:alert] = "There was an error removing #{@collaborator.email}."
       render :show
     end
   end

    private

    def collaborator_params
      params.require(:collaborator).permit(:email,:brand_id)
    end





end
