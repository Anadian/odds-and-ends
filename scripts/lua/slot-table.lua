#!/usr/bin/env lua

SlotTable = {};
function SlotTable:new( slots_array )
	print( 'Creating new SlotTable.' );
	local this = {
		slots = ( slots_array or {0,0,0,0,0} ),
		noop = false,
		baseLabel = 'I1EffectiveAddressLabel',
		bufferValue = 0451,
		maxSlots = 5
	};
	printf( 'Have this: baseLabel=%s bufferValue=%d maxSlots=%d', this.baseLabel, this.bufferValue, this.maxSlots );
	setmetatable( this, {
		__index = SlotTable,
		__newindex = function( this, slot, value )
			printf( 'Attempting set slot %d to %d', slot, value );
			this.slots[slot] = value;
		end,
		__tostring = function( this )
			local _return = '[ ';
			for i,v in ipairs( this.slots ) do
				_return = _return .. v;
				if( i < 5 ) then
					_return = _return .. ', ';
				else
					_return = _return .. ' ]';
				end
			end
			return _return;
		end
	} );
	print( 'Set metatable for this.' );
	this:read();
	--this:write();
	return this;
end

function SlotTable:exists( value )
	local _return = 0;
	for i in ipairs( self.slots ) do
		printf( 'Checking %d/%d: %d == %d ?', i, #self.slots, self.slots[i], value );
		if( self.slots[i] == value ) then
			_return = i;
			printf( 'Found match (%d) should break.', _return );
			break;
		end
	end
	return _return;
end

function SlotTable:read()
	print( 'SlotTable:read' );
	if( self.noop == true ) then
		for i in ipairs( self.slots ) do
			printf( 'read %d/%d: %d => x', i, #self.slots, self.slots[i] );
		end
	else
		for i in ipairs( self.slots ) do
			printf( 'read %d/%d', i, #self.slots );
			self.slots[i] = self:getU64FromOffsetIndex( i );
		end
	end
end

function SlotTable:write()
	if( self.noop == true ) then
		for i in ipairs( self.slots ) do
			printf( 'write %d/%d: writing %d to address', i, #self.slots, self.slots[i] );
		end
	else
		for i,value in ipairs( self.slots ) do
			local address = self:getAddressFromOffsetIndex( i );
			printf( 'write: For %d/%d: Writing %d to %d', i, #self.slots, value, address );
			writeQword( address, value );
		end
	end
end

function SlotTable:clear()
	for i in ipairs( self.slots ) do
		self.slots[i] = 0;
	end
end

function SlotTable:getEmpty()
	local _return = 0;
	for i in ipairs( self.slots ) do
		if( self.slots[i] == 0 ) then
			_return = i;
			break;
		end
	end
	if( _return == 0 ) then
		self:clear();
		_return = 1;
	end
	return _return;
end

function SlotTable:add( value )
	if( self:exists( value ) == 0 ) then
		local empty_slot = self:getEmpty();
		self.slots[empty_slot] = value;
	end
end

function SlotTable:getAddressFromOffsetIndex( index )
	printf( 'getAddressFromOffsetIndex received %d', index );
	local _return = nil;
	if( self.noop ~= true and index >= 0 and index <= self.maxSlots ) then
		print( 'Checks passed.' );
		local address_string = self.baseLabel;
		print( 'address_string: ', address_string );
		if( index > 0 ) then
			local offset = string.format( '+%02x', index * 8 );
			print( 'offset: ', offset );
			address_string = address_string..offset;
			print( 'address_string: ', address_string );
		end
		_return = getAddressSafe( address_string );
	end
	printf( 'getAddressFromOffsetIndex returned %d', _return );
	return _return;
end

function SlotTable:getU64FromOffsetIndex( index )
	printf( 'getU64FromOffsetIndex received %d', index );
	local _return = 0;
	local address = self:getAddressFromOffsetIndex( index );
	if( self.noop ~= true and address ~= nil ) then
		local temp_pointer = readQword( address );
		if( temp_pointer ~= nil ) then
			_return = temp_pointer;
			printf( 'Got %d from %d', _return, address );
		end
	end
	printf( 'getU64FromOffsetIndex returned %d', _return );
	return _return;
end

function SlotTable:getBufferValue()
	self.bufferValue = self:getU64FromOffsetIndex( 0 );
	return self.bufferValue;
end

--[[st = SlotTable:new();
local buffer_value = st:getBufferValue();
st:add( buffer_value );
print( 'st: ', tostring(st) );
st:write();]]
