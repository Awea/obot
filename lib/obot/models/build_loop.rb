require "securerandom"  

class BuildLoops
  class << self
    def add(build_loop)
      File.new("data/#{build_loop.file_name}", 'w')
    end

    def any?
      !collection.empty?
    end

    def all
      collection.map do |file_name|
        File.delete("data/#{file_name}")
        BuildLoop.load_from_file_name(file_name)
      end
    end

    private

    def collection
      Dir.entries('data').select do |entry|
        entry.start_with?('build_')
      end
    end
  end
end

class BuildLoop
  attr_reader :planet_coordinates, :type

  class << self
    def load_from_file_name(file_name)
      new(file_name.split('_')[1], file_name.split('_')[2])
    end
  end

  def initialize(planet_coordinates, type)
    @planet_coordinates = planet_coordinates
    @type               = type
  end

  def interface
    @type.split(':')[0]
  end

  def building
    @type.split(':')[1]
  end

  def file_name
    "build_#{@planet_coordinates}_#{@type}_#{SecureRandom.hex(20)}"
  end

  def save
    BuildLoops.add(self)
  end
end