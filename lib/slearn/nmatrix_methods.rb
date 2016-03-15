class NMatrix
  # Transform a Daru::DataFrame into a NMatrix
  #
  # === Arguments
  #
  # * +dtype+ - the +dtype+ of the returned NMatrix; defaults to +float64+
  # * +stype+ - the +stype+ of the returned NMatrix; defaults to +dense+
  #
  # NOTE: Make this faster
  def to_dataframe(order = 0, index = 0)
    raise(ShapeError, "The NMatrix must be 2 dimensional") unless self.dim == 2
    n, m = self.rows, self.cols
    data_array=Array.new(n) {Array.new}
    0.upto(n-1) { |i| data_array[i].concat(self.row(i).to_a) }
    order = Array (1..n) if order == 0
    return  Daru::DataFrame.new(data_array, order: order)
  end
end
