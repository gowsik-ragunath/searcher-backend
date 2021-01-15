class Food < ApplicationRecord
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

end
