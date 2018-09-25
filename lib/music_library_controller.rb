class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    reply = ""
    while reply != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      reply = gets.strip

      # set CLI commands
      case reply
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end
    end
  end

  # CLI Methods

  def list_songs
    Song.list_all
  end

  def list_artists
    Artist.list_all
  end

  def list_genres
    Genre.list_all
  end

  def list_songs_by_artist
    # ask user to input artist name
    puts "Please enter the name of an artist:"
    name = gets.strip
    # print list of artist songs, alphabetized by title
    artist = Artist.find_by_name(name)
    artist&.song_list
  end

  def list_songs_by_genre
    # ask user to input genre name
    puts "Please enter the name of a genre:"
    input = gets.strip
    # print list of genre's songs, alphabetized by title
    genre = Genre.find_by_name(input)
    genre&.song_list
  end

  def play_song
    # ask user to choose a song
    puts "Which song number would you like to play?"
    number = gets.strip.to_i
    # plays the selected song
    Song.all_sorted[number-1]&.play unless number < 1 || number > Song.count
  end

end
