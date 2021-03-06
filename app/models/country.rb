class Country < ApplicationRecord
    has_many :cities
    mount_uploader :image, ImageUploader
    has_many :users

    VALID_NAME_REGEX = /\A[a-zA-Z ]+\z/
    validates :name, presence: true, format: { with: VALID_NAME_REGEX }, uniqueness: { case_sensitive: false }
    validates :description, presence: true

    validates :image, presence: true
    resourcify
end
