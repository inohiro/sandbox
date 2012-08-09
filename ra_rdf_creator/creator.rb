require 'sequel'
require './../../research/olap_etl/util.rb'

def main
  db = Util.connect_db( { :db => 'ra' } )
  tables = [ 'ev_time', 'observation_instance' ]

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

main
