class AddRenderedBodyToMemos < ActiveRecord::Migration[5.0]
  def change
    add_column :memos, :rendered_body, :text
  end
end
