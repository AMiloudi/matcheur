class Match < ApplicationRecord
  belongs_to :studenta, :class_name => 'User'
  belongs_to :studentb, :class_name => 'User'
end
