-- abClans: Clans --

local Clans = {}

Clans.Clans = Storage.Create()

function Clans.GetPlayerClan( Player )
	local Res = nil
	for i, Clan in pairs( Clans.Clans ) do
		if Clan:PlayerIsMember( Player ) then
			Res = Clan
		end
	end
	return Res
end

-- abClans: Classes --

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
	
	this.Bank = Clans.NewBank()
	
	this.Perks = Storage.Create()
	
	this.MemberCount = this.Members:Count()
	
	function this:GetRelation( Clan )
		local RelItem = this.Relations:GetItem( Clan.Name )
		if RelItem then return RelItem
		else
			return Clans.NewRelation( this, Clan )
		end
	end
	
	function this:PlayerIsMember( Player )
		local Res = false
		for i, Member in pairs( this.Members ) do
			if Member.ID == Player:SteamID64() then
				Res = true
			end
		end
		return Res
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

local ClanMemberMeta =  {}
function Clans.NewMember( Clan, Player )
	local this = {}
	setmetatable( this, ClanMemberMeta )
	
	this.Name = Player:Name()
	
	this.Rank = "Recruit" -- Recruit, Member, Officer, Administrator, Owner --
	
	this.ID = Player:SteamID64()
	
	this.Stats = Storage.Create()
	this.Stats:SetItem( "Kills", 0 )
	this.Stats:SetItem( "AllyKills", 0 )
	this.Stats:SetItem( "EnemyKills", 0 )
	this.Stats:SetItem( "Deaths", 0 )
	this.Stats:SetItem( "AllyDeaths", 0 )
	this.Stats:SetItem( "EnemyDeaths", 0 )
	this.Stats:SetItem( "MoneyGiven", 0 )
	this.Stats:SetItem( "MoneyReceived", 0 )
	this.Stats:SetItem( "BankMoneyGiven", 0 )
	this.Stats:SetItem( "BankMoneyTaken", 0 )
	
	Clan.Members:SetItem( Clan.Members:Count(), this )
	
	return this
end

local ClanBankMeta =  {}
function Clans.NewBank()
	local this = {}
	setmetatable( this, ClanBankMeta )
	
	this.Balance = 0
	
	this.Stats = Storage.Create()
	this.Stats:SetItem( "MoneyAdded" )
	this.Stats:SetItem( "MoneyTaken" )
	this.Stats:SetItem( "MostMoney" )
	
	function this.AddMoney( Amount )
		this.Balance = this.Balance + Amount
	end
	
	function this.RemoveMoney( Amount )
		this.Balance = this.Balance - Amount
	end
	
	function this.MemberAddMoney( Member, Amount )
		-- TODO: Member adding money stuff --
		this.AddMoney( Amount )
	end
	
	function this.MemberTakeMoney( Member, Amount )
	-- TODO: Member removing money stuff --
		this.RemoveMoney( Amount )
	end
	
	return this
end