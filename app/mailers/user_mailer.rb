class UserMailer < ApplicationMailer
  include ApplicationHelper

  def success_notification(user)
    @user = user
    update_user_status(@user.email)
    mail(to: @user.email, subject: 'Stock Market App Registration Successful!')
  end
end