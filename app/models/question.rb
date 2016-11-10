class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :label, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
end