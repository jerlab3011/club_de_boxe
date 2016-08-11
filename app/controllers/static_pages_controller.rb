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
    @memberships = Membership.all.unscoped
    @active_memberships = @memberships.where("end_date > ? AND start_date <= ?", Date.today, Date.today)
    @users = User.all.unscoped
    @active_users = @users.joins(:memberships).where('memberships.end_date > ? AND memberships.start_date <= ?', Date.today, Date.today)
  end
  
  def prices
  end
end
