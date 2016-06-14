class Report < ActiveRecord::Base
  belongs_to :user

  MONDAY = 1
  TUESDAY = 2
  WEDNESDAY = 3
  THURSDAY = 4
  FRIDAY = 5

  def clean_start_date
    start_date.strftime("%B #{start_date.day.ordinalize}, %Y")
  end

  def clean_end_date
    end_date.strftime("%B #{end_date.day.ordinalize}, %Y")
  end
end
