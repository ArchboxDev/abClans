-- abClans: Clans --

local Clans = {}

local Clans.Clans = Storage.Create()

local ClanMeta = {}
function Clans.NewClan( Owner, Name )
	if ( Clans.Clans:GetItem( Name ) ) then return end
	
	local this = {}
	setmetatable( this, ClanMeta )
	
	this.Owner = Owner
	this.Members = Storage.Create()
	
	this.Name = Name
	this.Abbreviation = ""
	this.Description = "No information is known about this clan. Perhaps they don't want you to know anything about it, or the owner simply hasn't added a description? Maybe " .. this.Owner.username .. " should do that."
	
	this.Allies = Storage.Create() -- Key: Ally Name -- Value: Ally Object --
	this.Relations = Storage.Create() -- Key: Clan Name -- Value: Relation Object --
	
	this.Stats = Storage.Create()
	this.Stats:SetItem( "Kills", 0 )
	this.Stats:SetItem( "Deaths", 0 )
	this.Stats:SetItem( "AllyKills", 0 )
	this.Stats:SetItem( "EnemyKills", 0 )
	this.Stats:SetItem( "AllyDeaths", 0 )
	this.Stats:SetItem( "EnemyDeaths", 0 )
	this.Stats:SetItem( "Arrested", 0 )
	this.Stats:SetItem( "Arrests", 0 )
	this.Stats:SetItem( "Jailed", 0 )
	
	this.Perks = Storage.Create()
	
	this.MemberCount = this.Members:Count()
	
	function this:GetRelation( Clan )
		local RelItem = this.Relations:GetItem( Clan.Name )
		if RelItem then return RelItem
		else
			return Clans.NewRelation( this, Clan )
		end
	end
	
	Clans.Clans:SetItem( Name, this )
	
	return this
end

local AllyMeta = {}
function Clans.NewAlliance( Clan, Ally )
	local this = {}
	setmetatable( this, AllyMeta )
	
	this.Relation = Clan:GetRelation( Ally )
	
	this.Stats = Storage.Create()
	this.Stats:SetItem( "AllyKills", 0 )
	this.Stats:SetItem( "MemberKills", 0 )
	this.Stats:SetItem( "EnemyKills", 0 )
	this.Stats:SetItem( "MemberSaves", 0 )
	
	this.GiftsSent = Storage.Create()
	this.GiftsSent:SetItem( "Money", 0 )
	
	Clan.Allies:SetItem( Ally.Name, this )
	
	return this
end

local RelationMeta =  {}
function Clans.NewRelation( Clan, Other )
	local this = {}
	setmetatable( this, RelationMeta )
	
	this.Stance = "Neutral" -- Can be Allied, Neutral or Enemy
	
	this.Stats = Storage.Create()
	this.Stats:SetItem( "EnemyKills", 0 )
	this.Stats:SetItem( "MemberSaves", 0 )
	this.Stats:SetItem( "MoneyGiven", 0 )
	this.Stats:SetItem( "MoneyReceived", 0 )
	
	this.GiftsSent = Storage.Create()
	this.GiftsSent:SetItem( "Money", 0 )
	
	Clan.Relations:SetItem( Other.Name, this )
	
	return this
end