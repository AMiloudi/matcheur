require 'rails_helper'

 feature "generating matches", js: true do
   let!(:admin1) {create :user, status:"admin"}
   let!(:student1) {create :user}
   let!(:student2) {create :user}
   let!(:student3) {create :user}
   let!(:student4) {create :user}
   before { login_as admin1 }

   scenario "generate today" do
     visit new_match_path
     fill_in 'match_day', with: (Date.today).strftime("%m%d%Y")
     page.execute_script("$('.btn').click()")
     expect(page).to have_text("#{student1.name}","#{student2.name}","#{student3.name}","#{student4.name}")
   end
   pending "generate today and tomorrow" do
     visit new_match_path
     page.find('#match_day').set(((Date.today)).strftime("%m%d%Y"))
     page.execute_script("$('.btn').click()")
     page.find('#match_day').set(((Date.today)).strftime("%m%d%Y"))
     page.execute_script("$('.btn').click()")
     
     expect(page).to have_text("#{student1.name}", count:2)
     expect(page).to have_text("#{student2.name}", count:2)
     expect(page).to have_text("#{student3.name}", count:2)
     expect(page).to have_text("#{student4.name}", count:2)

   end
 end
