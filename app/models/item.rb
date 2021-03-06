class Item < ActiveRecord::Base
  has_many :bids
  has_many :purchases

  validates :base_price,:category, :description, :name,:quantity, presence: true
  validates :name, length: { maximum: 256 }
  validates :description, length: { maximum: 1024 }
  has_attached_file :pic, :styles =>
                 { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :user

  attr_accessible :base_price, :category, :description, :image_1, :image_2, :image_3, :name, :user_id, :pic, :quantity

end
