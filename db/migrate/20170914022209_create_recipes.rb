class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :email
      t.timestamps#automatically adds created_at & updated_at timesptamps to the table.
    end
  end
end