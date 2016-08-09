class StaticPagesController < ApplicationController
  def home
  end

  def schedule
  end

  def contact
  end
  
  def stats
    @users = User.all
    @memberships = Membership.all
    @active_memberships = Membership.where("end_date > ? AND start_date <= ?", Date.today, Date.today).unscoped
    @active_users = @memberships.map(&:user)
  end
end
