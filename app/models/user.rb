class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  # has_many :matches, dependent: :destroy, foreign_key: :studentb
  # has_many :matches, foreign_key: :studenta, dependent: :destroy

end
