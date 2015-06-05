require "mysql"

function print_r ( t ) 
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t,"  ")
end

local db, err = mysql.connect('localhost', 'root', '12345qwert')
--print(db)
--print(err)
db:select_db('art')
db:set_charset("utf-8")

local rc = db:exec("DELETE FROM `ssc_user_bankcard` WHERE BankId = '15813';")
--print(db:insert_id())
print(db:affected_rows())

local data, rc = db:fetch_one("SELECT * FROM `agency_reports` LIMIT 1")
if not data then
  print(db:error())
else
  print_r(data)
end
print_r(rc)  

print("\r\n\r\n")
local data, rc = db:fetch_all("SELECT * FROM `agency_reports` LIMIT 3")
if not data then
  print(db:error())
else
  print_r(data)
end
print_r(rc)  
db:close()

