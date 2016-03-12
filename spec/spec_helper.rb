$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slearn'
require 'nmatrix/rspec'

ALL_DTYPES = [:byte,:int8,:int16,:int32,:int64, :float32,:float64, :object, :complex64, :complex128]

NON_INTEGER_DTYPES = [:float32, :float64, :complex64, :complex128, :object]

INTEGER_DTYPES = [:byte,:int8,:int16,:int32,:int64]
