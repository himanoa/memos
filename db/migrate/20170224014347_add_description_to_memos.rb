class AddDescriptionToMemos < ActiveRecord::Migration[5.0]
  def change
    add_column :memos, :description, :text
  end
end
