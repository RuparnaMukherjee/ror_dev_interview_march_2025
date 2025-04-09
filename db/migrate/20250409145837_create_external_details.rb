class CreateExternalDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :external_details do |t|
      t.integer :e_id
      t.references :pokemon, null: false, foreign_key: true
      t.references :external_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
