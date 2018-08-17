require 'rails_helper'

RSpec.describe Goal, type: :model do
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:title)}
  it {should validate_length_of(:title).is_at_least(6)}
  it {should belong_to(:user)}
end
