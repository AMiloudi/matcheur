Match.destroy_all
User.destroy_all

admin1 = User.create(email:"test01@test.com",password:"test01",name:"henk",status:"admin")
admin2 = User.create(email:"test02@test.com",password:"test02",name:"sjaak",status:"admin")
student1 = User.create(email:"test03@test.com",password:"test03",name:"piet",status:"student")
student2 = User.create(email:"test04@test.com",password:"test04",name:"karel",status:"student")
student3 = User.create(email:"test05@test.com",password:"test05",name:"theresa",status:"student")
student4 = User.create(email:"test06@test.com",password:"test06",name:"karin",status:"student")
student5 = User.create(email:"test07@test.com",password:"test07",name:"jan",status:"student")
student6 = User.create(email:"test08@test.com",password:"test08",name:"tanya",status:"student")
student7 = User.create(email:"test09@test.com",password:"test09",name:"sanne",status:"student")
student8 = User.create(email:"test10@test.com",password:"test10",name:"robert",status:"student")
student9 = User.create(email:"test11@test.com",password:"test11",name:"bob",status:"student")
student10 = User.create(email:"test12@test.com",password:"test12",name:"frans",status:"student")

Match.create!( [
  { day:Date.today ,studentb_id:student2.id ,studenta_id:student1.id},
  { day:Date.today ,studentb_id:student4.id ,studenta_id:student3.id},
  { day:Date.today ,studentb_id:student6.id ,studenta_id:student5.id},
  { day:Date.today ,studentb_id:student7.id ,studenta_id:student8.id},
  { day:Date.today ,studentb_id:student9.id ,studenta_id:student10.id},
  ])
