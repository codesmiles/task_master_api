class TaskSerializer < ActiveModel::Serializer
  attributes :id, 
             :title, 
             :description, 
             :priority, 
             :is_completed, 
             :deadline,
             :created_at, 
             :updated_at

  # Computed attribute
  attribute :is_overdue

  def is_overdue
    object.deadline < Date.today
  end

  # Optional: Include user association
  # belongs_to :user, serializer: UserSerializer
end