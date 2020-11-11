module CliHelperMethods
    def get_mass_index
        massValue = self.mass["massValue"]
        massExponent = self.mass["massExponent"]
        mass = massValue * (10 ** massExponent)
        mass
    end
     
    def show_planet
        Planet.find_by_name(@objectInput)
    end
    def show_moon
        Moon.find_by_name(@objectInput)
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

    def is_planet?
        show_planet!=nil
    end

    def is_moon?
        show_moon!=nil
    end
    def get_date
        if is_planet?
            if show_planet.discoveryDate != ""
                puts "#{@objectInput} was discovered on #{show_planet.discoveryDate}."
            else
                puts "#{@objectInput} was discovered sometime during the dawn of man."
            end
        elsif is_moon?
            if show_moon.discoveryDate != ""
                puts "#{@objectInput} was discovered on #{show_moon.discoveryDate}."
            else
                puts "#{@objectInput} was discovered sometime during the dawn of man."
            end
        end
        call
    end
    
    def get_diameter
        earthDiameter = 6371.00840*2
        if is_planet?
            puts "The diameter of #{objectInput} is #{show_planet.meanRadius*2} kilometers. That's #{(show_planet.meanRadius*2)/earthDiameter} times Earth's diameter."
        elsif is_moon?
            if show_moon.meanRadius != 0
                puts "The diameter of #{objectInput} is #{show_moon.meanRadius*2} kilometers. That's #{(show_moon.meanRadius*2)/earthDiameter} times Earth's diameter."
            else
                puts "We don't have a measurement for this body!"
            end
        end
        call
    end
    def get_density
        earthDensity = 5.5136
        if is_planet?
            puts "The density of #{@objectInput} is #{show_planet.density} grams per cubic centimeter. That's #{show_planet.density/earthDensity} times that of Earth's."
        elsif is_moon?
            if show_moon.density != 0
                puts "The density of #{@objectInput} is #{show_moon.density} grams per cubic centimeter. That's #{show_moon.density/earthDensity} that of Earth's."
            else
                puts "We don't have a measurment for this body!"
            end
        end
        call
    end

    def distance_to
        if is_planet?
            puts "The perihelion (a planet's closest distance to the sun) of #{@objectInput} is #{show_planet.perihelion} kilometers. That's equivalent to the width of the USA #{show_planet.perihelion/4313 } times over."
            puts "The aphelion (a planet's furthest distance to the sun) of #{@objectInput} is #{show_planet.aphelion} kilometers. That's equivalent to the width of the USA #{show_planet.aphelion/4313 } times over."
        elsif is_moon?
            if show_moon.perihelion != 0
                puts "The perihelion (a moon's closest distance to their planet) of #{@objectInput} is #{show_moon.perihelion} kilometers. That's equivalent to the width of the USA #{show_moon.perihelion/4313 } times over."
                puts "The aphelion (a moon's furthest distance to their planet) of #{@objectInput} is #{show_moon.aphelion}  kilometers. That's equivalent to the width of the USA #{show_moon.aphelion/4313 } times over."
            else
                puts "We don't have a measurment for this body!"
            end
        end
        call
    end

    def get_gravity
        earthGravity = 9.807
        if is_planet?
            puts "The gravity of #{@objectInput} is #{show_planet.gravity} meters per second squared. About #{show_planet.gravity/earthGravity} times Earth's gravity."
        elsif is_moon?
            if show_moon.gravity != 0
                puts "The gravity of #{@objectInput} is #{show_moon.gravity} meters per second squared. About #{show_moon.gravity/earthGravity} times Earth's gravity."
            else
                puts "We don't have a measurment for this body!"
            end
        end
        call
    end

    def get_mass
        earthMass = 5.97237*(10**24)
        if is_planet?
            puts "The mass of #{@objectInput} is: #{show_planet.get_mass_index} kilograms. This is equivalent to about #{show_planet.get_mass_index/11062} school busses, or #{show_planet.get_mass_index/earthMass} Earths."
        
        elsif is_moon?
            puts "The mass of #{@objectInput} is: #{show_moon.get_mass_index} kilograms. This is equivalent to about #{show_moon.get_mass_index/11062} school busses, or #{show_moon.get_mass_index/earthMass} Earths."
        end
        call
    end

    def discovered_by
        if is_planet?
            if show_planet.discoveredBy == ""
                puts "It is unknown who discovered #{objectInput}."
            else
                puts "This planet was discovered by #{show_planet.discoveredBy}."
            end
        end
        if is_moon?
            if show_moon.discoveredBy == ""
                puts "It is unknown who discovered #{objectInput}."
            else
                puts "This moon was discovered by #{show_moon.discoveredBy}."
            end
        end
        call
    end

    def list_moons
        if is_planet?
            if show_planet.find_moons != []
                show_planet.find_moons.each_with_index do |moon, index| 
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