class SurveyTemplatesController < ApplicationController
	def index
		@survey_templates = SurveyTemplate.all
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
 
		if @survey_template.update(article_params)
			redirect_to @survey_template
		else
			render 'edit'
		end
	end

	def survey_template_params
		params.require(:survey_template).permit(:name, :gender, :province, :biography, :user_id, :interests => [])
	end
end
