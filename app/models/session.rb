class Session
  include ActiveModel::Model
  attr_accessor :open_id, :user

  validate :check_open_id

  def check_open_id
    @user ||= User.find_by open_id: open_id
  end



end