require 'pstore'

def remove_data(pstore_file)
  File.delete(pstore_file) if File.exist?(pstore_file)
end