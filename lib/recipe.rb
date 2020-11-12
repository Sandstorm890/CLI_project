require './config/environment.rb'


class Recipe

    @@all = []

    def initialize(recipe)
        recipe.transform_keys!(&:to_sym)
        recipe.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def self.clear
        @@all.clear
    end

    def self.names
        Recipe.all.collect do |recipe|
            recipe.strMeal
        end
    end

    def self.ingredients
        
    end

end

