# == Schema Information
#
# Table name: versions
#
#  id          :bigint           not null, primary key
#  description :text
#  link        :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_versions_on_folder_id  (folder_id)
#  index_versions_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#  fk_rails_...  (user_id => users.id)
#
class Version < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  has_one_attached :link
end
