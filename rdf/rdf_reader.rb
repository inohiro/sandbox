require 'rubygems'

require 'rdf'
require 'rdf/ntriples'
require 'rdf/n3'

require 'pp'

FILE_PATH = './file01.n3'

def main

=begin
  RDF::NTriples::Reader.open( FILE_PATH ) do |reader|
    reader.each do |stm|
      pp stm
      gets
    end
  end
=end

=begin
  graph = RDF::Graph.load( FILE_PATH ) do
#  RDF::Graph.load( FILE_PATH ) do |graph|
    graph.each do |stm|
      pp stm
      gets
    end
  end
=end

#  RDF::Reader.for( :n3 ).open( FILE_PATH ) do |reader|
  RDF::Reader.open( FILE_PATH ) do |reader|
    reader.each do |stm|
      pp stm
      gets
    end
  end

end

main
