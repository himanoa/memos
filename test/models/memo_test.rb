require 'test_helper'

class MemoTest < ActiveSupport::TestCase
  setup do
    @user = User.create! name: 'test'
    @memo = @user.memos.create! title: 'A new memo', body: <<~BODY
      ## Subtitle

      Contents

      @h1manoa 「#ポッピンQ を見て」
    BODY
  end

  test "assert title" do
    assert_equal 'A new memo', @memo.title
  end

  test "assert markdown rendering to" do
    assert_includes @memo.rendered_body, '<h2>Subtitle</h2>'
  end

  test "assert mention link to" do
    assert_includes @memo.rendered_body, "<a href='https://twitter.com/h1maoa'>@h1manoa</a>"
  end

  test "assert hashtag link to" do
    assert_includes @memo.rendered_body, "<a href='https://twitter.com/hashtag/ポッピンQ'>#ポッピンQ</a>"
  end
end
