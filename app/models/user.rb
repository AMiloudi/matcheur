class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  def generate_matches(day=Date.today)
    @day = day
    @students_array = get_students
    self.uneven  #checken if student array is even
    while @students_array != [] do
      picked_student = @students_array[rand(1...@student_array.length)]
      if duplicates(picked_student,@student_array.first) == false  #checking wheter a match exists already
        Match.new(day:@day,studenta:picked_student,studentb:@student_array.first)
        @student_array.delete(picked_student)
        @student_array.delete(@student_array.first) #emptying array from used students
      end
    end
  end

  def duplicates(student1,student2)  #add 9 days validation
    matches = get_student_matches(student1)
    duplicate = matches.find_by(studenta:student2).or(matches.find_by(studentb:student2))
    if duplicate
      true
    else
      false
    end
  end
  def uneven
    if @students_array.length%2 == 1 && User.find_by(name:"dummy")
      User.find_by(name:"dummy").destroy
      generate_matches
    elsif @students_array.length%2 == 1
      User.create(name:"dummy",password:"dummy1",email:"dummy@test.com",status:"student")
      generate_matches
    end
  end
  def get_student_matches(user)
    Match.where(studenta:user).or(Match.where(studentb:user))
  end
  def get_students
    return User.where(status:"student").all.ids
  end
end
