class AddActionToCheckouts < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE checkout_action AS ENUM ('checkout', 'checkin');
      ALTER TABLE checkouts ADD action checkout_action;
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE checkout_action;
    SQL
    remove_column :checkouts, :action
  end
end
