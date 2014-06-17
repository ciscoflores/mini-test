require 'minitest/autorun'
require_relative "../lib/cell"

describe "Cell" do

	let(:cell) { Cell.new(:dead) }

	it "is a dead cell" do
		cell.life_status.must_equal :dead
	end

	it "is an alive cell" do
		cell.set_life_status(:alive)
		cell.life_status.must_equal :alive
	end

end
