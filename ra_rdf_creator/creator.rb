require 'sequel'
require 'rdf'
require 'rdf/ntriples'
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

def rdf_nt_dump( db, tables )
  tables.each do |table|
    table_name = table.to_sym
    RDF::Writer.for( :ntriples ).open( "#{table.to_s}.nt" ) do |writer|
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
  rdf_nt_dump( db, tables )
end

main
