class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable

	has_many :survey_templates
	scope :expect_admin, -> { where('is_admin = ?', false) }

	def full_name
		"#{first_name} #{last_name}"
	end
end
