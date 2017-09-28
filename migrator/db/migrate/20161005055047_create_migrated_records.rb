class CreateMigratedRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :btr_rms_migrated_records do |t|
      t.references  :r_a, null: false, index: true, polymorphic: true
      t.datetime    :r_a_at, null: false, index: true

      t.references  :r_b, null: false, index: true, polymorphic: true
      t.datetime    :r_b_at, null: false, index: true

      t.timestamps
    end
  end
end
