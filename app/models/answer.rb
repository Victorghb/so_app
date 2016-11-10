class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
	validates :user_name, presence: true
	validates :content, presence: true
	validates :question_id, presence: true
	validates :user_id, presence: true
end
