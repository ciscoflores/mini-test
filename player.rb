class Player
  
  def play_turn(warrior)
	
	if warrior.feel.enemy?
		if define_Attack(warrior) == true or warrior.health > 19
			warrior.attack!
		else
			warrior.walk!(:backward)
			@health = warrior.health
		end
	elsif define_Captive(warrior) == true
		#do nothing
	else
		if not(define_Attack(warrior)) and (warrior.health < 20)
			warrior.rest!
		else
			walk_Direction(warrior)
		end
		@health = warrior.health
	end
	
  end
  
  def define_Attack(warrior)
	
	take_Action = false
	
	if !warrior.feel.empty? and warrior.health < 10
		take_Action = false
	elsif @health != nil and @health > warrior.health
		take_Action = true
	end
	 
	return take_Action
	
  end
  
  def walk_Direction(warrior)
  
	if !warrior.feel(:backward).wall? and warrior.feel(:backward).empty? and @wall_Touched != true
		warrior.walk!(:backward)
	else
		warrior.walk!
	end
	
	if warrior.feel(:backward).wall?
			@wall_Touched = true
	end
  
  end
  
  def define_Captive(warrior)
	
	captive_Rescue = false
	
	if warrior.feel(:backward).captive?
		warrior.rescue!(:backward)
		captive_Rescue = true
	elsif warrior.feel(:forward).captive?
		warrior.rescue!(:forward)
		captive_Rescue = true
	end
	
	return captive_Rescue
	
  end
  
end
