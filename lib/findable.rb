module Findable
    def find_by_name(name)
        self.all.select{|planet| planet.englishName == name}[0]
    end
end
