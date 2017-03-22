class WrappedLink < ApplicationRecord

  belongs_to :user
  belongs_to :brand

  # searchkick

  def self.search(search)
    where("user_id ILIKE ?", "%#{search}%")
  end


end
