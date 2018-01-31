require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is invalid without a name" do
      user = User.new(name:nil)
      user.valid?
      expect(user.errors).to have_key(:name)
    end
    it "is invalid without a status" do
      user = User.new(status:nil)
      user.valid?
      expect(user.errors).to have_key(:status)
    end
  end
end
