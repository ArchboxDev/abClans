-- abClans: Players --

local Player = FindMetaTable( "Player" )

function Player:GetClan()
	return Clans.GetPlayerClan( self )
end