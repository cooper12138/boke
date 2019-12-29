class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :comment_id
      t.integer :commented_id

      t.timestamps
    end

    #　评论人id和被评论人微博id之间建立索引
    add_index :comments, :comment_id
    add_index :comments, :commented_id
    add_index :comments, [:comment_id,:commented_id], unique: true
  end
end
