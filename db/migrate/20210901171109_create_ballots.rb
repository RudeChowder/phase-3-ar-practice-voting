class CreateBallots < ActiveRecord::Migration[6.1]
  def change
    create_table :ballots do |t|
      t.integer :voter_id
      t.integer :candidate_id
    end
  end
end
