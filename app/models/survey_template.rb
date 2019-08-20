class SurveyTemplate < ApplicationRecord
  belongs_to :user, optional: true
  # serialize :interests
end
