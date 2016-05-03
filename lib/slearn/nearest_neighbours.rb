class Kdtree
  include Enumerable
  class Node
    def initialize(point, left = nil, right = nil, dimension = nil, distance = nil, radius = nil)
      @point = point
      @left = left
      @right = right
      @distance = distance
      @radius = radius
      @dimension = dimension
    end
    attr_accessor :point, :left, :right, :distance, :radius
  end

  def initialize(dataframe, dimension, i = 0)
    @points = to_ruby_array(dataframe)
    @root = make_tree(@points, dimension, i)
    @dimension = dimension
    @best_dist = Float::INFINITY
  end
  
  def neighbours(points, size, method = nil)
    points = to_ruby_array(points)
    k_neighbours_array = []
    points.each do |point|
      k_neighbours_array.push(near(point,size, method))
    end
    k_neighbours_array
  end

  def to_ruby_array(dataframe)
    array, row = [], 0
    dataframe.each do |i|
       array.push([])
       i.each do |j|
         array[row].push(j)
       end
      row = row + 1
    end
    array
  end

  def dist(a, b)
    sum =  0
    a.size.times do |i|
      sum = sum + (a[i] - b[i]) * (a[i] - b[i])
    end
    sum
  end

  def quickselect(a, k)
    arr = a.dup
    loop do
      pivot = arr.delete_at(rand(arr.length))
      left, right = arr.partition { |x| x < pivot }
      if k == left.length
        return pivot
      elsif k < left.length
        arr = left
      else
        k = k - left.length - 1
        arr = right
      end
    end
  end

  def make_tree(points, dimension, i)
    root, dimension_array = nil, []
    size = points.size
    points.each do |point| dimension_array.push(point[i]) end
    pivot = quickselect(dimension_array, (dimension_array.size) / 2)
    left, right = [], []
    points.each do |point|
      left.push(point)  if point[i] < pivot
      right.push(point) if point[i] > pivot
      left.push(point)  if point[i] == pivot and root != nil
      root = Kdtree::Node.new(point) if point[i] == pivot and root == nil
    end
    root.left = nil  if left.size == 0
    root.right = nil if right.size == 0
    root.left = Kdtree::Node.new(left[0]) if left.size == 1
    root.right = Kdtree::Node.new(right[0]) if right.size == 1
    root.left = make_tree(left, dimension, (i + 1) % dimension) if left.size > 1
    root.right = make_tree(right, dimension, (i + 1) % dimension) if right.size > 1
    root
  end

  def near(nearest, size, method = nil)
    @rbtree, points = MultiRBTree[], []
    nearest(root, nearest, 0, size)
    while @rbtree.size > 0 do
      top = @rbtree.pop
      points.push([top[1], top[0]]) if method == 'both'
      points.push(top[0]) if method == 'distance'
      points.push(top[1]) if method == nil
    end
    points.reverse
  end
  
  def nearest(root, nearest, i, size)
    return if root == nil
    d = dist(root.point, nearest)
    dx = root.point[i] - nearest[i]
    dx2 = dx * dx
    root.distance = d
    @rbtree[d] = root.point
    while @rbtree.size > size do
      @rbtree.pop
    end
    nearest(dx > 0 ? root.left : root.right, nearest, (i+1)% @dimension, size)
    nearest(dx > 0 ? root.right : root.left, nearest, (i+1)% @dimension, size) if (@rbtree.size < size || @rbtree.last[0] >= dx2)
  end
  attr_accessor :root, :point
end