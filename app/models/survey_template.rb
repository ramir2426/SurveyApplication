class SurveyTemplate < ApplicationRecord
	belongs_to :user, optional: true
	# serialize :interests

	enum status: {pending: "Pending", partially_completed: "Partially Completed", completed: "Completed"}
	scope :unassigned_survey, -> { where('user_id IS NULL OR user_id = ?', []) }

	def check_for_existence
		all_present = true
		self.attributes.each do |attr|
			unless attr[0] =="completion_date"
				if attr[1].blank?
					all_present =  false
					break
				else
					all_present =  true
				end
			end
		end
		return all_present
	end
end
