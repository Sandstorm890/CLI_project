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

    def self.names_with_index(input_recipes)
        recipes = []
        input_recipes.each do |recipe|
            recipes << recipe[:strMeal]
        end
        recipes.each_with_index {|recipe, index| puts "#{index+1}. #{recipe}"}
    end

    def self.create_new_recipes(recipes)
        recipes.each do |recipe|
            new_recipe = Recipe.new(recipe)
        end
    end

    def self.clear
        @@all.clear
    end

    # def self.get_id(index)
    #     @@all[index][:idMeal]

    # end

end

