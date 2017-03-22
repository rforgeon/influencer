class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :user_name

  has_many :collaborators
  
  has_many :wrapped_links
  has_many :brands, through: :wrapped_links
end
