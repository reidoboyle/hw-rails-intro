class Movie < ActiveRecord::Base
    def self.ratings
       return ['G','PG','PG-13','R'] 
    end
    
    def self.checked
       return {'G' => true,'PG' => true,'PG-13'=>true,'R'=>true} 
    end
    
    def self.inital_ratings
        return {'G' => 1,'PG' => 1,'PG-13'=> 1,'R'=> 1}
    end
    
    def self.update_check(checked,ratings)
        checked.each {|key,value| checked[key] = false}
        ratings.each do |val|
            checked[val] = true
        end
        return checked
    end
    
    def self.with_ratings(ratings)
       where(rating: ratings)
    end
end