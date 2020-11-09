
class Cli

    attr_accessor :objectInput

    def start
        api = Api.new
        api.add_moons
        api.add_planets
        home
    end
    def home
        puts "Welcome to the Solar System"
        puts "Here's a list of planets in our Solar System (includes dwarf planets):"
        
        list_planets
        get_initial_input
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
        puts "What do you want to know about #{@objectInput}?"
        puts "To see a list of this object's moons enter: 'list moons'"
        puts "To see the mass of this object enter: 'mass'"
        puts "To see the gravity of this object enter: 'gravity'"
        puts "To see this object's distance to sun (at its closest) enter: 'distance to sun'"
        puts "To see this object's density enter: 'density'"
        puts "To see who this object was discovered by enter: 'discovered by'"
        puts "To see when this object was discovered enter: 'discovery date'"
        puts "To go back to the start enter: 'home'"
        puts "To exit enter: 'exit'"
        input = gets.chomp
       

        if input == "list moons"
            list_moons

        elsif input == "mass"
            get_mass

        elsif input == "gravity"
            get_gravity

        elsif input == "distance to sun"
            distance_to_sun

        elsif input == "density"
    
        elsif input == "discovered by"
            discovered_by
           
        elsif input == "discovery date"
    
        elsif input == "exit"
            
        elsif input == "home"
            home
    

            
        else
            puts "Not a valid input, try again."
            call
        end


    end
    
    def show_planet(input)
        Planet.find_by_name(input)
    end
    def show_moon(input)
        Moon.find_by_name(input)
    end


    def planets
        Planet.all.collect{|planet| planet.englishName}
    end
    def moons
        Moon.all.collect{|moon| moon.englishName}
    end

    def list_planets
        planets.sort.each_with_index{|planet, index| puts "#{index+1}. #{planet}"}
    end

    def distance_to_sun
        if show_planet(@objectInput)!=nil
            puts "The perihelion (an object's closest distance to the sun) of #{@objectInput} is #{show_planet(@objectInput).perihelion} kilometers."
            puts "The aphelion (an object's furthest distance to the sun) of #{@objectInput} is #{show_planet(@objectInput).aphelion} kilometers."
        elsif show_moon(@objectInput)!=nil
            if show_moon(@objectInput).perihelion != 0
                puts "The perihelion (an object's closest distance to the sun) of #{@objectInput} is #{show_moon(@objectInput).perihelion} kilometers."
                puts "The aphelion (an object's furthest distance to the sun) of #{@objectInput} is #{show_moon(@objectInput).aphelion}  kilometers."
            else
                puts "We don't have a measurment for this body!"
            end
        else
            "invalid input. try again."
        end
        call
    end

    def get_gravity
        if show_planet(@objectInput)!=nil
            puts "The gravity of #{@objectInput} is #{show_planet(@objectInput).gravity} meters per second squared."
        elsif show_moon(@objectInput)!=nil
            puts "The gravity of #{@objectInput} is #{show_moon(@objectInput).gravity} meters per second squared."
        else
            "invalid input. try again."
        end
        call
    end

    def get_mass
        if show_planet(@objectInput)!=nil
            massValue = show_planet(@objectInput).mass["massValue"]
            massExponent = show_planet(@objectInput).mass["massExponent"]
            puts "The mass of #{@objectInput} is: #{massValue ** massExponent} kilograms."
        
        elsif show_moon(@objectInput)!=nil
            massValue = show_moon(@objectInput).mass["massValue"]
            massExponent = show_moon(@objectInput).mass["massExponent"]
            puts "The mass of #{@objectInput} is: #{massValue ** massExponent} kilograms."
        
        else
            "invalid input. try again."
        end
        call
    end

    def discovered_by
        if show_planet(@objectInput)!=nil
            if show_planet(@objectInput).discoveredBy == ""
                puts "It is unknown who discovered #{objectInput}."
            else
                puts "This planet was discovered by #{show_planet(@objectInput).discoveredBy}."
            end
        end
      
        if show_moon(@objectInput)!=nil
            if show_moon(@objectInput).discoveredBy == ""
                puts "It is unknown who discovered #{objectInput}."
            else
                puts "This moon was discovered by #{show_moon(@objectInput).discoveredBy}."
            end
        end
        call
    end

    def list_moons
        if show_planet(@objectInput) != nil
            if show_planet(@objectInput).find_moons != []
                show_planet(@objectInput).find_moons.each_with_index do |moon, index| 
                    if moon.englishName != ""
                        puts "#{index+1}. #{moon.englishName}" 
                    end
                end
                puts "If you want to know more about a moon, enter it's name."
                puts "If you want to go back to the start, enter 'home'."

                #reseting objectInput to the moon input
                input = gets.chomp
                if input == 'home'
                    home
                end
                if moons.include?(input)
                    @objectInput = input
                    call
                else
                    puts "Not a valid input. Try again."
                    call
                end
            else
                puts "This object has no moons"
                call
            end
        else
            puts "Sorry moons don't really have moons..."
            call
        end
    end
     


end

