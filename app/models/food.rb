class Food < ApplicationRecord
	include Rails.application.routes.url_helpers
	include PgSearch::Model

	has_rich_text :description

	pg_search_scope :search, 
					against: { name: "A" },
					associated_against: {
						rich_text_description: [:body]
					}, 
					using: {
                    	tsearch: { prefix: true, negation: true }
                  	}

    def url
    	api_v1_food_path(self)
    end
end
