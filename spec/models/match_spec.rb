require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "validations" do
    it "is invalid without a day" do
      match = Match.new(day:nil)
      match.valid?
      expect(match.errors).to have_key(:day)
    end
  end
  describe "method get_students" do
    let!(:user1) {create :user}
    let!(:user2) {create :user}
    let!(:user3) {create :user}
    it "has all students"  do
      students_array = Match.get_students
      expect(students_array).to include(user1.id,user2.id,user3.id)
    end
  end
  describe "method uneven" do
    let!(:user1) {create :user}
    let!(:user2) {create :user}
    let!(:user3) {create :user}

    it "adds dummy on uneven" do
      students_array = Match.get_students
      Match.uneven(students_array)
      students_array = Match.get_students
      expect(students_array.count).to equal(4)
      dummy = User.find_by(name:"dummy")
      expect(students_array).to include(dummy.id)
    end
    it "remove dummy on uneven" do
      user4 = User.new
      user5 = User.new(name:"dummy")
      students_array = Match.get_students
      Match.uneven(students_array)
      students_array = Match.get_students
      expect(students_array.count).to equal(4)
      expect(students_array).not_to include(user5.id)
    end
    it "doesnt add dummy on even" do
      user4 = User.new
      students_array = Match.get_students
      Match.uneven(students_array)
      students_array = Match.get_students
      expect(students_array.count).to equal(4)
    end
  end
  describe "method duplicates" do
    let!(:user1) {create :user}
    let!(:user2) {create :user}
    let!(:user3) {create :user}
    let!(:user4) {create :user}
    let!(:match1) {create :match, studenta:user1, studentb:user2,day:(Date.today)-1 }
    let!(:match2) {create :match, studenta:user1, studentb:user3,day:(Date.today)-2 }
    let!(:match3) {create :match, studenta:user3, studentb:user4,day:(Date.today)-1 }
    let!(:match4) {create :match, studenta:user2, studentb:user4,day:(Date.today)-2 }
    it "doesnt have match" do
      date_range = (Date.today)-2..(Date.today)
      duplicate = Match.duplicates(user1.id,user4.id,date_range)
      expect(duplicate).to equal(true)
    end
    it "does have match" do
      date_range = (Date.today)-2..(Date.today)
      duplicate = Match.duplicates(user1.id,user2.id,date_range)
      expect(duplicate).to equal(false)
    end
    it "has match outside range" do
      match5 = Match.new(studenta:user1, studentb:user4,day:(Date.today)-5 )
      date_range = (Date.today)-2..(Date.today)
      duplicate = Match.duplicates(user1.id,user4.id,date_range)
      expect(duplicate).to equal(true)
    end
  end
  describe "method generate_matches" do
    let!(:user1) {create :user}
    let!(:user2) {create :user}
    let!(:user3) {create :user}
    let!(:user4) {create :user}
    it "generates 1 day" do
      Match.generate_matches(Date.today)
      matches = Match.all
      expect(matches.count).to equal(2)
    end
    it "generates 2 days" do
      Match.generate_matches(Date.today)
      Match.generate_matches((Date.today)+1)
      matches = Match.all
      expect(matches.count).to equal(4)
    end
    it "generates 3 days" do
      Match.generate_matches(Date.today)
      Match.generate_matches((Date.today)+1)
      Match.generate_matches((Date.today)+2)
      matches = Match.all
      expect(matches.count).to equal(6)
    end
    it "generates 4 days" do
      Match.generate_matches(Date.today)
      Match.generate_matches((Date.today)+1)
      Match.generate_matches((Date.today)+2)
      Match.generate_matches((Date.today)+3)
      matches = Match.all
      expect(matches.count).to equal(8)
    end
  end
end
