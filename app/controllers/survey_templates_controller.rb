class SurveyTemplatesController < ApplicationController
	before_action :check_user_admin, only: [:new ,:create]
	before_action :set_servey_template, only:[:show, :edit, :update]
	before_action :check_incompleted, only: [:edit, :update]

	def index
		@survey_templates = current_user.is_admin? ? SurveyTemplate.all : current_user.survey_templates
	end

	def new
		@survey_template = SurveyTemplate.new
	end

	def show
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
	end

	def update 
		if @survey_template.update(survey_template_params)
			check_and_change_status if params[:commit] == "Submit"
			@survey_template.errors.any? ? (render 'edit') : (redirect_to @survey_template)
		else
			render 'edit'
		end
	end

	private

	def survey_template_params
		params.require(:survey_template).permit(:name, :gender, :province, :biography, :user_id, :description, :status, :interests => [])
	end

	def set_servey_template
		@survey_template = SurveyTemplate.find(params[:id])
	end

	def check_and_change_status
		if @survey_template.check_for_existence
			@survey_template.update(completion_date: DateTime.now, status: "completed")
		else
			@survey_template.errors[:base] << "You Must have to fill all the filed before click on Submit button"
		end
	end
	def check_user_admin
		unless current_user.is_admin?
			flash[:notice] = "this action only authorized by admin!"
			redirect_to survey_templates_path
		end
	end

	def check_incompleted
		if  !@survey_template.check_for_existence || current_user.is_admin? || @survey_template.status == "partially_completed"
		else
			flash[:notice] = "This survey already completed."
			redirect_to survey_templates_path
		end
	end
end
