class CreateDelayedActionDelayedActionResults < ActiveRecord::Migration
  def change
    create_table :delayed_action_delayed_action_results do |t|
      t.text :result
      t.text :request_env
      t.string :uuid
      t.string :content_type

      t.timestamps null: false
    end

    add_index "delayed_action_delayed_action_results", ["uuid"], name: "index_delayed_action_results_on_uuid", unique: true
  end
end
