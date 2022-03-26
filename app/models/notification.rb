class Notification < ApplicationRecord
  scope :order_created_at_desc, -> { order(created_at: :desc) }
  belongs_to :review, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'EndUser', optional: true
  belongs_to :visited, class_name: 'EndUser', optional: true
end
