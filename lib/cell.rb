class Cell
	def initialize(status = :alive)
		@status = status
	end

	def life_status
		@status
	end

	def set_life_status(status)
		@status = status if status != nil
	end
end
