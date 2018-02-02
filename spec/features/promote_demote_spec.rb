require 'rails_helper'

feature "demoting and promoting", js:true do
  let!(:admin1) {create :user, status:"admin"}
  let!(:admin2) {create :user, status:"admin"}
  let!(:student1) {create :user}
  let!(:student2) {create :user}
  before { login_as admin1 }

  scenario "demote admin and promote student" do
    visit users_path

    page.execute_script("$('.btn[id=#{admin2.id}]').click()")

    expect(page).to have_text("admin", count: 1)
    expect(page).to have_text("student", count: 3)
    page.execute_script("$('.btn[id=#{student2.id}]').click()")
    expect(page).to have_text("admin", count: 2)
    expect(page).to have_text("student", count: 2)
  end
end
