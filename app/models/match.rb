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
    p students_array
    selected_dates = (day-(students_array.count-1)..(day))
    remember_chosen_ones = []
    students_array.each_with_index do |student,index|
      p Match.where(day:day).count
      p students_array
      break if students_array.count/2 == Match.where(day:day).count
      next if remember_chosen_ones.include? index
      remember_chosen_ones.push(index)
      p student.to_s + remember_chosen_ones.to_s
      students_array.each_with_index do |other_student,other_index|
        p student.to_s+other_student.to_s
        next if remember_chosen_ones.include? other_index
        # lookup_a_to_b = Match.where(studenta_id:student,day:selected_dates).or(Match.where(studentb_id:other_student,day:selected_dates)).ids
        # lookup_b_to_a = Match.where(studenta_id:other_student,day:selected_dates).or(Match.where(studentb_id:student,day:selected_dates)).ids
        # lookup_a_to_b = lookup_a_to_b.join
        # lookup_b_to_a = lookup_b_to_a.join
        # p lookup_a_to_b +"a and b "+ lookup_b_to_a
        if self.duplicates(student,other_student,selected_dates)
          remember_chosen_ones.push(other_index)
          Match.create(day:day,studenta_id:student,studentb_id:other_student)
          p Match.where(day:day).count
          p remember_chosen_ones
          break
        end
        if other_index == (students_array.count)-1 || (students_array.count)-1 == remember_chosen_ones.count
          p other_index
          p "failed to find match, matches found:"+ Match.where(day:day).count.to_s
          self.generate_matches(day)
        end
      end
    end
  end
    # unique_students = []
    #
    # loop doif
    #   if students_array.count/2 == Match.where(day:day).count
    #     puts Match.where(day:day).count.to_s + " buh bye"
    #     puts students_array.count/2
    #     p unique_students.uniq
    #     break
    #   else
    #     puts "not done yet " + Match.where(day:day).count.to_s
    #     puts students_array.count/2
    #   end
    #   student1 = User.find(students_array[rand(0..((students_array.count)-1))])
    #   if self.has_match(student1,day)
    #     next
    #   end
    #   unique_students = []
    #   loop do
    #     if (unique_students.uniq).count >= students_array.count
    #       generate_matches(day)
    #     end
    #     student2= User.find(students_array[rand(0..((students_array.count)-1))])
    #     unique_students << student2.id
    #     p unique_students.uniq.to_s + "tested students"
    #     case
    #     when student1 == student2
    #       next
    #     when self.has_match(student2,day)
    #       next
    #     when self.duplicates(student1, student2, selected_dates)
    #       next
    #     else
    #       Match.create(day:day,studenta:student2,studentb:student1)
    #       puts Match.where(day:day).count.to_s + " down!"
    #       break
    #     end
    #     break
    #   end
    # end
    # end
    #
    # def self.has_match(student,day)
    #   if Match.where(studenta_id:student,day:day).or(Match.where(studentb_id:student,day:day)).ids != []
        # lookup_a_to_b = lookup_a_to_b.join
    #     p Match.where(studenta_id:student,day:day).or(Match.where(studentb_id:student,day:day)).ids
    #     true
    #   else
    #     false
    #   end
    # end

    def self.duplicates(student,other_student, selected_dates)
      found_matches = []
        # lookup_a_to_b = lookup_a_to_b.join
      found_matches << Match.where(studenta_id:student, studentb_id:other_student, day: selected_dates).ids
      if found_matches == [[]]
        p found_matches
        found_matches << Match.where(studenta_id:other_student, studentb_id:student, day: selected_dates).ids
        if found_matches == [[], []]
          p found_matches
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
