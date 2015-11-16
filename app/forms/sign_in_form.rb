class SignInForm
  include Virtus.model
  include ActiveModel::Validations

  attribute :email
  attribute :password

  validates :email, presence: true
  validates :password, presence: true
  validate :check_authentification

  def to_key
    [:email, :password]
  end

  def persisted?
    user.try :persisted?
  end

  def user
    @user ||= User.find_by(email: email)
  end

  private

  def check_authentification
    return if user.try :authenticate, password

    errors.add(:password, :user_or_password_invalid)
  end
end
