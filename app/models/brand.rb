class Brand < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators

  has_many :wrapped_links
  has_many :users, through: :wrapped_links



end
