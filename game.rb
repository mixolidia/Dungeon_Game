class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms =[]
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    # puts reference.inspect
    @rooms.detect { |room| room.reference == reference }
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    if find_room_in_dungeon(@player.location).connections.include?(direction)
      puts "You go " + direction.to_s
      @player.location = find_room_in_direction(direction)
      show_current_description
    else
      puts "That cave does not exits. Please pick a new direction."
      
    end

    # puts "You go " + direction.to_s
    # @player.location = find_room_in_direction(direction)
    # show_current_description
  end

  class Player
     attr_accessor :name, :location

     def initialize(name)
       @name = name
     end
  end

  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
      @name + "\n\nYou are in " + @description
    end
  end

end


  #**commented out below because of page 155 (see pg. 151-152)**
  #**using Stuc is a simple way to declare a class
  #Player = Struct.new(:name, :location)
  #Room = Struct.new(:reference, :name, :description, :connections)

  # **Below code simplified above with the Struct class
  # class Player
  #   attr_accessor :name, :location
  #
  #   def initialize(player_name)
  #     @name = player_name
  #   end
  # end
  #
  # class Room
  #   attr_accessor :reference, :name, :description, :connections
  #
  #   def initialize(reference, name, description, connections)
  #     @reference = reference
  #     @name = name
  #     @description = description
  #     @connections = connections
  #   end
  # end

  #Ask player

  #Create the main dungeon object
  $my_dungeon = Dungeon.new("Fred Bloggs")

  #Add rooms to the dungeon
  $my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave.",{
    :west => :smallcave})
  $my_dungeon.add_room(:smallcave, "Small Cave", "a small claustrophobic cave.",{
    :east => :largecave, :south => :bluecave})
  $my_dungeon.add_room(:bluecave, "Blue Cave", "an ice cold blue cave.",{
    :north => :smallcave})
  #$my_dungeon.add_room(:smallcave, "Small Cave", "a blue cave.",{
  #  :east => :largecave})

  #Start the dungeon by placing the player in the large cave
  $my_dungeon.start(:largecave)
