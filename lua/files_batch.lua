require 'image'
require 'lfs'

local sourcePath = './data/data_source/lip/'
local savePath = './data/data_source/lip_res/'

local input_table = {}
local file_table = {}
for file in lfs.dir(sourcePath) do  
	if file ~= "." and file ~= ".." then  
        local file_Path = sourcePath..'/'..file  
        table.insert(file_table, file)
	table.insert(input_table, file_Path)  
	end  
end 

i = 1
while input_table[i] ~= nil do
    local file_Path = input_table[i]
    local file_name = file_table[i]
    print('Loading input: ' .. file_Path)
    -- Do on the file here
    print('Saving output: ' .. savePath ..file_name..'.mat')
    i = i+1
end

print('Done')
