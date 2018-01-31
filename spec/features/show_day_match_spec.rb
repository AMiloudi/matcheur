# require 'rails_helper'
#
#
# describe "student" do
#   let!(:user) {create :user, name:"studentname", status:"student"}
#   let!(:match){create :match, studenta_id:user.id, studentb_id:user.id}
#   before { login_as user }
#
#   it "shows the match of today" do
#     visit root_path
#
#
#     expect(page).to have_text("studentname")
#   end
# end
#
# describe "admin" do
#   let!(:user) {create :user, status:"admin"}
#   before { login_as user }
#
#   it "shows the student matches of today" do
#     visit root_path
#
#     expect(page).to have_text("studentname")
#   end
# end
