class Topic < ActiveRecord::Base
  
  mount_uploader :image, ImageUploader
  has_many :posts, dependent: :destroy

  scope :visible_to, ->(user){ user ? all : where(public: true)}
end
