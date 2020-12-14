require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre
    extend Concerns::Findable

    @@all = []

    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist) if artist != nil
        self.genre=(genre) if genre != nil
        save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        
        if !(self.genre.songs.include?(self))
            self.genre.songs << self
        end
    end

    
    def self.all
        @@all
    end
    
    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        Song.new(name)
    end

    def self.find_by_name(name)
        Song.all.find do |song|
            song.name == name
        end

    end

    def self.find_or_create_by_name(name)
        Song.find_by_name(name) || Song.create(name)
    end

    def self.new_from_filename(filename)
        arr = filename.split(" - ")
        song_input = arr[1]
        artist_input = arr[0]
        genre_input = arr[2].gsub(".mp3","")
        artist = Artist.find_or_create_by_name(artist_input)
        genre = Genre.find_or_create_by_name(genre_input)
        song = Song.new(song_input, artist, genre)
        song
    end

    def self.create_from_filename(filename)
        Song.new_from_filename(filename).save
    end


end