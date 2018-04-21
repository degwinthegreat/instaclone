class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorite_photos.all
  end

  def create
    @photo_id = params[:photo_id]
    @user_id = current_user.id
    favorite = Favorite.create(user_id: @user_id,photo_id: @photo_id)
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんのつぶやきをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find(params[:id]).destroy
    redirect_to photos_url, notice: "#{favorite.photo.user.name}さんのつぶやきをお気に入り解除しました"
  end
end
