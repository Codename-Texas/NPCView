local NPCView = {};
NPCView.__index = NPCView;

function NPCView:IsBasePartInView(BasePart: BasePart, IgnoreModel: Model)
	local EyesVector = (self.Head.CFrame * CFrame.new(self.EyesOffset)).Position;
	local EyesToBasePartVector = (BasePart.Position - EyesVector);
	
	if EyesToBasePartVector.Magnitude < self.MaxDistance and EyesToBasePartVector.Unit:Dot(self.Head.CFrame.LookVector) >= self.FoV then
		local RayParams = RaycastParams.new();
		RayParams.IgnoreWater = false;
		RayParams.FilterType = Enum.RaycastFilterType.Blacklist;
		RayParams.FilterDescendantsInstances = {self.Head, IgnoreModel, self.IgnoreInstance}

		local Result = workspace:Raycast(EyesVector, EyesToBasePartVector, RayParams);
		if not Result then
			return true;
		end
	end
	return false;
end


function NPCView:IsCharacterInView(Player: Player)
	local Character = Player.Character;
	local CharacterChildren = (Character and Character:GetChildren()) or {};
	local InView = false;
	for _, CharacterChild in ipairs(CharacterChildren) do
		if not CharacterChild:IsA("BasePart") then continue end;
		if self:IsBasePartInView(CharacterChild, Character) then
			InView = true;
		end
	end
	return InView;
end

function NPCView:GetPlayersInView()
	local Players = game:GetService("Players"):GetPlayers();
	local PlayersInView = {};
	for _, Player in ipairs(Players) do
		if self:IsCharacterInView(Player) then
			table.insert(PlayersInView, Player);
		end
	end
	return PlayersInView;
end

function NPCView.Create(Head: BasePart, FoV: number, MaxDistance: number, IgnoreInstance: Instance | nil)
	return setmetatable({
		Head = Head,
		EyesOffset = Head.CFrame.LookVector * (Head.Size.Z / 2),
		FoV = FoV,
		MaxDistance = MaxDistance,
		IgnoreInstance = IgnoreInstance
	}, NPCView);
end

return NPCView;
