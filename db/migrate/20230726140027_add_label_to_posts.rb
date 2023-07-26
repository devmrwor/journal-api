class AddLabelToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :label, :string
  end
end
