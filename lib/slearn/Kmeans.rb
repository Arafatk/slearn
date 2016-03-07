class NMatrix
  def kmeans(n_clusters = 2, iterations = 4)
    centroid = self.create_centroids(n_clusters)
    closest_centroid = self.closest_centroid_array(n_clusters, centroid)
    new_centroid = self.reposition(n_clusters, closest_centroid, centroid)

    for i in 0..iterations - 2
      closest_centroid = self.closest_centroid_array(n_clusters, new_centroid)
      new_centroid = self.reposition(n_clusters, closest_centroid, new_centroid)
    end

    new_centroid
  end

  # find centroid ranges as a bounding box for all nodes
  def create_ranges
    dimensions = self.shape[1]
    ranges = NMatrix.new(dimensions) {[nil, nil]}
    self.each_row do |row|
      row.each_with_indices do |position, v, index|
        # Bottom range
        ranges[index,0] = position if ranges[index,0].nil? || position < ranges[index,0]
        # Top range
        ranges[index,1] = position if ranges[index,1].nil? || position > ranges[index,1]
      end
    end
    ranges
  end

  # initial centroid positions are randomly chosen from within
  # a bounding box that encloses all the nodes
  def create_centroids(n_clusters)
    ranges = create_ranges
    centroid = NMatrix.new([n_clusters, self.shape[1]])
    0.upto(n_clusters - 1) do |i|
      0.upto(self.shape[1]-1) do |j|
        centroid[i,j] = rand_between(ranges[j,0], ranges[j,1])
      end
    end
    centroid
  end

  #Creates an array containing the closest centroid to a node
  def closest_centroid_array(n_clusters, centroids)
    closest_distance = Array.new(self.shape[0])
    closest_centroid = Array.new(self.shape[0])
    index = 0 
    row_index = 0
    self.each_row do |row|
      centroids.each_row do |centroid|
        distance = euclidean_distance(row,centroid)
        closest_distance[row_index] = distance if closest_distance[row_index].nil?
        closest_centroid[row_index] = index if closest_centroid[row_index].nil?
        if distance < closest_distance[row_index]
          closest_distance[row_index] = distance
          closest_centroid[row_index] = index
        end
        index += 1
      end
      row_index += 1
      index = 0
    end
    closest_centroid
  end

  # Finds the average distance of all the nodes assigned to
  # the centroid and then moves the centroid to that position
  def reposition(n_clusters = 2, closest_centroid, centroid)
    centroid_count = Array.new(n_clusters, 0)
    for j in 0..self.shape[0] - 1
      if centroid_count[closest_centroid[j]] == 0
        centroid[closest_centroid[j], 0...self.shape[1]] = self[j,0...self.shape[1]] #TODO : Fix the shape 
      else
        centroid[closest_centroid[j], 0...self.shape[1]] += self[j,0...self.shape[1]]
      end
      centroid_count[closest_centroid[j]] += 1
    end

    for j in 0..n_clusters - 1
      if centroid_count[j] != 0
        centroid[j,0...self.shape[1]] = centroid[j,0...self.shape[1]] / centroid_count[j]
      end
    end
    centroid
  end

  #TODO - Add other distance methods
  def euclidean_distance(a, b)
    distance=0
    0.upto(a.size - 1) do |i|
      distance = distance + (a[i]-b[i]) * (a[i] - b[i])
    end
    distance = Math.sqrt(distance)
  end

  # Simpler way to handle a random number between to values
  def rand_between(a, b)
    return rand_in_floats(a, b) if a.is_a?(Float) or b.is_a?(Float)
    range = (a - b).abs + 1
    rand(range) + [a,b].min
  end

    # Handles non-integers
  def rand_in_floats(a, b)
    range = (a - b).abs
    (rand * range) + [a,b].min
  end
end