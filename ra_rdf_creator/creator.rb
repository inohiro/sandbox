require 'sequel'
require 'rdf'
require 'rdf/rdfxml'
require './../../research/olap_etl/util.rb'

def csv_dump( db, tables )
  tables.each do |table|
    table_name = table.to_sym
    file = File.open( "#{table.to_s}.csv", "w" )
    db[table_name].all.each do |r|
      file.puts( "#{r[:subject]}, #{r[:predicate]}, #{r[:object]}" )
    end
    file.close
    puts "#{table.to_s}.csv was closed"
  end
end

require 'pp'
require 'rdf/ntriples'

def rdf_xml_dump( db, tables )
  tables.each do |table|
    table_name = table.to_sym
#    file = File.open( "#{table.to_s}.rdf", "w" )
#    RDF::RDFXML::Writer.open( "#{table.to_s}.rdf" ) do |writer|
    RDF::Writer.for( :ntriples ).open( "#{table.to_s}.rdf" ) do |writer|
      db[table_name].all.each do |r|
        stm = RDF::Statement.new
        stm.subject = r[:subject]
        stm.predicate = r[:predicate]
        stm.object = r[:object]

        if r[:value_type_id] == "2" && r[:value_type] != nil
          l = RDF::Literal.new( r[:object], :datatype => r[:value_type] )
          stm.object = l
        end
        writer << stm
      end
    end
    puts "#{table.to_s}.rdf was closed"
  end
end

def main
  db = Util.connect_db( { :db => 'ra' } )
  tables = [ 'ev_time', 'observation_instance' ]

#  csv_dump( db, tables )
  rdf_xml_dump( db, tables )
end

main
