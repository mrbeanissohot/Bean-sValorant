-- Valorant replacer (arms 2.3x, AR 2.5x, white/red splat texture on AR + sniper + daggers)
--
-- Extra rule fields:
--   "scale": 2.5          multiply the part's size by this
--   "scale_joints": true  also move the Motor6D/Weld offsets so the pieces stay lined up when scaled
--   "splat": true         paint the part with the generated white + red splat texture

local CONFIG = [==[
{
  "replacement_rules": [
    { "name": "Profile 4", "replace_ids": [12307734932], "mode": "cdn", "enabled": true, "scale": 2.3, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/arm/valorant-leftV2.obj" },
    { "name": "Profile 5", "replace_ids": [12307583853], "mode": "cdn", "enabled": true, "scale": 2.3, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/arm/valorant-rightV2.obj" },
    { "name": "Profile 6", "replace_ids": [144076357], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/arm/FP_Wushu_S0_DF.png" },
    { "name": "ar", "replace_ids": [12613283569, 12613284249, 14652718299, 12613284768], "mode": "id", "enabled": true },
    { "name": "ar", "replace_ids": [12613284036], "mode": "cdn", "enabled": true, "scale": 2.5, "scale_joints": true, "splat": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/Gaia-Vandal-Red/Gaia-Vandal-Red-mergedv2.obj" },
    { "name": "ar", "replace_ids": [12613284529], "mode": "cdn", "enabled": true, "scale": 2.5, "scale_joints": true, "splat": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/Gaia-Vandal-Red/Gaia-Vandal-Red-Mag-mergedv2.obj" },
    { "name": "ar", "replace_ids": [13087362838], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/sound/Gaias%20shoot.mp3" },
    { "name": "sinper", "replace_ids": [13188892651, 14002915797, 14774727092, 13188893017, 13188893115, 14778413014, 13270206222, 13455394948, 13188892855, 13188893310], "mode": "id", "enabled": true },
    { "name": "sinper", "replace_ids": [13188892761], "mode": "cdn", "enabled": true, "splat": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/chamber-sinper/main.obj" },
    { "name": "sinper", "replace_ids": [13270206087], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/sound/Preview_TourDeForce_Fire_FP_Full.wav" },
    { "name": "sinper", "replace_ids": [13188892532], "mode": "id", "enabled": true },
    { "name": "sinper", "replace_ids": [13269934368], "mode": "id", "enabled": true, "with_id": 89426100452654 },
    { "name": "sinper", "replace_ids": [13188893310, 13455229188, 13455229044, 13455394948, 13455395017], "mode": "id", "enabled": true },
    { "name": "dagg", "replace_ids": [73385702554774], "mode": "cdn", "enabled": true, "splat": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/jett-dagger/main.obj" },
    { "name": "dagg", "replace_ids": [124614507878585], "mode": "id", "enabled": true },
    { "name": "dagg", "replace_ids": [119886777451265], "mode": "id", "enabled": true, "with_id": 95318866540833 },
    { "name": "dagg", "replace_ids": [129248911141724], "mode": "id", "enabled": true, "with_id": 92527815421098 },
    { "name": "dagg", "replace_ids": [107117835992268], "mode": "id", "enabled": true, "with_id": 111373555305620 },
    { "name": "dagg", "replace_ids": [76331161535117], "mode": "id", "enabled": true, "with_id": 138921174963297 },
    { "name": "dagg", "replace_ids": [136507313237137], "mode": "id", "enabled": true, "with_id": 95472048087093 },
    { "name": "dagg", "replace_ids": [91782309305074], "mode": "id", "enabled": true, "with_id": 77149665703840 },
    { "name": "dagg", "replace_ids": [99837158417289], "mode": "id", "enabled": true },
    { "name": "dagg", "replace_ids": [101759165907297], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/sound/Wushu_AbilX_Cast_Dagger_1P_01.wav" },
    { "name": "dagg", "replace_ids": [76357741438822], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/sound/Wushu_AbilX_Cast_Dagger_1P_03.wav" },
    { "name": "ar", "replace_ids": [17160682738], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/Gaia-Vandal-Red/ar.png" },
    { "name": "dagger", "replace_ids": [91885384580845], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/jett-dagger/daggers.png" },
    { "name": "sinper", "replace_ids": [17160799574], "mode": "cdn", "enabled": true, "cdn_url": "https://raw.githubusercontent.com/engnyg/123f1/refs/heads/main/valorant/chamber-sinper/sniper.png" }
  ]
}
]==]

local CDN_FOLDER = "AWildcat/valorant"
local MESH_METHOD = "both"  -- "both", "direct" or "apply" (try another if meshes don't show)
local CONVERT_OBJ = true    -- true = turn downloaded .obj into Roblox .mesh
local REFRESH = false       -- true = delete cached downloads (and the splat texture) and make everything again

-- scaling
local SCALE_JOINTS = true   -- false = only resize the parts (use this if the gun/arms end up in the wrong place)

-- performance
local WATCH_ALL = false     -- true = listen for changes on EVERY mesh/decal (old behaviour, laggy)
local RESCAN_INTERVAL = 0   -- seconds between full rescans. 0 = off (DescendantAdded already catches new parts)

---------------------------------------------------------------------
-- environment check
---------------------------------------------------------------------
local missing = {}
for _, p in ipairs({
	{ "isfile", isfile }, { "writefile", writefile },
	{ "getcustomasset", getcustomasset }, { "makefolder", makefolder }, { "isfolder", isfolder },
}) do
	if type(p[2]) ~= "function" then missing[#missing + 1] = p[1] end
end
if #missing > 0 then
	warn("[Valorant] Delta is missing: " .. table.concat(missing, ", ") .. " - cannot run")
	return
end

if not isfolder("AWildcat") then pcall(makefolder, "AWildcat") end
if not isfolder(CDN_FOLDER) then pcall(makefolder, CDN_FOLDER) end

if REFRESH and listfiles and delfile then
	for _, f in ipairs(listfiles(CDN_FOLDER)) do pcall(delfile, f) end
	print("[Valorant] cache cleared")
end

---------------------------------------------------------------------
-- download + convert
---------------------------------------------------------------------
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

local function loadCdn(url)
	if cdnAssets[url] then return cdnAssets[url] end
	local name = url:match("[^/]+$") or url
	local ext = (url:match("%.(%w+)$") or "bin"):lower()
	local convert = (ext == "obj" and CONVERT_OBJ)
	local path = CDN_FOLDER .. "/" .. hashStr(url) .. "." .. (convert and "mesh" or ext)

	if isfile(path) then
		stats.cached += 1
	else
		print("[Valorant] downloading " .. name)
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
			print(("[Valorant] %s -> %d triangles"):format(name, tris))
			if tris > 20000 then
				warn("[Valorant] " .. name .. " has over 20k triangles, Roblox may refuse it")
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

---------------------------------------------------------------------
-- splat texture (white + red, generated once and cached as a png)
---------------------------------------------------------------------
local SPLAT_SIZE = 512
local SPLAT_FILE = CDN_FOLDER .. "/splat_v1.png"

local crcTable = {}
for i = 0, 255 do
	local c = i
	for _ = 1, 8 do
		if bit32.band(c, 1) == 1 then
			c = bit32.bxor(0xEDB88320, bit32.rshift(c, 1))
		else
			c = bit32.rshift(c, 1)
		end
	end
	crcTable[i] = c
end

local function crc32(s)
	local c = 0xFFFFFFFF
	local n, i, calls = #s, 1, 0
	while i <= n do
		local j = math.min(i + 2047, n)
		local bytes = { string.byte(s, i, j) }
		for k = 1, #bytes do
			c = bit32.bxor(crcTable[bit32.bxor(bit32.band(c, 0xFF), bytes[k])], bit32.rshift(c, 8))
		end
		i = j + 1
		calls += 1
		if calls % 64 == 0 then task.wait() end
	end
	return bit32.bxor(c, 0xFFFFFFFF)
end

local function adler32(s)
	local a, b = 1, 0
	local n, i = #s, 1
	while i <= n do
		local j = math.min(i + 2047, n)
		local bytes = { string.byte(s, i, j) }
		for k = 1, #bytes do
			a += bytes[k]
			b += a
		end
		a %= 65521
		b %= 65521
		i = j + 1
	end
	return b * 65536 + a
end

local function u32(n)
	return string.char(
		bit32.band(bit32.rshift(n, 24), 255), bit32.band(bit32.rshift(n, 16), 255),
		bit32.band(bit32.rshift(n, 8), 255), bit32.band(n, 255))
end

local function pngChunk(tag, data)
	return u32(#data) .. tag .. data .. u32(crc32(tag .. data))
end

-- zlib stream made of "stored" (uncompressed) blocks - simple and valid
local function zlibStored(raw)
	local out = { "\120\1" }
	local n, i = #raw, 1
	while i <= n do
		local j = math.min(i + 65534, n)
		local len = j - i + 1
		local nlen = 65535 - len
		out[#out + 1] = string.char(j == n and 1 or 0, len % 256, math.floor(len / 256), nlen % 256, math.floor(nlen / 256))
		out[#out + 1] = raw:sub(i, j)
		i = j + 1
	end
	out[#out + 1] = u32(adler32(raw))
	return table.concat(out)
end

local function buildSplatPng()
	local size = SPLAT_SIZE
	local rng = Random.new(20261011)
	local grid = table.create(size * size, 0) -- 0 white, 1 red, 2 deep red

	local function disc(cx, cy, r, color)
		if r < 0.7 then r = 0.7 end
		local ix, iy = math.floor(cx + 0.5), math.floor(cy + 0.5)
		local ir = math.ceil(r)
		local r2 = r * r
		for dy = -ir, ir do
			local rem = r2 - dy * dy
			if rem >= 0 then
				local row = ((iy + dy) % size) * size
				local span = math.floor(math.sqrt(rem))
				for dx = -span, span do
					grid[row + (ix + dx) % size + 1] = color
				end
			end
		end
	end

	local function splat(cx, cy, R, core)
		disc(cx, cy, R, 1)
		for _ = 1, rng:NextInteger(9, 16) do
			local th = rng:NextNumber() * 6.2832
			local ca, sa = math.cos(th), math.sin(th)
			local len = R * (0.7 + rng:NextNumber() * 1.7)
			local w = R * (0.14 + rng:NextNumber() * 0.22)
			local spacing = math.max(1, w * 0.6)
			local d0 = R * 0.7
			local d = d0
			local dEnd = d0 + len
			while d < dEnd do
				local t = (d - d0) / len
				disc(cx + ca * d, cy + sa * d, w * (1 - 0.6 * t), 1)
				d += spacing
			end
			disc(cx + ca * dEnd, cy + sa * dEnd, w * (0.9 + rng:NextNumber() * 0.7), 1) -- bulb at the tip
			local fd = dEnd + w * (2 + rng:NextNumber() * 4)
			disc(cx + ca * fd, cy + sa * fd, math.max(1.2, w * (0.25 + rng:NextNumber() * 0.4)), 1) -- flying drop
		end
		for _ = 1, math.floor(R / 2) do
			local th = rng:NextNumber() * 6.2832
			local dd = R * (1.3 + rng:NextNumber() * 2.6)
			disc(cx + math.cos(th) * dd, cy + math.sin(th) * dd, math.max(1.2, R * (0.03 + rng:NextNumber() * 0.08)), 1)
		end
		if core then
			disc(cx, cy, R * 0.55, 2)
			disc(cx + R * 0.25, cy - R * 0.2, R * 0.28, 1)
		end
	end

	for _ = 1, 7 do
		splat(rng:NextNumber() * size, rng:NextNumber() * size, 26 + rng:NextNumber() * 26, true)
	end
	for _ = 1, 10 do
		splat(rng:NextNumber() * size, rng:NextNumber() * size, 9 + rng:NextNumber() * 10, false)
	end
	for _ = 1, 140 do
		local q = rng:NextNumber()
		disc(rng:NextNumber() * size, rng:NextNumber() * size, 1.5 + q * q * 3.5, 1)
	end

	local palette = {
		[0] = { 236, 232, 225 }, -- white
		[1] = { 255, 70, 85 },   -- red
		[2] = { 196, 40, 56 },   -- deep red
	}
	local rows = {}
	for y = 0, size - 1 do
		local t = { 0 } -- png filter byte
		local base, n = y * size, 1
		for x = 1, size do
			local c = palette[grid[base + x]]
			t[n + 1], t[n + 2], t[n + 3] = c[1], c[2], c[3]
			n += 3
		end
		rows[#rows + 1] = string.char(table.unpack(t))
		if y % 64 == 0 then task.wait() end
	end

	local ihdr = u32(size) .. u32(size) .. string.char(8, 2, 0, 0, 0)
	return string.char(137, 80, 78, 71, 13, 10, 26, 10)
		.. pngChunk("IHDR", ihdr)
		.. pngChunk("IDAT", zlibStored(table.concat(rows)))
		.. pngChunk("IEND", "")
end

local splatAsset = nil
local function prepareSplat()
	if not isfile(SPLAT_FILE) then
		print("[Valorant] making splat texture (first run only)")
		local ok, png = pcall(buildSplatPng)
		if not ok or not png then
			warn("[Valorant] splat texture failed: " .. tostring(png))
			return
		end
		if not pcall(writefile, SPLAT_FILE, png) then
			warn("[Valorant] could not save splat texture")
			return
		end
	end
	splatAsset = loadAsset(SPLAT_FILE)
	if not splatAsset then warn("[Valorant] splat texture could not be loaded") end
end

---------------------------------------------------------------------
-- rules
---------------------------------------------------------------------
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local rules = HttpService:JSONDecode(CONFIG).replacement_rules
local lookup, meshCache = {}, {}
local registered, swapped = 0, 0

local function parseId(v)
	local s = tostring(v)
	if s:find("^rbxasset://") then return nil end -- our own cached files, never a real id
	return tonumber(s:match("(%d+)"))
end

local function resolve(rule)
	if rule.mode == "cdn" then
		return loadCdn(rule.cdn_url)
	end
	if rule.with_id then return "rbxassetid://" .. rule.with_id end
	return ""
end

local function flatten(list, out)
	for _, r in ipairs(list) do
		if r.type == "group" then
			flatten(r.children or {}, out)
		elseif r.enabled then
			out[#out + 1] = r
		end
	end
	return out
end

local active = flatten(rules, {})

local needSplat = false
for _, r in ipairs(active) do
	if r.splat then needSplat = true break end
end
if needSplat then prepareSplat() end

-- resolve every rule at the same time (downloads run in parallel)
local targets = {}
local pending = #active
for i, rule in ipairs(active) do
	task.spawn(function()
		local ok, res = pcall(resolve, rule)
		if ok then targets[i] = res end
		pending -= 1
	end)
end
while pending > 0 do task.wait() end

for i, rule in ipairs(active) do
	local target = targets[i]
	if target ~= nil then
		registered += 1
		local entry = {
			target = target,
			scale = tonumber(rule.scale) or 1,
			splat = rule.splat == true,
			joints = rule.scale_joints == true,
		}
		for _, id in ipairs(rule.replace_ids) do
			local n = parseId(id)
			if n then lookup[n] = entry end
		end
	end
end

print(("[Valorant] rules ready: %d | cached: %d | downloaded: %d | failed: %d"):format(
	registered, stats.cached, stats.downloaded, stats.failed))
for _, f in ipairs(failedList) do warn("[Valorant] FAILED: " .. f) end

---------------------------------------------------------------------
-- apply to the game
---------------------------------------------------------------------
local PROPS = {
	MeshPart = { "MeshId", "TextureID" },
	SpecialMesh = { "MeshId", "TextureId" },
	Sound = { "SoundId" },
	Decal = { "Texture" },
	Texture = { "Texture" },
	ImageLabel = { "Image" },
	ImageButton = { "Image" },
	SurfaceAppearance = { "ColorMap", "NormalMap", "MetalnessMap", "RoughnessMap" },
}
-- classes whose id changes at runtime (inventory icons, sounds reused by the game)
local WATCH_ALWAYS = { Sound = true, ImageLabel = true, ImageButton = true }

local seen = setmetatable({}, { __mode = "k" })
local watched = setmetatable({}, { __mode = "k" })
local baseSize = setmetatable({}, { __mode = "k" })
local baseScale = setmetatable({}, { __mode = "k" })
local jointDone = setmetatable({}, { __mode = "k" })

local function getProp(inst, p) return inst[p] end

local function hideMesh(inst)
	pcall(function()
		if inst:IsA("MeshPart") then
			inst.Transparency = 1
		elseif inst:IsA("SpecialMesh") then
			inst.Scale = Vector3.new(0, 0, 0)
		end
	end)
end

local function applyMesh(inst, asset)
	if not inst:IsA("MeshPart") then
		pcall(function() inst.MeshId = asset end)
		return
	end
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
		if not ok then warn("[Valorant] ApplyMesh failed: " .. tostring(err)) end
	end
end

-- paint the part with the splat texture and keep it that way
local function applySplat(inst)
	if not splatAsset then return end
	local isMesh = inst:IsA("MeshPart")
	local tprop = isMesh and "TextureID" or "TextureId"
	pcall(function() inst[tprop] = splatAsset end)
	pcall(function()
		if isMesh then
			inst.Color = Color3.new(1, 1, 1)
		else
			inst.VertexColor = Vector3.new(1, 1, 1)
		end
	end)
	for _, c in ipairs(inst:GetChildren()) do
		if c:IsA("SurfaceAppearance") then c:Destroy() end
	end
	if not watched[inst] then
		watched[inst] = true
		inst.ChildAdded:Connect(function(c)
			if c:IsA("SurfaceAppearance") then
				task.defer(function() pcall(function() c:Destroy() end) end)
			end
		end)
		pcall(function()
			inst:GetPropertyChangedSignal(tprop):Connect(function()
				if inst[tprop] ~= splatAsset then
					pcall(function() inst[tprop] = splatAsset end)
				end
			end)
		end)
	end
end

local function scaleCF(cf, k)
	return CFrame.new(cf.Position * k) * (cf - cf.Position)
end

-- scale the joints touching this part so connected pieces keep their spacing
local function scaleJoints(inst, k)
	local root = inst:FindFirstAncestorOfClass("Model") or inst.Parent
	if not root then return end
	local ok, descendants = pcall(function() return root:GetDescendants() end)
	if not ok then return end
	for _, j in ipairs(descendants) do
		if j:IsA("JointInstance") and not jointDone[j] and (j.Part0 == inst or j.Part1 == inst) then
			jointDone[j] = true
			pcall(function()
				j.C0 = scaleCF(j.C0, k)
				j.C1 = scaleCF(j.C1, k)
			end)
		end
	end
end

-- size is always base size x factor, so re-applying never stacks
local function rescale(inst, k, joints)
	task.wait(0.1)
	pcall(function()
		if inst:IsA("MeshPart") then
			local base = baseSize[inst]
			if not base then
				base = inst.Size
				baseSize[inst] = base
			end
			inst.Size = base * k
		elseif inst:IsA("SpecialMesh") then
			local base = baseScale[inst]
			if not base then
				base = inst.Scale
				baseScale[inst] = base
			end
			inst.Scale = base * k
		end
	end)
	if joints and SCALE_JOINTS then scaleJoints(inst, k) end
end

-- heavy part, only runs for instances that matched a rule (may yield)
local function process(inst, p, entry, id)
	local new = entry.target
	swapped += 1
	if swapped <= 15 then
		print("[Valorant] swapped " .. inst.ClassName .. "." .. p .. " (" .. tostring(id) .. ")")
	end

	if p == "MeshId" then
		if new == "" then
			hideMesh(inst)
		else
			applyMesh(inst, new)
			if entry.splat then applySplat(inst) end
			if entry.scale ~= 1 then rescale(inst, entry.scale, entry.joints) end
		end
	else
		pcall(function() inst[p] = new end)
	end
end

-- cheap check; returns true when the instance matched a rule
local function handle(inst, p)
	local ok, cur = pcall(getProp, inst, p)
	if not ok or cur == "" then return false end
	local id = parseId(cur)
	local entry = id and lookup[id]
	if not entry then return false end
	task.spawn(process, inst, p, entry, id)
	return true
end

local function apply(inst)
	local props = PROPS[inst.ClassName]
	if not props or seen[inst] then return end
	seen[inst] = true
	local always = WATCH_ALL or WATCH_ALWAYS[inst.ClassName]
	for i = 1, #props do
		local p = props[i]
		local matched = handle(inst, p)
		-- only listen for changes where it matters (matched parts, UI images, sounds)
		if matched or always then
			pcall(function()
				inst:GetPropertyChangedSignal(p):Connect(function()
					handle(inst, p)
				end)
			end)
		end
	end
end

local function scan()
	local n = 0
	for _, d in ipairs(game:GetDescendants()) do
		apply(d)
		n += 1
		if n % 1000 == 0 then task.wait() end
	end
end

game.DescendantAdded:Connect(apply)
task.spawn(scan)

if RESCAN_INTERVAL > 0 then
	task.spawn(function()
		while true do
			task.wait(RESCAN_INTERVAL)
			scan()
		end
	end)
end

print("[Valorant] loaded")
