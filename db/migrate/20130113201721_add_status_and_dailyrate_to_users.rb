class AddStatusAndDailyrateToUsers < ActiveRecord::Migration
  def change
    add_column :freelancers, :status, :string
    add_column :freelancers, :daily_rate, :integer
  end
end
