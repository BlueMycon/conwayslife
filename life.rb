class Life
  attr_accessor :live_cells

  def initialize(live_cells)
    @live_cells = live_cells
  end

  def to_a
    @live_cells
  end

  def alive_next(num_neighbors, alive=true)
    num_neighbors == 3 || (num_neighbors == 2 && alive)
  end

  def next_generation
    next_gen                       = []
    live_cells_and_their_neighbors = live_neighbor_counts
    live_cells_and_their_neighbors.keys.each do |cell|
      is_alive = live_cells.include? cell
      next_gen << cell if alive_next(live_cells_and_their_neighbors[cell], is_alive)
    end
    Life.new(next_gen)
  end

  def live_neighbor_counts
    counts = Hash.new 0
    @live_cells.each do |cell|
      neighbors = neighborhood(cell)
      neighbors.each { |neighbor| counts[neighbor] += 1 }
    end
    counts
  end

  def neighborhood(cell)
    x, y = cell
    [[x-1, y-1], [x-1, y], [x-1, y+1], [x, y-1], [x, y+1], [x+1, y-1], [x+1, y], [x+1, y+1]]
  end
end
