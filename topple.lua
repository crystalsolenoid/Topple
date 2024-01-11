-- title:   Topple!
-- author:  Quinten Konyn
-- desc:    Don't let the tower fall!
-- site:    QuintenKonyn.recurse.com
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

WIDTH = 240
HEIGHT = 136

t=0
x=96
y=24

local pieceLocation = function(i)
	local level = (i - 1) // 3
	local slot = (i - 1) % 3
	local orientation = level % 2
	return {level, slot, orientation}
end

function drawTower(tower)
	local piece_width = 21
	local piece_height = 5
	local tower_bottom = 100
	local tower_left = WIDTH/2 - piece_width/2
	local piece_depth = 7
	local slot_lefts = {tower_left, tower_left + piece_depth, tower_left + piece_depth * 2}
	for i = 1, #tower do
		if tower[i] == PIECE_OCCUPIED then
			local pos = pieceLocation(i)
			local y_pos = tower_bottom - pos[1] * piece_height
			if pos[3] == ROTATION then
				-- parallel to screen
				rect(WIDTH/2 - piece_width/2, y_pos, piece_width, piece_height, 4)
				rectb(WIDTH/2 - piece_width/2, y_pos, piece_width, piece_height, 3)
			else
				-- into screen
				x_pos = slot_lefts[pos[2] + 1]
				rect(x_pos, y_pos, piece_depth, piece_height, 4)
				rectb(x_pos, y_pos, piece_depth, piece_height, 3)
			end
		end
	end
end

ROTATION = 0

function TIC()

	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btnp(2) then ROTATION = (ROTATION + 1) % 2 end
	if btnp(3) then ROTATION = (ROTATION + 1) % 2 end

	PIECE_EMPTY = 0
	PIECE_OCCUPIED = 1
	local tower = { 1, 1, 1,
			1, 0, 1,
			0, 1, 0,
			1}
	cls(13)
	drawTower(tower)
	t=t+1
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

