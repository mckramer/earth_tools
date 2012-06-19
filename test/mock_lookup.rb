require 'earth_tools/lookup/base'
class EarthTools::Lookup::Base

  private
  
  def read_fixture(file)
    File.read(File.join("test", "fixtures", file)).strip.gsub(/\n\s*/, "")
  end
  
  ##
  # Handles running query
  #
  def retrieve(query)
    query = query.split('/')
    read_fixture "#{ query[3] }_(#{ query[4, query.size-1].join(',') }).xml"
  end

end