User.destroy_all

admin1 = User.create(email:"test01@test.com",password:"test01",name:"henk",status:"admin")
admin2 = User.create(email:"test02@test.com",password:"test02",name:"sjaak",status:"admin")
student1 = User.create(email:"test03@test.com",password:"test03",name:"piet",status:"student")
student2 = User.create(email:"test04@test.com",password:"test04",name:"karel",status:"student")
student3 = User.create(email:"test05@test.com",password:"test05",name:"anne",status:"student")
student4 = User.create(email:"test06@test.com",password:"test06",name:"karin",status:"student")
student5 = User.create(email:"test07@test.com",password:"test07",name:"jan",status:"student")
student6 = User.create(email:"test08@test.com",password:"test08",name:"janne",status:"student")
student7 = User.create(email:"test09@test.com",password:"test09",name:"sanne",status:"student")
student8 = User.create(email:"test10@test.com",password:"test10",name:"hans",status:"student")
student9 = User.create(email:"test11@test.com",password:"test11",name:"ans",status:"student")
student10 = User.create(email:"test12@test.com",password:"test12",name:"frans",status:"student")

Match.create!( [
  { day:Time.now.strftime("%Y-%m-%d") ,match:student2.name ,user:student1},
  { day:Time.now.strftime("%Y-%m-%d") ,match:student4.name ,user:student3},
  { day:Time.now.strftime("%Y-%m-%d") ,match:student6.name ,user:student5},
  { day:Time.now.strftime("%Y-%m-%d") ,match:student7.name ,user:student8},
  { day:Time.now.strftime("%Y-%m-%d") ,match:student9.name ,user:student10},
  { day:(Time.now-86400).strftime("%Y-%m-%d") ,match:student7.name ,user:student3},

  ])
