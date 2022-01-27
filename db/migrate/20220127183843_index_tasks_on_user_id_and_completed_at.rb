# frozen_string_literal: true

class IndexTasksOnUserIdAndCompletedAt < ActiveRecord::Migration[7.0]
  def change
    add_index :tasks, %i[user_id completed_at], name: :index_incomplete_tasks_by_user_id, where: 'completed_at IS NULL'
    add_index :tasks, %i[user_id completed_at], name: :index_completed_tasks_by_user_id,
                                                where: 'completed_at IS NOT NULL'
  end
end
