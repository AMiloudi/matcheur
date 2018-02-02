class Match < ApplicationRecord
  belongs_to :studenta, :class_name => 'User'
  belongs_to :studentb, :class_name => 'User'

  validates :day, presence: true

  def self.generate_matches(day=Date.today)
    Match.where(day:day).destroy_all

    students_array = []
    students_array = self.get_students
    uneven(students_array)
    students_array = self.get_students.shuffle

    selected_dates = (day-(students_array.count-2)..(day-1))

    remember_chosen_ones = []

    students_array.each_with_index do |student,index|
      break if students_array.count/2 == Match.where(day:day).count
      next if remember_chosen_ones.include? index
      remember_chosen_ones.push(index)
      students_array.each_with_index do |other_student,other_index|
        next if remember_chosen_ones.include? other_index
        if self.duplicates(student,other_student,selected_dates)
          remember_chosen_ones.push(other_index)
          Match.create(day:day,studenta_id:student,studentb_id:other_student)
          break
        end
        if other_index == (students_array.count)-1
          self.generate_matches(day)
        end
      end
    end
  end


  def self.duplicates(student,other_student, selected_dates)
    found_matches = []
    found_matches << Match.where(studenta_id:student, studentb_id:other_student, day: selected_dates).ids
    if found_matches == [[]]
      found_matches << Match.where(studenta_id:other_student, studentb_id:student, day: selected_dates).ids
      if found_matches == [[], []]
        return true
      end
    end
    return false
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
