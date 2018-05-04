class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only:[:new, :edit, :show, :index]

  def index
    @photos = Photo.all
  end

  def new
    if params[:back]
      @photo = Photo.new(photo_params)
    else
      @photo = Photo.new
    end
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    @photo.photo.retrieve_from_cache! params[:cache][:photo] if params[:cache][:photo].present?
    respond_to do |format|
      if @photo.save
        PhotoMailer.photo_mailer(@current_user, @photo).deliver
        format.html { redirect_to @photo, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @favorite = current_user.favorites
    @favorite = @favorite.where(photo_id: @photo.id)
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice:"削除しました！"
  end

  def confirm
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    render :new if @photo.invalid?
  end

  private
  def photo_params
    params.require(:photo).permit(:content, :photo, :user_id, :photo_id, :photo_cache)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def login_check
    unless logged_in?
      flash[:notice] = "権限がありません"
      redirect_to new_session_path
    end
  end
end
