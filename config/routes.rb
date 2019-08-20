Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :survey_templates
	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: "users/registrations"
	}

	root to: "survey_templates#index"
end
