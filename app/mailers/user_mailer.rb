class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Twee77er | Account activation"
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Twee77er | Password reset"
  end
end
