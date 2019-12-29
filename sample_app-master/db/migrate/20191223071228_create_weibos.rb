class CreateWeibos < ActiveRecord::Migration[5.0]
  def change
    create_table :weibos do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :weibos,[:user_id,:created_at]
  end
end
