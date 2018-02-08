class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def possible_collaborators
    # User.all.reject { |u| u.id == user.id || users.include?(u) }

    invalid_user_ids = users.pluck(:id) << user.id
    User.where.not(id: invalid_user_ids)
  end
end
