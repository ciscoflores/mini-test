require 'minitest/autorun'
require_relative "../lib/person"

describe "Person", "A simple person example" do

	it "has a full name" do
		person = Person.new("Yukihiro","Matsumoto")
		person.full_name.must_equal "Yukihiro Matsumoto"
	end

end
