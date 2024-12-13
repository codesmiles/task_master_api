class Task < ApplicationRecord
  # Enum for priority
  enum priority: { low: 'low', medium: 'medium', high: 'high' }, _prefix: true

  # Associations
  belongs_to :user

  # Validations
  validates :title, 
            presence: true, 
            length: { 
              maximum: 255, 
              message: 'must be 255 characters or less' 
            }
  
  validates :description, 
            presence: true, 
            length: { 
              minimum: 10, 
              maximum: 1000, 
              message: 'must be between 10 and 1000 characters' 
            }
  
  validates :priority, 
            presence: true

  validates :is_completed, 
            inclusion: { in: [true, false] }
  
  validates :deadline, 
            presence: true

  # Scopes
  scope :completed, -> { where(is_completed: true) }
  scope :pending, -> { where(is_completed: false) }
  scope :overdue, -> { where('deadline < ?', Date.today) }

  # Optional: Callback for normalization
  before_validation :normalize_attributes

  private

  def normalize_attributes
    self.title = title.strip if title.present?
    self.description = description.strip if description.present?
  end
  
end
