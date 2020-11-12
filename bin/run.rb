require './config/environment.rb'



puts "Hello! What would you like to search for?\nYou can search by category or region by typing 'Category' or 'Region'\nPress H for help at any time.\n\n"

def run

    puts ">>>" 
    user_input = gets.chomp.downcase
    puts "\n"
    

    if user_input == "category"
        puts "\nSure! Which category would you like to search?"
        category_input = gets.chomp.to_s.downcase
        # return first ten results whose category is a match
        get_region = GetRequest.new("https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category_input}").response_json["meals"]
        puts "you've reached category"
        binding.pry

        if get_region == nil
            puts "\nCouldn't find any #{category_input} recipes!\n"

        else
            get_region.each do |recipe|
                new_recipe = Recipe.new(recipe)
            end
            puts "\nHere are some #{category_input} recipes:\n---"
            puts Recipe.names
            
        end

    elsif user_input == "region" || user_input == "area" || user_input == "type"
        puts "\nSure! Which region would you like to search?"
        area_input = gets.chomp.to_s.downcase
        get_region = GetRequest.new("https://www.themealdb.com/api/json/v1/1/filter.php?a=#{area_input}").response_json["meals"]
        puts "you've reached region"
        binding.pry
        if get_region == nil
            puts "\nCouldn't find any #{area_input.capitalize} recipes!\n"
        else
            get_region.each do |recipe|
                new_recipe = Recipe.new(recipe)
            end

            puts "\nHere are some #{area_input.capitalize} recipes:\n---"
            
            puts Recipe.names
        end
        
    else
        returned_recipes_parsed = GetRequest.new("https://www.themealdb.com/api/json/v1/1/search.php?s=#{user_input}").response_json["meals"]
        

        if returned_recipes_parsed == nil
            puts "\nCouldn't find any recipes with '#{user_input}' in the name!\n"
            run
        else
            returned_recipes_parsed.each do |recipe|
                # binding.pry
                new_recipe = Recipe.new(recipe)
                
            end
            puts "Here are some recipes with #{user_input} in the name:\n---"
            puts Recipe.names
            puts "\nWhich recipe would you like to open? (please enter a number)\n"
            recipe_selection = gets.to_i-1
            # need to handle non-existent numbers
            puts "\n#{Recipe.all[recipe_selection].strMeal}\n---\nInstructions:\n#{Recipe.all[recipe_selection].strInstructions}"
            

        end
    end
end

run



