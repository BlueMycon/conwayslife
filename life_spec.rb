require 'life.rb'

describe Life do
  before do
    @live_cells = [[1, 1], [2, 2]]
    @subject = Life.new(@live_cells)
  end

  it "exists" do
    @subject.should_not be_nil
  end

  it "has a serialization" do
    @subject.to_a.should == @live_cells
  end

  it "advances generations" do
    x = @subject.next_generation
    x.should be_kind_of Life
  end

  context "the rules" do
    context "a live cell on the next generation" do
      [2,3].each do |num|
        it "stays alive with #{num} live neighbors" do
          @subject.alive_next(num).should be_true
        end
      end
      [0,1,4,5,6,7,8].each do |num|
        it "dies with #{num} live neighbors" do
          @subject.alive_next(num).should be_false
        end
      end
    end

    context "a dead cell on the next generation" do
      it "becomes alive with 3 live neighbors" do
        @subject.alive_next(3, false).should be_true
      end
      [0,1,2,4,5,6,7,8].each do |num|
        it "stays dead with #{num} live neighbors" do
          @subject.alive_next(num, false).should be_false
        end
      end
    end
  end

  context "Single live cell" do
    it "dies because it has zero neighbors" do
      x = Life.new([[1,1]])
      y = x.next_generation
      y.to_a.should_not include([1,1])
    end
  end

  context "Block" do
    it "stays exactly the same from one generation to the next" do
      first = Life.new([[1,2], [1,1], [2,1], [2,2]])
      next_gen = first.next_generation.live_cells
      next_gen.length.should == 4
      [[1,1], [1,2], [2,1], [2,2]].each do |cell|
        next_gen.should include cell
      end
    end
  end

  context "two period oscillators" do
    context "Blinker" do
      it "switches a horizontal bar of length 3 to a vertical bar of length 3" do
        initial = Life.new([[1,2], [2,2], [3,2]])
        next_gen = initial.next_generation.live_cells
        next_gen.length.should == 3
        [[2,1],[2,2], [2,3]].each do |cell|
          next_gen.should include cell
        end
      end
    end

    context "Toad" do
      it "switches two horizontal 3-bars to two dots and two 2-bars" do
        initial = Life.new([[1,1], [2,1], [3,1], [2,2], [3,2], [4,2]])
        next_gen = initial.next_generation.live_cells
        [[2,0], [3,3], [1,1], [1,2], [4,1], [4,2]].each do |cell|
          next_gen.should include cell
        end
        next_gen.length.should == 6
      end
    end

  end

  context "creating live neighbor hash" do
    it "should return a hash for a single coordinate" do
      Life.new([[1,1]]).live_neighbor_counts.should == {
        [0,0] => 1,
        [0,1] => 1,
        [0,2] => 1,

        [1,0] => 1,
        [1,2] => 1,

        [2,0] => 1,
        [2,1] => 1,
        [2,2] => 1
      }
    end

    it "should return a hash for multiple coordinates" do
      Life.new([[1,1],[1,2]]).live_neighbor_counts.should == {
        [0,0] => 1,
        [0,1] => 2,
        [0,2] => 2,
        [0,3] => 1,

        [1,0] => 1,
        [1,1] => 1,
        [1,2] => 1,
        [1,3] => 1,

        [2,0] => 1,
        [2,1] => 2,
        [2,2] => 2,
        [2,3] => 1
      }
    end
  end
end
