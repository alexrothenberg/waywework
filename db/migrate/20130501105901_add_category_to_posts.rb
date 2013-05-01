class AddCategoryToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :category, :string
  end
end
