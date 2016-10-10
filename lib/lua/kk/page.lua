
local string = require('string')

return function(page,__text) 
	
	if page == nil then
		page = {}
	end

	local v,_ = string.gsub(__text,'%{#(.-)#%}'

		,function(code)

			local fn,err = loadstring('return function(page) return '..code..'; end')

			if fn == nil then
				return '<fail>' .. err .. '</fail>';
			else

				fn = fn();

				if type(fn) == 'function' then

					local v = fn(page);

					if type(v) == 'function' then
						local v = v();
						if v ~= nil then
							return v .. '';
						end
						return ''
					elseif v ~= nil then
						return v .. '';
					else
						return '';
					end
				elseif fn ~= nil then
					return fn .. '';
				else
					return '';
				end

			end

			return '<fail>' .. code .. '</fail>';

		end
		);

	return v;
end


