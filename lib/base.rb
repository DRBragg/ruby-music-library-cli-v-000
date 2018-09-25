class Base
  extend Concerns::Findable
  
  def self.count
    self.all.count
  end

  def self.all_sorted
    self.all.sort {|a, b| a.name <=> b.name}
  end

  def self.list_all
    self.all_sorted.each_with_index do |item, i|
      puts "#{i + 1}. #{item.display}"
    end
  end

  def display
    %{#{self.name}}
  end

  def self.create(name)
    new_item = self.new(name)
    new_item.save
    new_item
  end
end
