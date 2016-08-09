class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:stats]
  before_action :admin_user,     only: [:stats]
  
  def home
  end

  def schedule
  end

  def contact
  end
  
  def stats
    @users = User.all
    @memberships = Membership.all
    @active_memberships = Membership.where("end_date > ? AND start_date <= ?", Date.today, Date.today)
    @active_users = @memberships.map(&:user)
  end
end
