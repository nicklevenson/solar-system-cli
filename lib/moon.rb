class Moon
    attr_accessor 

    @@all = []

    def initialize(moon)
        moon.each do |key,value| 
            self.class.attr_accessor(key)
            self.send("#{key}=", value)

        end
        @@all << self
    end

    def self.find_by_name(name)
        self.all.select{|moon| moon.englishName == name}[0]
    end

    def self.all
        @@all
    end

   

end