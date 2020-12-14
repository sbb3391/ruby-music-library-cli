class Genre

    attr_accessor :name
    extend Concerns::Findable

    @@all = []

    
    def initialize(name)
        @name = name
        @songs = []
        save
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
        Genre.new(name)
    end

    def songs
        @songs
    end

    def artists
        all_artists = self.songs.collect do |song|
            song.artist
        end
        all_artists.uniq
    end
end

