-- abClans: Clans --

local Clans = {}

local Clans.Clans = Storage.Create()

function Clans.NewClan( Owner, Name )
	if ( Clans.Clans:GetItem( Name ) ) then return end
	
	local this = {}
	setmetatable( this, Clans )
	
	this.Owner = Owner
	this.Members = Storage.Create()
	
	this.Name = Name
	this.Abbreviation = ""
	this.Description = "No information is known about this clan. Perhaps they don't want you to know anything about them, or the owner simply hasn't added a description? Maybe " .. this.Owner.username .. " should do that."
	
	this.Perks = Storage.Create()
	
	this.MemberCount = this.Members:Count()
	
	Clans.Clans:SetItem( Name, this )
	
	return this
end