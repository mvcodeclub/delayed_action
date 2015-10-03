require 'test_helper'

module DelayedAction
  class DelayedActionResultsControllerTest < ActionController::TestCase
    setup do
      @delayed_action_result = delayed_action_delayed_action_results(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:delayed_action_results)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create delayed_action_result" do
      assert_difference('DelayedActionResult.count') do
        post :create, delayed_action_result: { content_type: @delayed_action_result.content_type, request_env: @delayed_action_result.request_env, result: @delayed_action_result.result, uuid: @delayed_action_result.uuid }
      end

      assert_redirected_to delayed_action_result_path(assigns(:delayed_action_result))
    end

    test "should show delayed_action_result" do
      get :show, id: @delayed_action_result
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @delayed_action_result
      assert_response :success
    end

    test "should update delayed_action_result" do
      patch :update, id: @delayed_action_result, delayed_action_result: { content_type: @delayed_action_result.content_type, request_env: @delayed_action_result.request_env, result: @delayed_action_result.result, uuid: @delayed_action_result.uuid }
      assert_redirected_to delayed_action_result_path(assigns(:delayed_action_result))
    end

    test "should destroy delayed_action_result" do
      assert_difference('DelayedActionResult.count', -1) do
        delete :destroy, id: @delayed_action_result
      end

      assert_redirected_to delayed_action_results_path
    end
  end
end
