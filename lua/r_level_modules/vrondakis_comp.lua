local meta = FindMetaTable("Player")

function meta:addLevels(lvl)
	self:AddLevel(lvl)
end

function meta:SetXP(exp)
	self:SetExp(exp)
end

function meta:AddXP(exp)
	self:AddExp(exp)
end

function meta:getXP()
	return self:GetExp()
end

function meta:getMaxXP()
	return self:GetNeedExp()
end
