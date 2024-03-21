require "test_helper"

class VariablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variable = variables(:one)
  end

  test "should get index" do
    get variables_url, as: :json
    assert_response :success
  end

  test "should create variable" do
    assert_difference("Variable.count") do
      post variables_url, params: { variable: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show variable" do
    get variable_url(@variable), as: :json
    assert_response :success
  end

  test "should update variable" do
    patch variable_url(@variable), params: { variable: {  } }, as: :json
    assert_response :success
  end

  test "should destroy variable" do
    assert_difference("Variable.count", -1) do
      delete variable_url(@variable), as: :json
    end

    assert_response :no_content
  end
end
