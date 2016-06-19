class CreateYearlyReports < ActiveRecord::Migration
  def change
    create_table :yearly_reports do |t|

      t.belongs_to :user, index: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
