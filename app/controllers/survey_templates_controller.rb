class SurveyTemplatesController < ApplicationController
	def index

		@survey_templates = current_user.is_admin? ? SurveyTemplate.all : current_user.survey_templates
	end

	def new
		@survey_template = SurveyTemplate.new
	end

	def show
		@survey_template = SurveyTemplate.find(params[:id])
	end

	def create
		@survey_template = SurveyTemplate.new(survey_template_params)
		if @survey_template.save
			redirect_to @survey_template
		else
			render 'new'
		end
	end

	def edit
    @survey_template = SurveyTemplate.find(params[:id])
  end

	def update
	@survey_template = SurveyTemplate.find(params[:id])
 
		if @survey_template.update(survey_template_params)
			check_and_change_status if params[:commit] == "Save Work"
			@survey_template.errors.any? ? (render 'edit') : (redirect_to @survey_template)
		else
			render 'edit'
		end
	end

	def survey_template_params
		params.require(:survey_template).permit(:name, :gender, :province, :biography, :user_id, :description, :status, :interests => [])
	end

	def check_and_change_status
		if @survey_template.check_for_existence
			@survey_template.update(completion_date: DateTime.now, status: "completed")
		else
			@survey_template.errors[:base] << "You Must have to fill all the filed before click on Submit button"
		end
	end
end
