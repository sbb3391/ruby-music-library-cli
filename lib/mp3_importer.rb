require 'pry'
class MusicImporter

    attr_accessor :path

    def initialize(path)
       @path = path
       @filenames = []
    end

    def files
        Dir.entries(path).each do |filename|
            @filenames << "#{filename}"
        end
        @filenames.reject { |x| x == "." || x == ".."}
    end

    def import
        files.each { |file| Song.create_from_filename(file)}
    end

end