class Document < ActiveRecord::Base
  belongs_to :language
  has_many :articles, as: :components
end
