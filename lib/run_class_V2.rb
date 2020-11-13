require './config/environment.rb'


class Run

    attr_reader :input

    def self.initial_input
        puts "\nEnter a search term to search by meal name.\nYou can also search by category or region by typing 'Category' or 'Region'\nEnter 'quit' to quit at any time.\n"
        user_input
    end

    def self.integer_input
        input = gets.chomp
        if input == "quit"
            begin
                exit
            end
        else
            input = input.to_i
            if input > 0
                input-1
            else
                puts "Invalid input."
                integer_input
            end
        end
    end

    def self.user_input
        input = gets.to_s.downcase.chomp
        if input == ""
            puts "Invalid input"
            initial_input
        elsif input == "quit"
            begin
                exit
            end
        else
            @input = input 
        end
    end

    def self.ask_if_done
        puts "\n\nWould you like another recipe? (y/n)"
        user_input
        if @input == "y"
            Recipe.clear
            initial_input
            get_results
        else
            nil
        end
    end

    def self.make_meal_selection(recipes)
        puts "\nWhich recipe would you like to open? (please enter a number)\n"

        selection = integer_input
        
        if recipes.length < selection || selection < 0
            puts "Invalid selection"
            make_meal_selection
        else
            selection
        end

    end

    def self.get_results

        if @input == "region" || @input == "area" || @input == "category"
            old_stored_input = @input
            puts "\nSure! What would you like to search for?"
            puts "i.e. Mexican, Chinese, etc." if @input == "region" || @input == "area"
            puts "i.e. seafood, beef, etc." if @input == "category"
            user_input
            get_recipes = GetRequest.new(GetRequest.get_url(old_stored_input, @input)).response_json["meals"]
            
            if get_recipes == nil
                puts "\nCouldn't find any matching recipes!\n"
                initial_input
                get_results
            else
                
                puts "\nHere are some matching recipes:\n---"
                
                Recipe.names_with_index(Recipe.create_new_recipes(get_recipes))
        
                recipe_selection = make_meal_selection(Recipe.names)
                
                # this has to be here since the API doesnt return recipe details when searching by category or region
                Recipe.create_new_recipes(GetRequest.new("https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{Recipe.all[recipe_selection].idMeal}").response_json["meals"])
                puts "\n#{Recipe.all.last.strMeal}\n---\nInstructions:\n#{Recipe.all.last.strInstructions}"
                ask_if_done
                
            end

        else

            returned_recipes = GetRequest.new("https://www.themealdb.com/api/json/v1/1/search.php?s=#{@input}").response_json["meals"]
        

            if returned_recipes == nil
                puts "\nCouldn't find any recipes with '#{@input}' in the name!\n"
                initial_input
                get_results
            else
                puts "Here are some recipes with '#{@input}' in the name:\n---"
                Recipe.names_with_index(Recipe.create_new_recipes(returned_recipes))
                
                recipe_selection = make_meal_selection(Recipe.names)
                
                puts "\n#{Recipe.all[recipe_selection].strMeal}\n---\nInstructions:\n#{Recipe.all[recipe_selection].strInstructions}"
                ask_if_done
                
            end
        end
        
    end
end

