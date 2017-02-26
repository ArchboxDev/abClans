-- Clan Menu --

function ClanMenuOpen()
	ClanMenuDermaBase()
end

-- Clan Menu: Derma Base --

function ClanMenuDermaBase()

	-- Frame. Everything is a child of this. --

	local frameW, frameH = 960, 500

	local frame = vgui.Create( "DFrame" )

	frame:SetTitle( "" )
	frame:SetPos( ScrW()/2 - frameW/2, ScrH()/2 - frameH/2 )
	frame:SetSize( frameW, frameH )
	frame:SetVisible( true )
	frame:SetDraggable( true )
	frame:ShowCloseButton( false )
	frame:MakePopup()

	frame.Paint = nil

	-- For all the shit you can see --

	local bodyW, bodyH = 700, 500

	local body = vgui.Create( "DFrame", frame )

	body:SetTitle( "" )
	body:SetPos( ScrW()/2 - frameW/2 + 260, ScrH()/2 - frameH/2 )
	body:SetSize( bodyW, bodyH )
	body:SetVisible( true )
	body:SetDraggable( true )
	body:ShowCloseButton( false )
	body:MakePopup()

	body.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255 ) ) -- fuck you
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 210 ) )
	end

	-- Page selection or whatever --

	local selW, selH = 250, 500

	local sel = vgui.Create( "DFrame", frame )

	sel:SetTitle( "" )
	sel:SetPos( ScrW()/2 - frameW/2, ScrH()/2 - frameH/2 )
	sel:SetSize( selW, selH )
	sel:SetVisible( true )
	sel:SetDraggable( true )
	sel:ShowCloseButton( false )
	sel:MakePopup()

	sel.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255 ) ) -- fuck you
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 210 ) )
	end

	-- Selection: Buttons --

	local selButtonW, selButtonH = 150, 30

	local selButtons = {
		["My Clan"] = {
			color = Color( 255, 255, 255 ),
			active = true
		},
		["Clan Bank"] = {
			color = Color( 255, 255, 255 ),
			active = false
		},
		["Clan Perks"] = {
			color = Color( 255, 255, 255 ),
			active = false
		},
		["Clans"] = {
			color = Color( 255, 255, 255 ),
			active = false
		}
	}

	local activeSelButton = selButtons["My Clan"]

	local selButtonDraw = function( self, w, h )
		local bColor = selButtons[ self:GetText() ].color
		
		-- there's probably a more efficient way to do this.
		if self:IsHovered() then
			bColor.r = Lerp( 0.3, bColor.r, 133 )
			bColor.g = Lerp( 0.3, bColor.g, 171 )
			bColor.b = Lerp( 0.3, bColor.g, 255 )
		elseif !( bColor == Color( 255, 255, 255 ) ) then
			bColor.r = Lerp( 0.3, bColor.r, 255 )
			bColor.g = Lerp( 0.3, bColor.g, 255 )
			bColor.b = Lerp( 0.3, bColor.g, 255 )
		end
		
		draw.RoundedBox( 2, 0, 0, w, h, bColor )
	end

	-- Selection: My Clan --

	local myClanButton = vgui.Create( "DButton", sel )

	myClanButton:SetText( "My Clan" )
	myClanButton:SetTextColor( Color( 0, 0, 0 ) )
	myClanButton:SetPos( selW/2 - selButtonW/2, selButtonH )
	myClanButton:SetSize( selButtonW, selButtonH )

	myClanButton.Paint = selButtonDraw

	myClanButton.DoClick = function()
	end

	-- Selection: Clan Bank --

	local myMembersButton = vgui.Create( "DButton", sel )

	myMembersButton:SetText( "Clan Bank" )
	myMembersButton:SetTextColor( Color( 0, 0, 0 ) )
	myMembersButton:SetPos( selW/2 - selButtonW/2, selButtonH*3 )
	myMembersButton:SetSize( selButtonW, selButtonH )

	myMembersButton.Paint = selButtonDraw

	myMembersButton.DoClick = function()
	end

	-- Selection: My Clan Perks --

	local myPerksButton = vgui.Create( "DButton", sel )

	myPerksButton:SetText( "Clan Perks" )
	myPerksButton:SetTextColor( Color( 0, 0, 0 ) )
	myPerksButton:SetPos( selW/2 - selButtonW/2, selButtonH*5 )
	myPerksButton:SetSize( selButtonW, selButtonH )

	myPerksButton.Paint = selButtonDraw

	myPerksButton.DoClick = function()
	end

	-- Selection: All Clans  --

	local ClansButton = vgui.Create( "DButton", sel )

	ClansButton:SetText( "Clans" )
	ClansButton:SetTextColor( Color( 0, 0, 0 ) )
	ClansButton:SetPos( selW/2 - selButtonW/2, selButtonH*7 )
	ClansButton:SetSize( selButtonW, selButtonH )

	ClansButton.Paint = selButtonDraw

	ClansButton.DoClick = function()
	end

	-- Close button --

	local closeButton = vgui.Create( "DButton", body )

	closeButton:SetText( "-" )
	closeButton:SetTextColor( Color( 255, 255, 255 ) )
	closeButton:SetPos( bodyW - 16, 0 )
	closeButton:SetSize( 15, 15 )

	closeButton.Paint = nil

	closeButton.DoClick = function()
		frame:Close()
	end
end

-- Debugging lol --

ClanMenuDermaBase()

-- https://this.is-a.dog/2cb600.png --