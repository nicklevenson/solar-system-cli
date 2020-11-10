module HelperMethods

    def get_mass_index
        massValue = self.mass["massValue"]
        massExponent = self.mass["massExponent"]
        mass = massValue * (10 ** massExponent)
        mass
    end
end