class Product < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend Paginator
  set_content_per_page(8)

  has_one_attached :image do |attachable|
    attachable.variant :card, resize_and_pad: [ 500, 600 ]
  end

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true

  has_many :stocks
  has_many :order_products

  def image_url
    image.attached? ? url_for(self.image) : nil
    # image.url
  end
end
