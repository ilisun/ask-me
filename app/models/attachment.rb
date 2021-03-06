class Attachment < ActiveRecord::Base

  default_scope { order(created_at: :asc) }

  belongs_to :attachmentable, polymorphic: true

  mount_uploader :file, FileUploader

end
