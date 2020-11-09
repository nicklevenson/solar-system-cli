
class Cli

    attr_accessor :objectInput

    def start
        api = Api.new
        api.add_moons
        api.add_planets

        puts "Welcome to the Solar System"
        puts "Here's a list of planets in our Solar System (includes dwarf planets):"
        
        list_planets
        get_initial_input
        
        puts "What do you want to know about #{@objectInput}?"
        call
    
    end

    def get_initial_input
        puts "Enter the name of a planet you'd like to know more about"
        input = gets.chomp
        if planets.include?(input)
            puts "Ah, #{input}! A lovely choice."
            @objectInput = input
        else
            puts "Sorry, that's not a valid input. Please try again."
            get_initial_input
        end
    end

    def call
        puts "To see a list of this object's moons enter: 'list moons'"
        puts "To see the mass of this object enter: 'mass'"
        puts "To see the gravity of this object enter: 'gravity'"
        puts "To see this object's distance to sun (at its closest) enter: 'distance to sun'"
        puts "To see this object's density enter: 'density'"
        puts "To see who this object was discovered by enter: 'discovered by'"
        puts "To see when this object was discovered enter: 'discovery date'"
        input = gets.chomp
        if input == "list moons"
            if list_moons != false  
            else
                puts "This object has no moons"
            end
        end
    end
    
    def show_planet(input)
        Planet.find_by_name(input)
    end

    def planets
        Planet.all.collect{|planet| planet.englishName}
    end


    def list_planets
        planets.sort.each_with_index{|planet, index| puts "#{index+1}. #{planet}"}
    end

    def list_moons
        if show_planet(@objectInput).find_moons == []
            return false
        else
        show_planet(@objectInput).find_moons.each_with_index{|moon, index| puts "#{index+1}. #{moon.englishName}"}
        end
    end
     


end

