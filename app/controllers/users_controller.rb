 class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :enter_credit_card]
  before_filter :correct_user,   only: [:edit, :update, :enter_credit_card]
  before_filter :admin_user,     only: :destroy
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
    #@users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.xml  { render xml: @users }
    end
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    # creating an items array to get users all items
    @items = current_user.items

  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      format.xml  { render xml: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # GET /users/1/enter_credit_card
  def enter_credit_card
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: 'Welcome to BestBay!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {
          flash[:success] = "Profile updated"
          sign_in @user
          redirect_to @user  }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
