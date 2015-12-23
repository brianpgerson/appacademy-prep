require 'byebug'

class Course
	attr_reader :department, :name, :credits, :days, :time_block

	def initialize(name, department, credits, days, time_block)
		@name = name
		@department = department
		@credits = credits
		@students = []
		@days = days
		@time_block = time_block
	end

	def students
		@students
	end

	def add_student(student)
		student.enroll(self)
	end

	def conflicts_with?(other_course)
		self.days.each do |day|
			if other_course.days.include?(day) && self.time_block == other_course.time_block
				return true
			end
		end
		false
	end

end

class Student
	attr_accessor :first_name, :last_name, :courses

	def initialize(first_name, last_name)
		@first_name = first_name
		@last_name = last_name
		@courses = []
	end

	def name
		"#{@first_name} #{last_name}"
	end

	def courses
		@courses
	end

	def enroll(new_course)
		return if self.courses.include?(new_course)
		raise "Course conflicts!" if has_conflict?(new_course)
		
		@courses << new_course
		new_course.students << self
	end

	def has_conflict?(new_course)
		self.courses.any? do |enrolled_course| 
			enrolled_course.conflicts_with?(new_course)
		end
	end		

	def course_load
		course_load_hash = Hash.new(0)
		self.courses.each do |course|
			course_load_hash[course.department] += course.credits
		end
		course_load_hash
	end

	end
