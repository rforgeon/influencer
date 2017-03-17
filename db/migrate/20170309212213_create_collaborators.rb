class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators, id: :uuid, default: "uuid_generate_v4()", force: true do |t|

      t.timestamps


    end
  end
end
