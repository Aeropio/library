require 'jwt'


class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #after_action :update_local_non_local_attributes,  only: [:create, :edit, :update]


  # you will need to install 'jwt' gem first via 'gem install jwt' or in your project Gemfile


  # GET /users
  # GET /users.json
   METABASE_SITE_URL = "http://localhost:13663"
  METABASE_SECRET_KEY = "827518359bc24650fc1de36c3eab833126cae94e2346de9cec58c9a2707d940c"
  def index
        @status = 'pending'

    @users = User.where(card_status:"pending")
  end

  def approved_users_list
        @status = 'approved'

    @users = User.where(card_status:"approved")
    respond_to do |format|
     format.html { render :index , locals: {status: "Approved"}}
     format.json { head :no_content }
    end
  end

  def rejected_users_list
    @status = 'rejected'
    @users = User.where(card_status:"rejected")
    respond_to do |format|
     format.html { render :index , locals: {status: "Rejected"}}
     format.json { head :no_content }
    end
  end

  def pending_users_list
    @users = User.where(card_status:"pending")
    respond_to do |format|
     format.html { render :index , locals: {status: "Pending"}}
     format.json { head :no_content }
    end
  end

  def metabase
    payload = {
      :resource => {:question => 1},
      :params => {
        
      },
      :exp => Time.now.to_i + (60 * 10) # 10 minute expiration
    }
    token = JWT.encode payload, METABASE_SECRET_KEY

    @iframe_url = METABASE_SITE_URL + "/embed/question/" + token + "#bordered=true&titled=true"
  end

  def completed_work_units
    payload = {
      :resource => {:question => 4},
      :params => {
        
      },
      :exp => Time.now.to_i + (60 * 10) # 10 minute expiration
    }
    token = JWT.encode payload, METABASE_SECRET_KEY

    @iframe_url = METABASE_SITE_URL + "/embed/question/" + token + "#bordered=true&titled=true"
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    date_birth = Date::strptime(user_params[:dob], "%m-%d-%y")
    user_params[:dob] = date_birth
    @user = User.new(user_params)


    respond_to do |format|
        if @user.save
          #AdminMailer.notify_admin_email.deliver_now
          UserMailer.with(user: @user).sign_up_notification.deliver
          @user=User.new
          format.html { render 'users/new', locals: {submit_success: true} }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve_user
    user = User.where(email: params["email"]).last
    user.card_status = "approved"
    user.save(validate:false)
    UserMailer.with(user: user).approved_notification.deliver
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully approved.' }
      format.json { head :no_content }
    end
  end

  def reject_user
    user = User.where(email: params["email"]).last
    user.card_status = "rejected"
    user.save(validate:false)
    UserMailer.with(user: user).rejected_notification.deliver
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { head :no_content }
    end
  end

  def reports
  end
  
  def get_county_name
    county_zips = %w[28031 28035 28036 28070 28078 28105 28106 28126 28130 28134]
    zip_code = params["zip"]
    if zip_code.length==5 
      if zip_code == '28200'
        is_county = false
      elsif zip_code.start_with?('282') or county_zips.include? zip_code
        is_county = true
      else
        is_county = false
      end
    else
      is_county = false
    end
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { render json: {is_county: is_county} }
    end
  end

  def upload_identity_number
    user = User.where(id: params[:id])
    user.identity_number = params[:file]
    user.save
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { render json: {file_uploaded: "success"} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(User.attribute_names)
    end

    # def update_local_non_local_attributes
    #   user = User.where(params[:id]).last

    # end
end
