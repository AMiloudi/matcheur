class Match < ApplicationRecord
  belongs_to :studenta, :class_name => 'User'
  belongs_to :studentb, :class_name => 'User'
  def self.generate_matches(day=Date.today)
    @day = day
    @students_array = []
    @students_array = self.get_students
    uneven  #checken if student array is even
    while @students_array != [] do
      picked_student = User.find(@students_array[rand(1...(@students_array.length))])
      first_student = User.find(@students_array.first)
      p picked_student
      if self.duplicates(picked_student,first_student) == false  #checking wheter a match exists already
        Match.create(day:@day,studenta:picked_student,studentb:first_student)
        @students_array.delete(picked_student.id)
        @students_array.delete(@students_array.first) #emptying array from used students
      end
    end
  end

  def self.duplicates(student1,student2)
    #add 9 days validation
    matches = self.get_student_matches(student1)
    duplicate = self.check_past_matches(matches,student2)
    duplicate = duplicate.join
    if duplicate == ""
      false
    else
      true
    end
  end

  def self.check_past_matches(matches,student2)
    i = 1
    dupe = []
    (self.get_students.length-1).times do
      dupe.push(matches.where(studentb:student2,day:(Date.today-i)).or(matches.where(studenta:student2,day:(Date.today-i))).ids)
      i += 1
    end
    return dupe
  end

  def self.uneven
    if @students_array.length%2 == 1 && User.find_by(name:"dummy")
      User.find_by(name:"dummy").destroy
      generate_matches
    elsif @students_array.length%2 == 1
      User.create(name:"dummy",password:"dummy1",email:"dummy@test.com",status:"student")
      generate_matches
    end
  end

  def self.get_student_matches(user)
    Match.where(studenta:user).or(Match.where(studentb:user))
  end
  def self.get_students
    return User.where(status:"student").all.ids
  end
end
