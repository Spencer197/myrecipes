class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
       t.text :content
    t.integer :chef_id
    t.timestamps null: false
    end
  end
end
