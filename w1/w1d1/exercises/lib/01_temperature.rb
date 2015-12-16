def ftoc(faranheit)
	(((faranheit - 32)/9)*5)
end

def ctof(celsius)
	(((celsius.to_f/5).to_f*9).to_f+32)
end
