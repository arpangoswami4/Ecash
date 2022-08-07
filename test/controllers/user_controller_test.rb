# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test 'should get resource' do
    get user_resource_url
    assert_response :success
  end
end
