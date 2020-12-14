class Artist

    @@all = []

    attr_accessor :name 
    extend Concerns::Findable

    def initialize(name)
        @name = name
        save
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        self.class.all << self
    end

    def self.create(name)
        Artist.new(name)
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        
        if !(self.songs.include?(song))
            self.songs << song
        end
    end

    # def genres
    #     @new_arr
    #     self.songs.collect do |song|
    #         if @new_arr.include?(song.genre)
    #             nil
    #         else 
    #            @new_arr << song.genre
    #         end
    #     end
    #     @new_arr
    # end

    def genres
        all_genres = self.songs.collect do |song|
            song.genre
        end
        all_genres.uniq
    end

end