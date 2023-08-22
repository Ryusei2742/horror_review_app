class AddContentToMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :created_at
    remove_column :messages, :updated_at

    # 新しいカラムを追加します
    add_column :messages, :content, :text
    add_reference :messages, :sender, foreign_key: { to_table: :users }
    add_reference :messages, :recipient, foreign_key: { to_table: :users }

    # タイムスタンプのカラムを再度追加します
    add_timestamps :messages, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
