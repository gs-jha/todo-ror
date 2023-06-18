class Task < ApplicationRecord

    belongs_to :user
    acts_as_list scope: :user
    
    before_save :default_values

    private

    def default_values
        self.completed ||= false
        nil                           
    end
end
