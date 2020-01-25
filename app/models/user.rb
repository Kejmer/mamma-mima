class User < ApplicationRecord
  acts_as_authentic do |c|
    c.log_in_after_create = false
  end

  # Validate email, login, and password as you see fit.
  #
  # Authlogic < 5 added these validation for you, making them a little awkward
  # to change. In 4.4.0, those automatic validations were deprecated. See
  # https://github.com/binarylogic/authlogic/blob/master/doc/use_normal_rails_validation.md
  validates :email,
    format: {
      with: /@/,
      message: "should look like an email address."
    },
    length: { maximum: 100 },
    uniqueness: {
      case_sensitive: false,
      if: :will_save_change_to_email?
    }

  validates :password,
    confirmation: { if: :require_password? },
    length: {
      minimum: 8,
      if: :require_password?
    }
  # validates :password_confirmation,
  #   length: {
  #     minimum: 8,
  #     if: :require_password?
  # }

  def admin?
    self.position == "admin"
  end
end