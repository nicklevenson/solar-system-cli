class Cli
    include CliHelperMethods
    attr_accessor :objectInput
    def start
        api = Api.new
        home
    end

    def home
        puts "            -WELCOME TO THE SOLAR SYSTEM!-              "
        puts "--------------------------------------------------------"
        puts "Here's a list of planets in our Solar System (includes dwarf planets):"
        list_planets
        get_initial_input
        call
    end

    def get_initial_input
        puts "--------------------------------------------------------"
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
        puts "What do you want to know about #{@objectInput}?"
        puts "--------------------------------------------------------"
        puts "---To see a list of this object's moons enter: 'list moons'"
        puts "---To see the mass of this object enter: 'mass'"
        puts "---To see the gravity of this object enter: 'gravity'"
        puts "---To see this object's distance to its orbital center (sun for planets - planet for moon) enter: 'distance to'"
        puts "---To see this object's density enter: 'density'"
        puts "---To see this object's diameter enter: 'diameter'"
        puts "---To see who this object was discovered by enter: 'discovered by'"
        puts "---To see when this object was discovered enter: 'discovery date'"
        puts "---To go back to the start enter: 'home'"
        puts "---To exit enter: 'exit'"
        puts "--------------------------------------------------------"
      
        input = gets.chomp
        if input == "list moons"
            list_moons
        elsif input == "mass"
            get_mass
        elsif input == "gravity"
            get_gravity
        elsif input == "distance to"
            distance_to
        elsif input == "density"
            get_density
        elsif input == "diameter"
            get_diameter
        elsif input == "discovered by"
            discovered_by 
        elsif input == "discovery date"
            get_date
        elsif input == "exit"       
        elsif input == "home"
            home
        else
            puts "Not a valid input, try again."
            call
        end
    end
end