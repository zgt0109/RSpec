class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :contact, index: true, foreign_key: true
      t.string :phone
      t.string :phone_type

      t.timestamps null: false
    end
  end
end
