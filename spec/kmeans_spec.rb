require 'spec_helper'
require 'slearn/kmeans'

describe "kmeans" do
  [:int16, :int32, :int64, :float32, :float64].each do |dtype|
    context dtype do
      err = 1e-4
      it "should create lower ranges for a centroid" do
  	    a = NMatrix.new([2, 3], [141, 612, 9123, \
  	                               2, 934, 1154], dtype: dtype)
  	    lower_bound = NMatrix.new([3, 1], [2.0, 612.0, 1154.0], dtype: dtype)
  	    upper_bound = NMatrix.new([3, 1], [141.0, 934.0, 9123.0], dtype: dtype)
  	    expect(a.create_ranges[0..2, 0]).to be_within(err).of(lower_bound)
  	    expect(a.create_ranges[0..2, 1]).to be_within(err).of(upper_bound)
      end
    end
  end

  [:int16, :int32, :int64, :float32, :float64].each do |dtype|
    context dtype do
      err = 1e-4
      it "should create randomly generated centroids" do
  	    a = NMatrix.new([2, 3], [141, 612, 9123, \
  	                               2, 934, 1154], dtype: dtype)
  	    centroid = a.create_centroids(5)
  	    ranges = a.create_ranges
  	    0.upto(4) do |i|
  	      0.upto(2) do |j|
  	        err = ranges[j,1] - ranges[j,0]
            expect(centroid[i,j]).to be_within(err).of(ranges[j,0])
          end
  	    end
      end
    end
  end

  [:int16, :int32, :int64, :float32, :float64].each do |dtype|
    context dtype do
      err = 1e-4
      it "should create an array with the index of the centroid closest to the given point" do
        centroid = NMatrix.new([4, 2], [1, 3, 400, 500, 934, 1154, -10, -14], dtype: dtype)
        point = NMatrix.new([3, 2], [9, 10, 331, 290 , 800, 1000],dtype: dtype)
  	    c = [0,1,2]
  	    0.upto(2) do |j|
  	    	expect(point.closest_centroid_array(centroid)[j]).to be_within(err).of(c[j])
  	    end
      end
    end
  end

  [:int16, :int32, :int64, :float32, :float64].each do |dtype|
    context dtype do
      err = 1e-4
      it "should reposition centroids" do
        centroid = NMatrix.new([3, 2], [1, 3,  400, 500,  934, 1154], dtype: dtype)
        point = NMatrix.new([6, 2], [9, 10, 15, 26, 331, 290, 541, \
                                     600, 800, 1000, 1334, 908],dtype: dtype)
        closest_centroid = point.closest_centroid_array(centroid)
        new_centroid = NMatrix.new([3, 2], [12, 18, 436, 445, 1067, 954], dtype: dtype)
        expect(point.reposition(3,closest_centroid,centroid)).to be_within(err).of(new_centroid)
      end
    end
  end
end