class AddRefToCollaborator < ActiveRecord::Migration[5.0]
  def change
    add_column :collaborators, :brand_id, :uuid
    add_column :collaborators, :user_id, :uuid
  end

end
