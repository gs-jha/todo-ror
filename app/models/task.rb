class Task < ApplicationRecord

    belongs_to :user
    
    before_save :default_values

    private

    def default_values
        self.completed ||= false
        nil                           
    end
end
