class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  after_initialize :set_default_role, :if => :new_record?

  enum role: [:standard, :premium, :admin]

  belongs_to :role
  has_many :wikis

  private

  def set_default_role
    self.role ||= Role.find_by_name('standard')
  end

end
