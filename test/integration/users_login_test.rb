require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    #新しいセッションのフォームが正しく表示されたことを確認
    post login_path, params: { session: { email: "", password: "" } }
    #わざと無効なparamsハッシュを使ってセッション用パスにPOST
    assert_template 'sessions/new'
    #新しいセッションのフォームが再度表示
    assert_not flash.empty?
    #フラッシュメッセージが追加されることを確認
    get root_path
    #別のページ（Homeページなど） にいったん移動
    assert flash.empty?
    #移動先のページでフラッシュメッセージが表示されていないことを確認
  end
  
end
