class RemoveBodyFieldFromPostsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :body
  end
end
