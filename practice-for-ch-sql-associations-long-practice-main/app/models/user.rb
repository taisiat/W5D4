# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord

    has_many :enrollments, #returns enrollments for a user
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment

    has_many :enrolled_courses, #get all enrolled courses for a user
        through: :enrollments,
        source: :course

    has_many :courses,
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: :Course
end
