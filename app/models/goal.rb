class Goal < ApplicationRecord
  validates :user_id, :title, presence: true
  validates :title, length: { minimum: 6 }

  belongs_to :user, 
    foreign_key: :user_id,
    class_name: :User

end
