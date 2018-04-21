module PhotosHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_photos_path
    elsif action_name == 'edit'
      photo_path
    end
  end
end
