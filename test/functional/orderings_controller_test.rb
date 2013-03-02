require 'test_helper'

class OrderingsControllerTest < ActionController::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  setup do
    @ordering = orderings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orderings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordering" do
    assert_difference('Ordering.count') do
      post :create, ordering: {  }
    end

    assert_redirected_to ordering_path(assigns(:ordering))
  end

  test "should show ordering" do
    get :show, id: @ordering
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ordering
    assert_response :success
  end

  test "should update ordering" do
    put :update, id: @ordering, ordering: {  }
    assert_redirected_to ordering_path(assigns(:ordering))
  end

  test "should destroy ordering" do
    assert_difference('Ordering.count', -1) do
      delete :destroy, id: @ordering
    end

    assert_redirected_to orderings_path
  end
>>>>>>> 23dbf44f2df1952989257e12007f7534533e160b
end
