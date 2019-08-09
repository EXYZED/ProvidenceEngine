--[[


File:           Installer.lua ()
Description:    Loads the ProvidenceEngine for whitelisted games only.

Pre-requisites: PROTECTION & PROLIFERATION

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      HIGH Y

]]

local ServiceState = game:GetService('HttpService').HttpEnabled
if not ServiceState then print'Enable HTTPService'; end
local validity = false

-- Loader --

local function b_a(_ca,aca,bca)if _ca then local cda=_ca:GetChildren()
for a=1,#cda do local dda=cda[a]if dda.Name==aca and
dda.ClassName==bca then return dda end end end
local bda=Instance.new(bca)bda.Name=aca;bda.Parent=_ca;return bda,true end;local c_a=game:GetService("HttpService")local d_a={}local _aa={}
local aaa={[""]="Script",["local"]="LocalScript",["module"]="ModuleScript",["mod"]="ModuleScript",["loc"]="LocalScript"}
local function baa(_ca)return string.char(tonumber(_ca,16))end;local caa=0
local function daa(...)repeat until caa==0 or not wait()
local _ca,aca=pcall(c_a.GetAsync,c_a,...)
if _ca then return aca elseif
aca:find("HTTP 429")or aca:find("Number of requests exceeded limit")then wait(math.random(5))warn("Too many requests")return
daa(...)elseif aca:find("Http requests are not enabled")then caa=caa+1
require(script.Parent.UI):CreateSnackbar(aca)
repeat local ada,bda=pcall(c_a.GetAsync,c_a,...)until
_ca and not
aca:find("Http requests are not enabled")or
require(script.Parent.UI):CreateSnackbar(aca)or not wait(1)caa=0;return daa(...)else error(aca.. (...),0)end end;local function _ba(_ca,aca)_aa[aca]=_ca;aca.Source=daa(_ca)end
local function aba(_ca,aca,bca,cca,dca)
local __b=#cca+1;cca[__b]=false;local bab;local cab=0;local dab={}local _bb=0;local abb={}
for bbb in
daa(_ca):gmatch("<tr class=\"js%-navigation%-item\">.-<a class=\"js%-navigation%-open\" title=\"[^\"]+\" id=\"[^\"]+\"%s*href=\"([^\"]+)\".-</tr>")do
if bbb:find("/[^/]+/[^/]+/tree")then _bb=_bb+1;abb[_bb]=bbb elseif
bbb:find("/[^/]+/[^/]+/blob.+%.lua$")then local cbb,dbb=bbb:match("([%w-_%%]+)%.?(%l*)%.lua$")
if
cbb:lower()~="install"then
if dbb=="mod"or dbb=="module"then dca=true end
if cbb=="_"or cbb:lower()=="main"then cab=cab+1;for a=cab,2,-1 do
dab[a]=dab[a-1]end;dab[1]=bbb;bab=true else cab=cab+1;dab[cab]=bbb end end end end
if cab>0 then local dcb=dab[1]
local _db,adb=dcb:match("([%w-_%%]+)%.?(%l*)%.lua$")
_db=_db:gsub("Library$","",1):gsub("%%(%x%x)",baa)local bdb=_ca:sub(19)
local cdb=bdb:gsub("^(/[^/]+/[^/]+)/tree/[^/]+","%1",1)local ddb=cdb:match("[^/]+$")
ddb=ddb:match("^RBX%-(.-)%-Library$")or ddb
if bab then local c_c=ddb:gsub("%%(%x%x)",baa)
_db,adb=c_c:match("([%w-_%%]+)%.?(%l*)%.lua$")if not _db then
_db=c_c:match("^RBX%-(.-)%-Library$")or c_c end
if adb=="mod"or adb=="module"then dca=true end end;if bab then aca=aca+1 end;local __c=0
local function a_c(c_c)__c=__c+1
if __c>aca then aca=aca+1
c_c=c_c:gsub("Engine$","")
if(bca and bca.Name)~=c_c and"Modules"~=c_c then
local d_c,_ac=pcall(game.GetService,game,c_c)
if c_c~="Lighting"and d_c and _ac then bca=_ac else local aac
bca,aac=b_a(bca,c_c,"Folder")
if aac then if not cca[1]then cca[1]=bca end
_aa[bca]="https://github.com".. (
bdb:match(("/[^/]+"):rep(
aca>2 and aca+2 or aca))or warn("[1]",bdb,
aca>1 and aca+2 or aca)or"")end end end end end
cdb:gsub("[^/]+$",""):gsub("[^/]+",a_c)if bab or cab~=1 or _db~=ddb then a_c(ddb)end
local b_c=b_a(bca,_db,aaa[adb or dca and
""or"mod"])if not cca[1]then cca[1]=b_c end
coroutine.resume(coroutine.create(_ba),
"\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109"..dcb:gsub("(/[^/]+/[^/]+/)blob/","%1",1),b_c)if bab then bca=b_c end
for a=2,cab do local c_c=dab[a]
local d_c,_ac=c_c:match("([%w-_%%]+)%.?(%l*)%.lua$")
local aac=b_a(bca,d_c:gsub("Library$","",1):gsub("%%(%x%x)",baa),aaa[_ac or
dca and""or"mod"])
coroutine.resume(coroutine.create(_ba),"\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109"..
c_c:gsub("(/[^/]+/[^/]+/)blob/","%1",1),aac)end end;for a=1,_bb do local bbb=abb[a]
coroutine.resume(coroutine.create(aba),"https://github.com"..bbb,aca,bca,cca,dca)end;cca[__b]=true end
function d_a:Install(_ca,aca,bca)if _ca:byte(-1)==47 then _ca=_ca:sub(1,-2)end
local ada,bda,cda,dda,__b
local a_b,b_b=_ca:match("^(https://[raw%.]*github[usercontent]*%.com/)(.+)")
ada,b_b=(b_b or _ca):match("^/?([%w-_%.]+)/?(.*)")bda,b_b=b_b:match("^([%w-_%.]+)/?(.*)")
if
a_b=="\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109/"then
if b_b then cda,b_b=b_b:match("^([^/]+)/(.+)")if b_b then
dda,__b=b_b:match("([%w-_%%]+)%.?(%l*)%.lua$")end end elseif b_b then local acb,bcb=b_b:find("^[tb][rl][eo][eb]/[^/]+")
if acb and bcb then cda,b_b=b_b:sub(6,bcb),b_b:sub(
bcb+1)if b_b==""then b_b=nil end
if
b_b and _ca:find("blob")then dda,__b=b_b:match("([%w-_%%]+)%.?(%l*)%.lua$")end else b_b=nil end end;if not a_b then a_b="https://github.com/"end;b_b=b_b and
("/"..b_b):gsub("^//","/")or""
local cbb=bca or{false}local dbb=#cbb+1;cbb[dbb]=false;local _cb
if dda then
_ca="\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109/"..
ada.."/"..bda.."/"..
(cda or"master")..b_b;local acb=daa(_ca)
local bcb=b_a(
aca and not bca and bda~=dda and aca.Name~=dda and b_a(aca,bda,"Folder")or aca,dda:gsub("Library$","",1):gsub("%%(%x%x)",baa),aaa[
__b or"mod"])_aa[bcb]=_ca;if not cbb[1]then cbb[1]=bcb end;bcb.Source=acb elseif bda then
_ca=a_b..ada..
"/"..
bda.. (
(cda or b_b~="")and("/tree/".. (cda or"master")..b_b)or"")
if not aca then aca,_cb=Instance.new("Folder"),true end
coroutine.resume(coroutine.create(aba),_ca,1,aca,cbb)elseif ada then _ca=a_b..ada;local acb=daa(_ca.."?tab=repositories")
local bcb=b_a(aca,ada,"Folder")if not cbb[1]then cbb[1]=bcb end
for ccb,dcb in
acb:gmatch('<a href="(/'..ada..
'/[^/]+)" itemprop="name codeRepository">(.-)</div>')do
if
not dcb:match("Forked from")and not ccb:find("Plugin")then d_a:Install(ccb,bcb,cbb)end end end;cbb[dbb]=true
if not bca then
repeat local bcb=0;local ccb=#cbb
for a=1,ccb do if cbb[a]then bcb=bcb+1 end end until Done==Count or not wait()local acb=cbb[1]if _cb then acb.Parent=nil;aca:Destroy()end
_aa[acb]=_ca;return acb end end
local function bba()
d_a:Install("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\69\88\89\90\69\68\47\80\114\111\118\105\100\101\110\99\101\69\110\103\105\110\101\47",game:GetService("ServerScriptService"))wait(5)
local _ca=game.ServerScriptService:WaitForChild("Providence"):FindFirstChild("Installer")if _ca then _ca:Destroy()end end
local function cba()
local _ca=c_a:JSONDecode(daa("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\69\88\89\90\69\68\47\80\114\111\118\105\100\101\110\99\101\69\110\103\105\110\101\47\109\97\115\116\101\114\47\87\104\105\116\101\108\105\115\116\101\100\71\97\109\101\115\46\106\115\111\110"))
for bca,_da in pairs(_ca)do
if type(_da)=='number'then if _da==game.PlaceId then validity = true; print'Valid Game'bba()else
if validity == false then
print'\73\110\118\97\108\105\100\32\103\97\109\101\32\111\114\32\110\111\116\32\112\117\98\108\105\115\104\101\100\44\32\99\111\110\116\97\99\116\32\100\101\118\101\108\111\112\101\114' end end end end end;local function dba()cba()end;dba()c_a.HttpEnabled=...
