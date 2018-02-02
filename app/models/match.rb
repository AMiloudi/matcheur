class Match < ApplicationRecord
  belongs_to :studenta, :class_name => 'User'
  belongs_to :studentb, :class_name => 'User'

  validates :day, presence: true

  def self.generate_matches(day=Date.today)
    Match.where(day:day).destroy_all

    students_array = []
    students_array = self.get_students
    uneven(students_array)
    students_array = self.get_students
    selected_dates= (day-(students_array.count-1)..(day-1))
    loop do
      if students_array.count/2 == Match.where(day:day).count
        break
      end
      student1 = User.find(students_array[rand(0..((students_array.count)-1))])
      if self.has_match(student1,day)
        next
      end

      unique_students = []
      loop do
        if (unique_students.uniq).count == students_array.count
          generate_matches(day)
        end
        student2= User.find(students_array[rand(0..((students_array.count)-1))])
        unique_students << student2.id
        case
        when student1 == student2
          next
        when self.has_match(student2,day)
          next
        when self.duplicates(student1, student2, selected_dates)
          next
        else
          Match.create(day:day,studenta:student2,studentb:student1)
          puts Match.where(day:day).count.to_s + " hello"
        end
        break
      end
    end
  end

  def self.has_match(student,day)
    if Match.where(studenta_id:student,day:day).or(Match.where(studentb_id:student,day:day)).ids != []
      p Match.where(studenta_id:student,day:day).or(Match.where(studentb_id:student,day:day)).ids
      true
    else
      false
    end
  end

  def self.duplicates(student1,student2, selected_dates)
    found_matches = []
    found_matches << Match.where(studenta_id:student1.id, studentb_id:student2.id, day: selected_dates).ids
    if found_matches == [[]]
      found_matches << Match.where(studenta_id:student2.id, studentb_id:student1.id, day: selected_dates).ids
      if found_matches == [[], []]
        return false
      end
    end
    return true
  end

  def self.uneven(students_array)
    dummy = User.find_by(name:"dummy")

    if students_array.length%2 == 1 && dummy
      Match.where(studenta_id:dummy).or(Match.where(studentb_id:dummy)).destroy_all
      dummy.destroy
    elsif students_array.length%2 == 1
      User.create(name:"dummy",password:"dummy1",email:"dummy@test.com",status:"student")
    end
  end

  def self.get_students
    return User.where(status:"student").all.ids
  end
end
