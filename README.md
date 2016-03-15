# slearn
slearn is a supervised machine learning gem on top of NMatrix and daru.
It uses NMatrix for computation, daru for data handling, and SciRuby visualization gems for visualization of results.

[![Build Status](https://travis-ci.org/Arafatk/slearn.svg?branch=master)](https://travis-ci.org/Arafatk/slearn)

## Examples
[K-Means clustering](http://nbviewer.jupyter.org/github/Arafatk/slearn/blob/master/notebook/K-means.ipynb)

## Development
 To install this gem onto your local machine, run `bundle exec rake install`.    
 To run the tests use `bundle exec rake spec`.   
 To prepare the docs using yard run `bundle exec rake doc`.   

## Dependencies
- daru
- nmatrix

It is highly recommended that the user uses a plotting gem such as 
- gnuplotrb
- nyaplot

## TODO's for K-Means
- Add a variety of distance methods such as 
  - cosine_similarity
  - binary_jaccard_distance
  - jaccard_distance
