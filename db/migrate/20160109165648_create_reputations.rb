class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.integer :value
      t.string  :operation
      t.integer :reputationable_id
      t.string  :reputationable_type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :reputations, [:reputationable_id, :reputationable_type]
  end
end
