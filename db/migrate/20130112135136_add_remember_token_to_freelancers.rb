class AddRememberTokenToFreelancers < ActiveRecord::Migration
  def change
  	add_column :freelancers, :remember_token, :string
  	add_index :freelancers, :remember_token
  end
end
