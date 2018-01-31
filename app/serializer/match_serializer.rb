class MatcheSerializer < ActiveModel::Serializer
attributes :day, :studenta_id, :studentb_id

belongs_to :studenta, :class_name => 'User'
belongs_to :studentb, :class_name => 'User'

end
