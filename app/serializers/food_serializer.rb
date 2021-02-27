class FoodSerializer
	include JSONAPI::Serializer

	attributes :name

	link :self, :url
	attribute :description do |object|
		object.description.body
	end
end
