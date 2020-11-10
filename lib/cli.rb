class Cli
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
        planets.sort.each_with_index{|planet, index| puts "-#{planet}"}
    end

    def get_date
        if show_planet(@objectInput)!=nil
            if show_planet(@objectInput).discoveryDate != ""
                puts "#{@objectInput} was discovered on #{show_planet(@objectInput).discoveryDate}."
            else
                puts "#{@objectInput} was discovered sometime during the dawn of man."
            end
        elsif show_moon(@objectInput)!=nil

            if show_moon(@objectInput).discoveryDate != ""
                puts "#{@objectInput} was discovered on #{show_moon(@objectInput).discoveryDate}."
            else
                puts "#{@objectInput} was discovered sometime during the dawn of man."
            end
        else
            "invalid input. try again."
        end
        call
    end

    def get_density
        if show_planet(@objectInput)!=nil
            density = show_planet(@objectInput).density
            earthDensity = 5.5136 
            puts "The density of #{@objectInput} is #{density} grams per cubic centimeter. That's #{density/earthDensity} times that of Earth's."
        elsif show_moon(@objectInput)!=nil
            if show_moon(@objectInput).density != 0
                density = show_moon(@objectInput).density
                earthDensity = 5.5136 
                puts "The density of #{@objectInput} is #{density} grams per cubic centimeter.That's #{density/earthDensity} that of Earth's."
            else
                puts "We don't have a measurment for this body!"
            end
        else
            "invalid input. try again."
        end
        call
    end

    def distance_to
        if show_planet(@objectInput)!=nil
            puts "The perihelion (a planet's closest distance to the sun) of #{@objectInput} is #{show_planet(@objectInput).perihelion} kilometers. That's equivalent to the width of the USA #{show_planet(@objectInput).perihelion/4313 } times over."
            puts "The aphelion (a planet's furthest distance to the sun) of #{@objectInput} is #{show_planet(@objectInput).aphelion} kilometers. That's equivalent to the width of the USA #{show_planet(@objectInput).aphelion/4313 } times over."
        elsif show_moon(@objectInput)!=nil
            if show_moon(@objectInput).perihelion != 0
                puts "The perihelion (a moon's closest distance to their planet) of #{@objectInput} is #{show_moon(@objectInput).perihelion} kilometers. That's equivalent to the width of the USA #{show_moon(@objectInput).perihelion/4313 } times over."
                puts "The aphelion (a moon's furthest distance to their planet) of #{@objectInput} is #{show_moon(@objectInput).aphelion}  kilometers. That's equivalent to the width of the USA #{show_moon(@objectInput).aphelion/4313 } times over."
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
            gravity = show_planet(@objectInput).gravity
            earthGravity = 9.807
            puts "The gravity of #{@objectInput} is #{gravity} meters per second squared. About #{gravity/earthGravity} times Earth's gravity."
        elsif show_moon(@objectInput)!=nil
            if show_moon(@objectInput).gravity != 0
                gravity = show_moon(@objectInput).gravity
                earthGravity = 9.807
                puts "The gravity of #{@objectInput} is #{gravity} meters per second squared. About #{gravity/earthGravity} times Earth's gravity."
            else
                puts "We don't have a measurment for this body!"
            end
        else
            "invalid input. try again."
        end
        call
    end

    def get_mass
        if show_planet(@objectInput)!=nil
            massValue = show_planet(@objectInput).mass["massValue"]
            massExponent = show_planet(@objectInput).mass["massExponent"]
            mass = massValue * (10 ** massExponent)
            earthMass = 7.34600*(10**22)
            puts "The mass of #{@objectInput} is: #{mass} kilograms. This is equivalent to about #{mass/11062} school busses, or #{mass/earthMass} Earths."
        
        elsif show_moon(@objectInput)!=nil
            massValue = show_moon(@objectInput).mass["massValue"]
            massExponent = show_moon(@objectInput).mass["massExponent"]
            mass = massValue * (10 ** massExponent)
            earthMass = 7.34600*(10**22)
            puts "The mass of #{@objectInput} is: #{mass} kilograms. This is equivalent to about #{mass/11062} school busses, or #{mass/earthMass} Earths."
        
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

