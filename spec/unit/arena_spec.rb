require 'spec_helper'
require 'arena.rb'

RSpec.describe Arena do
  describe "#step" do
    it "does the correct thing with the column example" do
      new_grid = Arena.new([
        [false, true, false],
        [false, true, false],
        [false, true, false],
      ]).step

      expect(new_grid).to eq([
        [false, false, false],
        [true, true, true],
        [false, false, false],
      ])
    end

    it "retains stable patterns" do
      world = [
        [false, true, false],
        [true, false, true],
        [false, true, false],
      ]

      new_grid = Arena.new(world).step

      expect(new_grid).to eq(world)
    end

    it "kills a lonley cell" do
      world = [
        [false, true, false],
        [false, false, false],
        [false, false, false],
      ]

      new_grid = Arena.new(world).step

      expect(new_grid).to eq([
        [false, false, false],
        [false, false, false],
        [false, false, false],
      ])
    end

    it "keeps the square shape stable" do
      world = [
        [true, true, false],
        [true, true, false],
        [false, false, false],
      ]

      new_grid = Arena.new(world).step

      expect(new_grid).to eq([
        [true, true, false],
        [true, true, false],
        [false, false, false],
      ])
    end
  end

  describe "#alive_neighbors" do
    it "returns 0 for a cell with 0 neighbors" do
      world = [
        [false, false, false],
        [false, true, false],
        [false, false, false],
      ]

      arena = Arena.new(world)
      expect(arena.alive_neighbors(1,1)).to be 0
    end

    it "returns 1 for a cell with 1 neighbors" do
      world = [
        [true, false, false],
        [true, false, false],
        [false, false, false],
      ]

      arena = Arena.new(world)
      expect(arena.alive_neighbors(0,0)).to be 1
    end

    it "returns 4 for a cell with 4 diagonal neighbors" do
      world = [
        [true, false, true],
        [false, false, false],
        [true, false, true],
      ]

      arena = Arena.new(world)
      expect(arena.alive_neighbors(1,1)).to be 4
    end

    it "returns 2 for a cell with 2 diagonal neighbors" do
      world = [
        [false, true, false],
        [false, false, false],
        [false, false, true],
      ]

      arena = Arena.new(world)
      expect(arena.alive_neighbors(2,1)).to be 2
    end

    it "returns 1 for a cell at the top of the column" do
      world = [
        [false, true, false],
        [false, true, false],
        [false, true, false],
      ]

      arena = Arena.new(world)
      expect(arena.alive_neighbors(1,2)).to be 1
    end
  end
end
