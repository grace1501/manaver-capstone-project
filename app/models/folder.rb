# == Schema Information
#
# Table name: folders
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  default_version_id :bigint
#
# Indexes
#
#  index_folders_on_default_version_id  (default_version_id)
#
# Foreign Keys
#
#  fk_rails_...  (default_version_id => versions.id) ON DELETE => nullify
#
class Folder < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :default_version_must_belong_to_folder
  
  has_many :versions, dependent: :destroy
  has_many :users, through: :versions, source: :user

  belongs_to :default_version, class_name: "Version", optional: true

  def versions_count
    versions.size
  end
  
  # NOTE: Good job with validation here, this could be in the policy if pundit was added 
  def default_version_must_belong_to_folder
    if default_version && default_version.folder_id != id
      errors.add(:default_version, 'must belong to this folder')
    end
  end

end
