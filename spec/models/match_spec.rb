require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "validations" do
    it "is invalid without a day" do
      match = Match.new(day:nil)
      match.valid?
      expect(match.errors).to have_key(:day)
    end
  end
end
