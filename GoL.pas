program GoL;
type
	Cell = object
		private
			alive : boolean;
			survive: boolean;
		public 
			constructor Init;		
		protected
			procedure SetCell(state : boolean);
			function GetCell:boolean;
			procedure SetSurvive(markvalue : boolean);
			function GetSurvive:boolean;	
	end;

	World = object(Cell)
		private
			ground : array of array of cell;
		protected		
			procedure SetWorld(xvalue, yvalue : integer);
			procedure SetLocation(xposition, yposition: integer; stateposition: boolean);
			procedure DoomsDay;			
			procedure Print;
	end;

	constructor Cell.Init;
	begin
		self.alive :=  false;
		self.survive := true;
	end;

	procedure Cell.SetCell(state : boolean);
	begin
		self.alive := state;
	end;

	function Cell.GetCell:boolean;
	begin
		exit(self.alive);
	end;

	procedure Cell.SetSurvive(markvalue : boolean);
	begin
		self.survive := markvalue;
	end;

	function Cell.GetSurvive:boolean;
	begin
		exit(self.survive);
	end;

	procedure World.SetWorld(xvalue, yvalue : integer);
	begin
		if (xvalue >= 1) and (yvalue >= 1) then
			setlength(self.ground,xvalue,yvalue)		
		else
			setlength(self.ground,1,1);
	end;

	procedure World.SetLocation(xposition, yposition: integer; stateposition: boolean);
	begin
		self.ground[xposition, yposition].SetCell(stateposition);
	end;

	procedure World.DoomsDay;
	var
		i,j,xx,yy: integer;
		alivecount : integer;
	begin
		xx := (length(self.ground)-1);
		yy := (length(self.ground[1])-1);
		// Evaluate every cell in the ground to define if survive or not.					
		for i := 0 to xx do
			for j := 0 to yy do	
			begin
				alivecount:= 0;
				if ( (i-1) >= 0 ) and ( (j-1) >= 0 ) then
					if (self.ground[i-1,j-1].GetCell = true) then
						alivecount:= alivecount + 1;
				if ( (i-1) >= 0 ) then 
					if self.ground[i-1,j].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (i-1) >= 0 ) and ( (j+1) <= yy ) then
					if self.ground[i-1,j+1].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (j-1) >= 0 ) then
					if self.ground[i,j-1].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (j+1) <= yy ) then 
					if self.ground[i,j+1].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (i+1) <= xx ) and ( (j-1) >= 0 ) then 
					if self.ground[i+1,j-1].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (i+1) <= xx ) then 
					if self.ground[i+1,j].GetCell = true then
						alivecount:= alivecount + 1;
				if ( (i+1) <= xx ) and ( (j+1) <= yy ) then 
					if self.ground[i+1,j+1].GetCell = true then
						alivecount:= alivecount + 1;
				
				if (self.ground[i,j].GetCell = true) and ( (alivecount < 2) or (alivecount > 3) ) then
					self.ground[i,j].SetSurvive(false)
				else if (alivecount = 3) then
					self.ground[i,j].SetSurvive(true);
			end;
		
		// Kill, revive o mantain every cell in the ground
 		for i := 0 to (length(self.ground)-1) do
			for j := 0 to (length(self.ground[1])-1)  do
			begin
				if (self.ground[i,j].GetSurvive = true) then
					self.ground[i,j].SetCell(true)
				else
					self.ground[i,j].SetCell(false);
				self.ground[i,j].SetSurvive(true);
			end;
	end;

	procedure World.Print;
	var
		x,y : integer;
	begin
		for x := 0 to (length(self.ground)-1) do
		begin
			for y := 0 to (length(self.ground[1])-1)  do	
				if ground[x, y].GetCell = false then
					write('0 ')
				else
					write('X ');
			writeln;
		end;
		writeln;
	end;

var
	WorldTest : World;
begin	
	WorldTest.SetWorld(3,4);
	WorldTest.SetLocation(1,1,true);
	WorldTest.SetLocation(0,1,true);
	WorldTest.SetLocation(2,1,true);
	WorldTest.SetLocation(0,2,true);
	WorldTest.SetLocation(2,3,true);
	WorldTest.Print;
	WorldTest.DoomsDay;
	WorldTest.Print;	
end.
