require 'spec_helper'
require 'slearn/distance_methods'

describe "distance" do
  [:int8, :int16, :int32, :int64, :float32, :float64].each do |dtype|
    next if dtype == :object || dtype == :byte
    context dtype do
      err = 1e-2
      it "should return the euclidian distance between 2 vectors" do
        a = NMatrix.new([4], [141, 6, 5, 8], dtype: dtype)
        b = NMatrix.new([4], [142, 3, 5, 8], dtype: dtype) 
        expect(a.distance(b)).to be_within(err).of(3.16227)
      end

      it "should return the manhattan distance between 2 vectors" do
        a = NMatrix.new([4], [141, 6, 5, 8], dtype: dtype)
        b = NMatrix.new([4], [142, 3, 5, 8], dtype: dtype) 
        expect(a.distance(b,'manhattan')).to be_within(err).of(4)
      end

      it "should return the manhattan distance between 2 vectors" do
        a = NMatrix.new([2], [1,142], dtype: dtype)
        b = NMatrix.new([2], [111,1], dtype: dtype) 
        expect(a.distance(b,'cosine')).to be_within(err).of(0.9839497867953171)
      end
    end
  end
end