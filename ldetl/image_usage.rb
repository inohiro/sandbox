
def print_help
  puts <<EOS
usage: main.rb 'schama_name' 'rdf_file_path' options
options: { :file_type => [ :ntriples, :n3, :xml ],
           :load_type => [ :all, :separate ] }
EOS
end

def main( argv )
  schema_name = argv[0]
  rdf_file_path = argv[1]
  options = argv[2]

  file_type = options[:file_type] || :ntriples
  load_type = options[:load_tyoe] || :separate

  rdf_file = Ldetl::RdfFile.new
  rdf_file.path = rdf_file_path
  rdf_file.type = file_type

  etl = Ldetl::ETL.new( schema_name, rdf_file, load_type )

  measure_candidates = etl.measure_candidates # Array
  measure_candidates.each do |candidate|
    pp candidate
  end

  # pp etl.tables_info
  # pp etl.relations
  # pp etl.create_schema( measure_candidate )
end

main( ARGV )
