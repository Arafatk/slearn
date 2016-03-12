module Daru
  class DataFrame
    # Converts Daru::DataFrame to NMatrix 
    # TODO: make this better if possible
    def to_nmatrix(dtype: :float64, stype: :dense)
      n, m = self.nrows, self.ncols
      data_array = Array.new 
      0.upto(n-1) { |i| data_array.concat(self.row[i].to_a) }
      return NMatrix.new([n,m], data_array, dtype: dtype, stype: stype)
    end
  end

  # Converts Daru::Vector to NMatrix 
  # TODO: make this better if possible
  class Vector
    def to_nmatrix(dtype: :float64, stype: :dense)
      n = self.size
      return NMatrix.new([n,1], self.to_a, dtype: dtype, stype: stype)
    end
  end
end