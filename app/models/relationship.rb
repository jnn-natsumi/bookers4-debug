class Relationship < ApplicationRecord
	belongs_to :following, class_name: "User"
	belongs_to :follower, class_name: "User"
	# belong_to 変更したいいやモデル名, class_name:"元々の親モデル名"
end
