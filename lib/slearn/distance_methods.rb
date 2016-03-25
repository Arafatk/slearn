module Distance_methods
  def euclidean_distance(a, b)
    a = a.cast(:dense, :float64) if a.integer_dtype?
    b = b.cast(:dense, :float64) if b.integer_dtype?
    distance = (a - b).norm2
  end

  def manhattan(a, b)
    (a - b).asum
  end

  def cosine(a, b)
    a = a.cast(:dense, :float64) if a.integer_dtype?
    b = b.cast(:dense, :float64) if b.integer_dtype?
    1 - (((a*b).asum)/a.norm2)/b.norm2
  end
end

class NMatrix
  include Distance_methods
  def distance(b, method = 'euclidean')
    result = euclidean_distance(self, b) if method == 'euclidean'
    result = manhattan(self, b) if method == 'manhattan'
    result = cosine(self, b) if method == 'cosine'
    result
  end
end