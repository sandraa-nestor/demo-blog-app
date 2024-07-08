# frozen_string_literal: true

module Maintenance
  class ImportCommentsTask < MaintenanceTasks::Task
    csv_collection(converters: ->(field) { field.strip })

    def process(row)
      ::Maintenance::ImportCommentsJob.perform_later(row.to_h)
    end
  end
end
