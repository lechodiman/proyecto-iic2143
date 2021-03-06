class Citywalk < ApplicationRecord
	belongs_to :city
    has_many :reviews, as: :reviewable
    acts_as_saveable

    VALID_TEXT_REGEX = /\A[a-zA-Z ]+\z/
  	validates :name, presence: true, format: { with: VALID_TEXT_REGEX }, uniqueness: { case_sensitive: false }
  	validates :description, presence: true
  	validates :place, presence: true, format: { with: VALID_TEXT_REGEX }, uniqueness: { case_sensitive: false }

  	mount_uploader :image, ImageUploader
  	resourcify

  	def mean	
        if self.reviews.blank?
            0
        else
            average_review = self.reviews.average(:rating).round(2)
        end
    end
end
