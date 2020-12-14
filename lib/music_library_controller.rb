require 'pry'

class MusicLibraryController

    attr_accessor

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call

        loop do 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
            
        input = gets.strip
            
        case input
        when "list songs"
            self.list_songs
        when "list artists"
            self.list_artists
        when "list genres"
            self.list_genres
        when "list artist"
            self.list_songs_by_artist
        when "list genre"
            self.list_songs_by_genre
        when "play"
            self.play_song
        when "exit"
            break
        end
    end
    end



    def list_songs
        song_names = Song.all.collect do |song|
            song.name
        end
        
        sorted_songs = song_names.uniq.sort
        
        sorted_songs.each_with_index do |item, index|
            i = index + 1

            song_i = Song.find_by_name(item)
            song_i_name = song_i.name
            song_i_artist = song_i.artist.name
            song_i_genre = song_i.genre.name

            song_i_filename = "#{song_i_artist} - #{song_i_name} - #{song_i_genre}"
            
            puts "#{i}. #{song_i_filename}"
        end
    end

    def list_artists
        artist_names = Artist.all.collect do |artist|
            artist.name
        end

        sorted_artists = artist_names.uniq.sort
        
        sorted_artists.each_with_index do |item, index|
            i = index + 1
            puts "#{i}. #{item}"
        end
    end

    def list_genres
        genre_names = Genre.all.collect do |genre|
            genre.name
        end

        sorted_genres = genre_names.uniq.sort

        sorted_genres.each_with_index do |item, index|
            i = index + 1
            puts "#{i}. #{item}"
        end
    end

    def list_songs_by_artist
        input = ""
        puts "Please enter the name of an artist:"
        input = gets

        #take input and get artist instance from string
        artist_from_input = Artist.find_by_name(input)

        if artist_from_input == nil
            nil
        else 
            
            #go through that artist's songs, collect just the name and genre, and sort it
            sorted_songs = artist_from_input.songs.collect do |song|
                [song.name, song.genre.name]
            end.sort
            
            sorted_songs.each_with_index do |item, index|
                i = index + 1
                puts "#{i}. #{item[0]} - #{item[1]}"
            end
        end 
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets
        sorted_by_genre = Song.all.select { |song| song.genre.name == genre}.sort_by(&:name).uniq
        sorted_by_genre.each_with_index do |item, index|
            puts "#{index+1}. #{item.artist.name} - #{item.name}"
        end

    end

    # def valid_song_choice?
    #     song_choice = gets.strip.to_i
    #     true if 
    # end

    def play_song
        puts "Which song number would you like to play?"
        song_choice = gets.strip.to_i
        sorted_songs = Song.all.sort_by(&:name).uniq

        if song_choice >= 1 && song_choice <= sorted_songs.count && song_choice.is_a?(Integer)
            puts "Playing #{sorted_songs[song_choice-1].name} by #{sorted_songs[song_choice-1].artist.name}"
        else
            nil
        end


    end

    
        
end 
   









