class Player
  
	def play_turn(warrior)		
		result = warrior.look
		resultback = warrior.look(:backward)
		if resultback[0].empty? && resultback[1].empty? && ( resultback[2].to_s == 'Archer' || resultback[2].to_s == 'Wizard' ) && result[0].empty?
			warrior.pivot!	
		elsif result[0].empty? && !result[1].empty? && result[1].enemy?
			warrior.shoot!	
		elsif !warrior.feel.enemy? && !warrior.feel.empty? && !warrior.feel.captive?
			warrior.pivot!		
		elsif warrior.feel.enemy? && warrior.health > 10
			warrior.attack!		
		elsif warrior.feel.captive?
			warrior.rescue!
		elsif warrior.health < 10 && resultback[0].empty? && resultback[1].empty?
			warrior.walk!(:backward)
		elsif warrior.health < 19 && result[0].empty? && result[1].empty? && result[2].empty?
			warrior.rest!
		else	
			warrior.walk!
		end

	end
end
