-- ===== MONSTER SKIN =====

local CONFIG = [==[
{
"replacement_rules": [
{
	"type": "group", "name": "Body",
	"children": [
		{ "name": "Monster Body", "replace_ids": [70494501482896], "mode": "cdn", "enabled": true, "scale": "body", "texture": "white", "role": "body", "cdn_url": "https://raw.githubusercontent.com/elcalzoskineitorfunk/Monster-Skin/refs/heads/main/MONSTER%20BODYY%20ver3.obj" },
		{ "name": "Monster Logo", "replace_ids": [70528849669897], "mode": "cdn", "enabled": true, "scale": "logo", "texture": "black", "color": [0, 0, 0], "role": "logo", "cdn_url": "https://raw.githubusercontent.com/elcalzoskineitorfunk/Monster-Skin/refs/heads/main/MONSTER%20LOGO%20ver10.obj" }
	]
},
{
	"type": "group", "name": "Animation",
	"children": [
		{ "name": "Mns Animation [1]", "replace_ids": [81951883744250], "mode": "id", "enabled": true, "with_id": 106136416209642 },
		{ "name": "Mns Animation [2]", "replace_ids": [78544849697314], "mode": "id", "enabled": true, "with_id": 134840101984538 },
		{ "name": "Mns Animation [3]", "replace_ids": [108185321380462], "mode": "id", "enabled": true, "with_id": 116339164768827 },
		{ "name": "Mns Animation [4]", "replace_ids": [118241731290742], "mode": "id", "enabled": true, "with_id": 134433050302557 },
		{ "name": "Mns Use", "replace_ids": [73325703605178, 94406584083681], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/elcalzoskineitorfunk/Monster-Skin/refs/heads/main/monster-energy.mp3" }
	]
},
{
	"type": "group", "name": "Icon",
	"children": [
		{ "name": "Monster Icon", "replace_ids": [104600246515190], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/mrbeanissohot/Bean-sValorant/main/white_monster_icon.png" }
	]
}
]
}
]==]

-- converted/cached files go here (your own files stay in AWildcat/monster)
local CDN_FOLDER = "AWildcat/monster_cache"
local MESH_METHOD = "both"  -- "both", "direct" or "apply" (try another if meshes don't show)
local CONVERT_OBJ = true    -- true = turn downloaded .obj into Roblox .mesh
local REFRESH = false       -- true = delete cached downloads and download everything again

-- size multipliers (used by the "scale" field in the rules)
local SCALES = {
	body = 0.6, -- can: 1.0 = normal, 1.1 = 10% bigger
	logo = 0.45, -- Monster logo: 1.0 = normal, lower = smaller (0.8 = 20% smaller)
}

-- true  = weapon icons use the generated textures
-- false = weapon icons use the original GitHub pngs
local ICONS_USE_TEXTURES = false

-- texture version: change it to force the generated textures to be rebuilt
local TEXTURE_VERSION = "v2"




---

-- environment check

local missing = {}
for _, p in ipairs({
	{ "isfile", isfile }, { "writefile", writefile },
	{ "getcustomasset", getcustomasset }, { "makefolder", makefolder }, { "isfolder", isfolder },
}) do
	if type(p[2]) ~= "function" then missing[#missing + 1] = p[1] end
end
if #missing > 0 then
	warn("[Monster] Delta is missing: " .. table.concat(missing, ", ") .. " - cannot run")
	return
end

if not isfolder("AWildcat") then pcall(makefolder, "AWildcat") end
if not isfolder("AWildcat/monster") then pcall(makefolder, "AWildcat/monster") end
if not isfolder(CDN_FOLDER) then pcall(makefolder, CDN_FOLDER) end

if REFRESH and listfiles and delfile then
	for _, f in ipairs(listfiles(CDN_FOLDER)) do pcall(delfile, f) end
	print("[Monster] cache cleared")
end


---

-- download + convert

local function hashStr(s)
	local h = 5381
	for i = 1, #s do h = (h * 33 + s:byte(i)) % 4294967296 end
	return string.format("%08x", h)
end

local function download(url)
	local ok, res = pcall(function() return game:HttpGet(url) end)
	if ok and type(res) == "string" and #res > 0 then return res end
	local req = request or http_request or (syn and syn.request)
	if req then
		local ok2, r = pcall(req, { Url = url, Method = "GET" })
		if ok2 and r and r.StatusCode == 200 and type(r.Body) == "string" and #r.Body > 0 then
			return r.Body
		end
	end
	return nil
end

local function objToMesh(text)
	local v, vt, vn, out = {}, {}, {}, {}
	local tris, faces = 0, 0

	local function idx(s, n)
		if s == nil or s == "" then return nil end
		local i = tonumber(s)
		if not i then return nil end
		if i < 0 then return n + i + 1 end
		return i
	end

	local function corner(a, b, c)
		local p = v[idx(a, #v) or 0]
		if not p then return nil end
		local n = vn[idx(c, #vn) or 0] or { 0, 1, 0 }
		local t = vt[idx(b, #vt) or 0] or { 0, 0 }
		return string.format("[%.5f,%.5f,%.5f][%.4f,%.4f,%.4f][%.5f,%.5f,0]",
			p[1], p[2], p[3], n[1], n[2], n[3], t[1], 1 - t[2])
	end

	for line in text:gmatch("[^\r\n]+") do
		local c = line:sub(1, 2)
		if c == "v " then
			local x, y, z = line:match("^v%s+(%S+)%s+(%S+)%s+(%S+)")
			v[#v + 1] = { tonumber(x) or 0, tonumber(y) or 0, tonumber(z) or 0 }
		elseif c == "vt" then
			local u, w = line:match("^vt%s+(%S+)%s+(%S+)")
			vt[#vt + 1] = { tonumber(u) or 0, tonumber(w) or 0 }
		elseif c == "vn" then
			local x, y, z = line:match("^vn%s+(%S+)%s+(%S+)%s+(%S+)")
			vn[#vn + 1] = { tonumber(x) or 0, tonumber(y) or 1, tonumber(z) or 0 }
		elseif c == "f " then
			local corners = {}
			for tok in line:gmatch("%S+") do
				if tok ~= "f" then
					local a, b, cc = tok:match("^(%-?%d+)/?(%-?%d*)/?(%-?%d*)")
					local s = a and corner(a, b, cc)
					if s then corners[#corners + 1] = s end
				end
			end
			for i = 2, #corners - 1 do
				out[#out + 1] = corners[1]
				out[#out + 1] = corners[i]
				out[#out + 1] = corners[i + 1]
				tris = tris + 1
			end
			faces = faces + 1
			if faces % 4000 == 0 then task.wait() end
		end
	end
	if tris == 0 then return nil, 0 end
	return "version 1.00\n" .. tris .. "\n" .. table.concat(out), tris
end

local stats = { cached = 0, downloaded = 0, failed = 0 }
local failedList = {}
local cdnAssets = {}

local function loadAsset(path)
	for _ = 1, 5 do
		if isfile(path) then
			local ok, asset = pcall(getcustomasset, path)
			if ok and asset then return asset end
		end
		task.wait(0.3)
	end
	return nil
end

local loading = {}
local loadCdnInner

local function loadCdn(url)
	if cdnAssets[url] then return cdnAssets[url] end
	if loading[url] then
		while loading[url] do task.wait() end
		return cdnAssets[url]
	end
	loading[url] = true
	local ok, res = pcall(loadCdnInner, url)
	loading[url] = nil
	if ok then return res end
	return nil
end

loadCdnInner = function(url)
	local name = url:match("[^/]+$") or url
	local ext = (url:match("%.(%w+)$") or "bin"):lower()
	local convert = (ext == "obj" and CONVERT_OBJ)
	local path = CDN_FOLDER .. "/" .. hashStr(url) .. "." .. (convert and "mesh" or ext)

	if isfile(path) then
		stats.cached += 1
	else
		print("[Monster] downloading " .. name)
		local data = download(url)
		if not data then
			stats.failed += 1
			failedList[#failedList + 1] = name .. " (download failed)"
			return nil
		end
		-- GitHub returns a tiny "404: Not Found" text for bad links
		if #data < 200 and data:find("404") then
			stats.failed += 1
			failedList[#failedList + 1] = name .. " (404 not found)"
			return nil
		end
		if convert then
			local mesh, tris = objToMesh(data)
			if not mesh then
				stats.failed += 1
				failedList[#failedList + 1] = name .. " (no faces in obj)"
				return nil
			end
			print(("[Monster] %s -> %d triangles"):format(name, tris))
			if tris > 20000 then
				warn("[Monster] " .. name .. " has over 20k triangles, Roblox may refuse it")
			end
			data = mesh
		end
		if not pcall(writefile, path, data) then
			stats.failed += 1
			failedList[#failedList + 1] = name .. " (could not save)"
			return nil
		end
		stats.downloaded += 1
	end

	local asset = loadAsset(path)
	if not asset then
		stats.failed += 1
		failedList[#failedList + 1] = name .. " (getcustomasset failed)"
		return nil
	end
	cdnAssets[url] = asset
	return asset
end


---

-- custom texture generator (builds real PNG files, no downloads needed)

local crcTable = {}
for i = 0, 255 do
	local c = i
	for _ = 1, 8 do
		if bit32.band(c, 1) == 1 then
			c = bit32.bxor(bit32.rshift(c, 1), 0xEDB88320)
		else
			c = bit32.rshift(c, 1)
		end
	end
	crcTable[i] = c
end

local function crc32(s)
	local c = 0xFFFFFFFF
	for i = 1, #s do
		c = bit32.bxor(crcTable[bit32.band(bit32.bxor(c, s:byte(i)), 0xFF)], bit32.rshift(c, 8))
	end
	return bit32.bxor(c, 0xFFFFFFFF)
end

local function adler32(s)
	local a, b = 1, 0
	for i = 1, #s do
		a = (a + s:byte(i)) % 65521
		b = (b + a) % 65521
	end
	return b * 65536 + a
end

local function pngChunk(kind, data)
	return string.pack(">I4", #data) .. kind .. data .. string.pack(">I4", crc32(kind .. data))
end

local function makePng(w, h, pixel)
	local rows = {}
	for y = 0, h - 1 do
		local row = { "\0" }
		for x = 0, w - 1 do
			local r, g, b = pixel(x, y)
			row[#row + 1] = string.char(r, g, b)
		end
		rows[#rows + 1] = table.concat(row)
	end
	local raw = table.concat(rows)

	-- zlib stream made of "stored" (uncompressed) deflate blocks
	local blocks = { "\120\1" }
	local pos = 1
	while pos <= #raw do
		local piece = raw:sub(pos, pos + 65534)
		pos += #piece
		local final = (pos > #raw) and 1 or 0
		blocks[#blocks + 1] = string.char(final)
			.. string.pack("<I2", #piece)
			.. string.pack("<I2", bit32.band(bit32.bnot(#piece), 0xFFFF))
			.. piece
	end
	blocks[#blocks + 1] = string.pack(">I4", adler32(raw))

	return "\137PNG\r\n\26\n"
		.. pngChunk("IHDR", string.pack(">I4I4", w, h) .. "\8\2\0\0\0")
		.. pngChunk("IDAT", table.concat(blocks))
		.. pngChunk("IEND", "")
end

local RED = { 205, 20, 30 }
local WHITE = { 245, 245, 245 }
local BLACK = { 0, 0, 0 }

local TEXTURES = {
	-- assault rifle: white + red diagonal stripes with a red edge
	ar = function(x, y)
		local c
		if x < 8 or y < 8 or x >= 248 or y >= 248 then
			c = RED
		elseif ((x + y) // 32) % 2 == 0 then
			c = RED
		else
			c = WHITE
		end
		return c[1], c[2], c[3]
	end,
	-- sniper: black with white stripes
	sniper = function(x, y)
		local c = BLACK
		if (x - y) % 64 < 14 then c = WHITE end
		return c[1], c[2], c[3]
	end,
	-- monster can: white with faint claw marks
	white = function(x, y)
		local v = 252
		for k = -1, 1 do
			local cx = 128 + k * 40 + (y - 128) * 0.35
			if y > 40 and y < 216 and math.abs(x - cx) < 6 then v = 210 end
		end
		return v, v, v
	end,
	-- logo: plain black
	black = function()
		return 0, 0, 0
	end,
	-- daggers: plain black
	dagger = function()
		return 0, 0, 0
	end,
}

local textureAssets = {}

local function texAsset(key)
	if textureAssets[key] then return textureAssets[key] end
	local gen = TEXTURES[key]
	if not gen then
		warn("[Monster] unknown texture: " .. tostring(key))
		return nil
	end
	local path = CDN_FOLDER .. "/tex_" .. key .. "_" .. TEXTURE_VERSION .. ".png"
	if not isfile(path) then
		local ok, png = pcall(makePng, 256, 256, gen)
		if not ok or not pcall(writefile, path, png) then
			stats.failed += 1
			failedList[#failedList + 1] = "texture " .. key .. " (could not build)"
			return nil
		end
		print("[Monster] built texture: " .. key)
	end
	local asset = loadAsset(path)
	if not asset then
		stats.failed += 1
		failedList[#failedList + 1] = "texture " .. key .. " (getcustomasset failed)"
		return nil
	end
	textureAssets[key] = asset
	return asset
end


---

-- rules

local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local rules = HttpService:JSONDecode(CONFIG).replacement_rules
local lookup, meshCache = {}, {}
local registered, swapped = 0, 0

local function parseId(v)
	return tonumber(tostring(v):match("(%d+)"))
end

-- local files: loads straight from your executor workspace folder
local function loadLocal(path)
	local name = path:match("[^/\\]+$") or path
	if not isfile(path) then
		stats.failed += 1
		failedList[#failedList + 1] = name .. " (not found in workspace: " .. path .. ")"
		return nil
	end
	local ext = (path:match("%.(%w+)$") or "bin"):lower()
	if ext == "obj" and CONVERT_OBJ then
		if type(readfile) ~= "function" then
			stats.failed += 1
			failedList[#failedList + 1] = name .. " (executor has no readfile)"
			return nil
		end
		local okr, data = pcall(readfile, path)
		if not okr or type(data) ~= "string" or #data == 0 then
			stats.failed += 1
			failedList[#failedList + 1] = name .. " (could not read)"
			return nil
		end
		local cachePath = CDN_FOLDER .. "/local_" .. hashStr(path .. #data) .. ".mesh"
		if not isfile(cachePath) then
			local mesh, tris = objToMesh(data)
			if not mesh then
				stats.failed += 1
				failedList[#failedList + 1] = name .. " (no faces in obj)"
				return nil
			end
			print(("[Monster] %s -> %d triangles"):format(name, tris))
			if tris > 20000 then
				warn("[Monster] " .. name .. " has over 20k triangles, Roblox may refuse it")
			end
			if not pcall(writefile, cachePath, mesh) then
				stats.failed += 1
				failedList[#failedList + 1] = name .. " (could not save)"
				return nil
			end
		else
			stats.cached += 1
		end
		path = cachePath
	end
	local asset = loadAsset(path)
	if not asset then
		stats.failed += 1
		failedList[#failedList + 1] = name .. " (getcustomasset failed)"
		return nil
	end
	return asset
end

local function resolve(rule)
	if rule.mode == "texture" then
		return texAsset(rule.texture)
	end
	if rule.mode == "cdn" then
		return loadCdn(rule.cdn_url)
	end
	if rule.mode == "local" then
		return loadLocal(rule.local_path)
	end
	if rule.with_id then return "rbxassetid://" .. rule.with_id end
	return ""
end

local function flatten(list, out)
	for _, r in ipairs(list) do
		if r.type == "group" then
			flatten(r.children or {}, out)
		elseif r.enabled then
			local skip = (r.icon == "texture" and not ICONS_USE_TEXTURES)
				or (r.icon == "original" and ICONS_USE_TEXTURES)
			if not skip then out[#out + 1] = r end
		end
	end
	return out
end

-- resolve (download / convert) EVERY rule at the same time
local active = flatten(rules, {})
local targets = {}
local pendingCount = #active
for i, rule in ipairs(active) do
	task.spawn(function()
		local ok, res = pcall(resolve, rule)
		if ok then targets[i] = res end
		pendingCount -= 1
	end)
end
while pendingCount > 0 do task.wait() end

-- register in the original rule order so overlapping ids behave the same
local meshAssets = {}
for i, rule in ipairs(active) do
	local target = targets[i]
	if target ~= nil then
		registered += 1

		local entry = { target = target }
		if rule.scale then entry.scale = SCALES[rule.scale] end
		entry.fit = rule.fit
		entry.role = rule.role
		if rule.color then
			entry.color = Color3.fromRGB(rule.color[1], rule.color[2], rule.color[3])
		end
		if rule.texture and rule.mode ~= "texture" then
			entry.texture = texAsset(rule.texture)
		end
		if target ~= "" and rule.mode ~= "texture" and (rule.texture or rule.scale) then
			meshAssets[target] = true
		end

		for _, id in ipairs(rule.replace_ids) do
			local n = parseId(id)
			if n then lookup[n] = entry end
		end
	end
end

-- pre-load every replacement mesh at once so all weapons swap instantly
if MESH_METHOD ~= "direct" then
	local warming = 0
	for asset in pairs(meshAssets) do
		warming += 1
		task.spawn(function()
			pcall(function()
				meshCache[asset] = AssetService:CreateMeshPartAsync(asset)
			end)
			warming -= 1
		end)
	end
	local t0 = os.clock()
	while warming > 0 and os.clock() - t0 < 15 do task.wait() end
end

print(("[Monster] rules ready: %d | cached: %d | downloaded: %d | failed: %d"):format(
	registered, stats.cached, stats.downloaded, stats.failed))
for _, f in ipairs(failedList) do warn("[Monster] FAILED: " .. f) end


---

-- apply to the game

local PROPS = {
	MeshPart = { "MeshId", "TextureID" },
	SpecialMesh = { "MeshId", "TextureId" },
	Sound = { "SoundId" },
	Animation = { "AnimationId" },
	Decal = { "Texture" },
	Texture = { "Texture" },
	ImageLabel = { "Image" },
	ImageButton = { "Image" },
	SurfaceAppearance = { "ColorMap", "NormalMap", "MetalnessMap", "RoughnessMap" },
}

local seen = setmetatable({}, { __mode = "k" })
local forcedTexture = setmetatable({}, { __mode = "k" }) -- inst -> custom texture asset
local scaleState = setmetatable({}, { __mode = "k" })    -- inst -> target size/scale (false = pending)

local function hideMesh(inst)
	pcall(function()
		if inst:IsA("MeshPart") then
			inst.Transparency = 1
		elseif inst:IsA("SpecialMesh") then
			inst.Scale = Vector3.new(0, 0, 0)
		end
	end)
end

local origSize = setmetatable({}, { __mode = "k" }) -- inst -> size the game gave the original mesh
local fitState = setmetatable({}, { __mode = "k" })  -- inst -> undistorted size for the new mesh

-- keep the new mesh's REAL proportions (no stretching to the old mesh's box)
-- the longest side stays the same length as the original, the rest follows the model
local function fitMesh(inst, asset)
	pcall(function()
		local target = fitState[inst]
		if not target then
			local mp = meshCache[asset]
			if not mp then
				local ok, res = pcall(function() return AssetService:CreateMeshPartAsync(asset) end)
				if ok then
					mp = res
					meshCache[asset] = mp
				end
			end
			local o = origSize[inst]
			if mp and o then
				local n = mp.Size
				local nMax = math.max(n.X, n.Y, n.Z)
				if nMax > 0 then
					local f = math.max(o.X, o.Y, o.Z) / nMax
					target = n * f
					fitState[inst] = target
				end
			end
		end
		if target then inst.Size = target end
	end)
end

local function applyMesh(inst, asset, entry)
	if not inst:IsA("MeshPart") then
		pcall(function() inst.MeshId = asset end)
		return
	end
	if not origSize[inst] then origSize[inst] = inst.Size end -- remember BEFORE swapping
	if MESH_METHOD ~= "apply" then
		pcall(function() inst.MeshId = asset end)
	end
	if MESH_METHOD ~= "direct" then
		local ok, err = pcall(function()
			local mp = meshCache[asset]
			if not mp then
				mp = AssetService:CreateMeshPartAsync(asset)
				meshCache[asset] = mp
			end
			inst:ApplyMesh(mp)
		end)
		if not ok then warn("[Monster] ApplyMesh failed: " .. tostring(err)) end
	end
	if not entry or entry.fit ~= false then fitMesh(inst, asset) end
end

local function setTarget(inst, value)
	pcall(function()
		if inst:IsA("MeshPart") then
			inst.Size = value
		else
			inst.Scale = value
		end
	end)
end

local function applyScale(inst, factor)
	if not factor or factor == 1 then return end
	local st = scaleState[inst]
	if st ~= nil then
		-- already scaled (or pending): just re-assert the size after a mesh swap
		if st then
			task.defer(setTarget, inst, st)
		end
		return
	end
	scaleState[inst] = false
	task.spawn(function()
		task.wait(0.1) -- let the new mesh settle so we multiply its real size
		local target
		pcall(function()
			if inst:IsA("MeshPart") then
				target = inst.Size * factor
			elseif inst:IsA("SpecialMesh") then
				target = inst.Scale * factor
			end
		end)
		if target then
			scaleState[inst] = target
			setTarget(inst, target)
		end
	end)
end

local function setTexture(inst, asset)
	local prop = inst:IsA("SpecialMesh") and "TextureId" or "TextureID"
	forcedTexture[inst] = asset
	pcall(function() inst[prop] = asset end)
end

-- glue the logo onto the REAL surface of the can (raycast against the mesh, not the hitbox)
local roleOf = setmetatable({}, { __mode = "k" })
local glueStarted = setmetatable({}, { __mode = "k" })

local function tryGlue(inst)
	if glueStarted[inst] then return end
	glueStarted[inst] = true
	for _ = 1, 40 do
		task.wait(1)
		local ok = pcall(function()
			local root = inst:FindFirstAncestorWhichIsA("Tool")
				or inst:FindFirstAncestorWhichIsA("Model") or inst.Parent
			if not root then error("no root") end
			local body, logo
			for _, d in ipairs(root:GetDescendants()) do
				if roleOf[d] == "body" and not body then body = d end
				if roleOf[d] == "logo" and not logo then logo = d end
			end
			if not body or not logo then error("pair not ready") end
			if scaleState[body] == false then error("body still scaling") end
			if not body:IsDescendantOf(workspace) then error("not in workspace") end

			pcall(function() body.CollisionFidelity = Enum.CollisionFidelity.PreciseConvexDecomposition end)
			pcall(function() body.CanQuery = true end)

			local center = body.Position
			local offset = logo.Position - center
			if offset.Magnitude < 0.001 then error("logo at center") end
			local dir = offset.Unit

			local rp = RaycastParams.new()
			rp.FilterType = Enum.RaycastFilterType.Include
			rp.FilterDescendantsInstances = { body }
			local far = body.Size.Magnitude + offset.Magnitude + 2
			local res = workspace:Raycast(center + dir * far, -dir * far * 2, rp)
			if not res then error("no hit") end

			-- how far the logo reaches along the surface normal (so its back touches the can)
			local n, cf, sz = res.Normal, logo.CFrame, logo.Size
			local half = (math.abs(n:Dot(cf.RightVector)) * sz.X
				+ math.abs(n:Dot(cf.UpVector)) * sz.Y
				+ math.abs(n:Dot(cf.LookVector)) * sz.Z) / 2
			local newCf = CFrame.new(res.Position + n * (half - 0.01)) * (cf - cf.Position)

			-- remove old joints on the logo, then weld it to the can
			for _, d in ipairs(root:GetDescendants()) do
				if (d:IsA("JointInstance") or d:IsA("WeldConstraint"))
					and (d.Part0 == logo or d.Part1 == logo) then
					pcall(function() d.Enabled = false end)
				end
			end
			logo.CFrame = newCf
			local w = Instance.new("WeldConstraint")
			w.Part0 = body
			w.Part1 = logo
			w.Parent = logo
			print("[Monster] logo glued to can")
		end)
		if ok then return end
	end
	glueStarted[inst] = nil
	warn("[Monster] could not glue the logo (can not in workspace?)")
end

local function handle(inst, p)
	local ok, cur = pcall(function() return inst[p] end)
	if not ok then return end

	-- keep our custom texture if the game tries to change it back
	local forced = forcedTexture[inst]
	if forced and (p == "TextureID" or p == "TextureId") then
		if cur ~= forced then
			pcall(function() inst[p] = forced end)
		end
		return
	end

	local id = parseId(cur)
	local entry = id and lookup[id]
	if entry == nil then return end
	local new = entry.target

	swapped += 1
	if swapped <= 15 then
		print("[Monster] swapped " .. inst.ClassName .. "." .. p .. " (" .. tostring(id) .. ")")
	end

	if p == "MeshId" then
		if new == "" then
			hideMesh(inst)
		else
			applyMesh(inst, new, entry)
			if entry.texture then setTexture(inst, entry.texture) end
			if entry.color then pcall(function() inst.Color = entry.color end) end
			applyScale(inst, entry.scale)
			if entry.role then
				roleOf[inst] = entry.role
				task.spawn(tryGlue, inst)
			end
		end
	else
		pcall(function() inst[p] = new end)
	end
end

local function apply(inst)
	local props = PROPS[inst.ClassName]
	if not props or seen[inst] then return end
	seen[inst] = true
	for _, p in ipairs(props) do
		task.spawn(handle, inst, p)
		pcall(function()
			inst:GetPropertyChangedSignal(p):Connect(function()
				handle(inst, p)
			end)
		end)
	end
end

local function scan()
	local n = 0
	for _, d in ipairs(game:GetDescendants()) do
		apply(d)
		n += 1
		if n % 2000 == 0 then task.wait() end
	end
end

local function scanNil()
	if type(getnilinstances) ~= "function" then return end
	pcall(function()
		for _, d in ipairs(getnilinstances()) do
			apply(d)
			for _, c in ipairs(d:GetDescendants()) do apply(c) end
		end
	end)
end

game.DescendantAdded:Connect(apply)
scan()
scanNil()

-- catch parts that load late
task.spawn(function()
	while true do
		task.wait(2)
		scan()
		scanNil()
	end
end)

print("[Monster] loaded")
