class User < ApplicationRecord
    has_many :posts
    has_many :commentaries
    acts_as_saver

    has_many :posts
    has_many :commentaries
    has_many :reviews
    has_many :poll_votes, dependent: :destroy
    has_many :vote_options, through: :poll_votes
    has_many :polls
    has_one :country


    VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\z/
    validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }
    
    rolify
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    def avatar
        email_address = self.email.downcase
        hash = Digest::MD5.hexdigest(email_address)

        # compile URL which can be used in <img src="RIGHT_HERE"...
        image_src = "https://www.gravatar.com/avatar/#{hash}"  
    end

    def voted_for?(poll)
        vote_options.any? {|v| v.poll == poll }
    end

    def favorite_cities
        array = Array.new
        self.find_saved_items.each do |p|
            if p.class == City
                array << p
            end
        end
        array
    end

    def favorite_hotels
        array = Array.new
        self.find_saved_items.each do |p|
            if p.class == Hotel
                array << p
            end
        end
        array
    end

    def favorite_citywalks
        array = Array.new
        self.find_saved_items.each do |p|
            if p.class == Citywalk
                array << p
            end
        end
        array
    end

    def favorite_restaurants
        array = Array.new
        self.find_saved_items.each do |p|
            if p.class == Restaurant
                array << p
            end
        end
        array
    end

end
