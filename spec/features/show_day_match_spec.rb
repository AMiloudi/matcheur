require 'rails_helper'


feature "login student" do
  let!(:user1) {create :user}
  let!(:user2) {create :user}

  let!(:match){create :match, studenta_id:user1.id, studentb_id:user2.id,day:Date.today}
  before { login_as user1 }

  scenario "shows the match of today" do
    visit root_path
    expect(page).to have_text(user1.name)
  end
end

feature "login admin"  do
  let!(:user1) {create :user, status:"admin"}
  let!(:user3) {create :user}
  let!(:user2) {create :user}
  let!(:match1) {create :match, studenta:user2,studentb:user3,day:Date.today}
  before { login_as user1 }

  scenario "shows the student matches of today" do
    visit root_path

    expect(page).to have_text(user2.name)
    expect(page).to have_text(user3.name)

  end
end
