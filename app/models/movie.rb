class Movie < ActiveRecord::Base
    def self.ratings
       return ['G','PG','PG-13','R'] 
    end
    
    def self.checked
       return {'G' => true,'PG' => true,'PG-13'=>true,'R'=>true} 
    end
    
    def self.update_check(checked,ratings)
        checked.each {|key,value| checked[key] = false}
        ratings.keys.each do |val|
            checked[val] = true
        end
        return checked
    end
    
    def self.with_ratings(ratings)
       where(rating: ratings.keys)
    end
end