require "pry"

class Song < Base
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  def self.all
    @@all
  end

  def display
    %{#{artist.name} - #{name} - #{genre.name}}
  end

  def display_by_genre
    %{#{name} - #{genre.name}}
  end

  def display_by_artist
    %{#{artist.name} - #{name}}
  end

  def play
    puts %{Playing #{name} by #{artist.name}}
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(file_name)
    imported_song = file_name.split(" - ")[1]
    imported_artist = file_name.split(" - ")[0]
    imported_genre = file_name.split(" - ")[2].chomp(".mp3")

    artist = Artist.find_or_create_by_name(imported_artist)
    genre = Genre.find_or_create_by_name(imported_genre)

    Song.new(imported_song, artist, genre)
  end

  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    song.save
    song
  end
end
