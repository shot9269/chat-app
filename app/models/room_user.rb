class RoomUser < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  belongs_to :room
end
