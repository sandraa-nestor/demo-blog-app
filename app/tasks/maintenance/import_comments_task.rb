# frozen_string_literal: true

module Maintenance
  class ImportCommentsTask < MaintenanceTasks::Task
    csv_collection

    def process(row)
      logger.info("Processing row: #{row}")
      raise StandardError, "Post with slug #{row['Post Slug']} not found." unless post = Post.find_by(slug: row['Post Slug'])

      user = User.find_or_create_by!(email: row['User Email']) do |user|
        user.name = row['User Name']
      end
      return if post.comments.find_by(user: user, content: row['Content'])

      comment = post.comments.build(user: user, content: row['Content'])
      raise StandardError, "Comment not saved: #{comment.errors.full_messages.join(', ')}" unless comment.valid?

      comment.save!
    rescue StandardError => e
      logger.error("Error: #{e.message}")
    end

    private

    def logger
      @logger ||= Logger.new(Rails.root.join('log', "import_comments_task#{DateTime.current}.log"))
    end
  end
end
