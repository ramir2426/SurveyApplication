class AddFieldsToSurveyTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_templates, :description, :text
    add_column :survey_templates, :completion_date, :datetime
    add_column :survey_templates, :status, :string, default: "Pending"
  end
end
