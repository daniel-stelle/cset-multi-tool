class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many   :timesheet_rows, dependent: :destroy

  accepts_nested_attributes_for :timesheet_rows

  class << self
    def role(id)
      where('role_id=?', id)
    end

    def recent
      order('created_at DESC')
    end

    def ordered
      order('created_at')
    end
  end
end
