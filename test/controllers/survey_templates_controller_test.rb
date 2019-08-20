require 'test_helper'

class SurveyTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get survey_templates_index_url
    assert_response :success
  end

end
