class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :happened?, :admin?

  def happened?(event)
    event.time < Time.now
  end

  def admin?(user, g)
    !!(user.id == g.admin_id)
  end
end
