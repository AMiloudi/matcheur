class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  # has_many :matches, primary_key: :studenta, dependent: :destroy
  # has_many :matches, primary_key: :studentb, dependent: :destroy

  validates :name, presence: true
  validates :status, presence: true
end
