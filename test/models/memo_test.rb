require 'test_helper'

class MemoTest < ActiveSupport::TestCase
  setup do
    @user = User.create! name: 'test'
    @memo = @user.memos.create! title: 'A new memo', body: <<~BODY
      ## Subtitle

      Contents
    BODY
  end

  test "assert title" do
    assert_equal 'A new memo', @memo.title
  end

  test "assert markdown rendering to" do
    assert_includes @memo.rendered_body, '<h2>Subtitle</h2>'
  end
end
