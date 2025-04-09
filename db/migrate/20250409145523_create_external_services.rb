class CreateExternalServices < ActiveRecord::Migration[8.0]
  def change
    create_table :external_services do |t|
      t.string :name

      t.timestamps
    end
  end
end
