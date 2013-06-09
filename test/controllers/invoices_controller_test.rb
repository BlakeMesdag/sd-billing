require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  def setup
    @invoice = invoices(:bobserver)
  end
  test "index should redirect" do
    get :index
    assert_response :redirect
    assert_redirected_to controller: 'sessions', action: 'new'
  end

  test "should get show" do
    get :show, id: @invoice.token, format: :json
    assert_response :success
  end

  test "update only updates stripe_token" do
    put :update, id: @invoice.token, invoice: { stripe_token: "0987654321", name: "Test Only" }, format: :json
    assert_response :success

    parsed = JSON.parse(response.body)
    assert_equal "Bob Tester", parsed['invoice']['name']
  end

end
