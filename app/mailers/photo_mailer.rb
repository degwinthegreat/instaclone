class PhotoMailer < ApplicationMailer
  def photo_mailer(user, photo)
    @content = photo.content
    @user = user

    mail to: user.email, subject: "投稿しました"
  end
end
