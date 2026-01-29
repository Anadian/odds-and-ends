if( printf == nil) then
	function printf( format_string, ... )
		print( string.format( format_string, ... ) );
	end
end

SlotTable = {};
function SlotTable:new( slots_array )
    local this = {
		slots = ( slots_array or {0,0,0,0,0} ),
		noop = true,
		baseLabel = 'I1EffectiveAddressLabel',
		bufferValue = 0451,
		maxSlots = 5
	};
    setmetatable( this, {
		__index = SlotTable,
		__newindex = function( this, slot, value )
			printf( 'Attempting set slot %d to %d', slot, value );
			this.slots[slot] = value;
		end,
		__tostring = function( this )
			_return = '[ ';
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
	if( self.noop == true ) then
		for i in ipairs( self.slots ) do
			printf( 'read %d/%d: %d => x', i, #self.slots, self.slots[i] );
		end
	else
		for i = 1,5,1 do
			self.slots[i] = self:getU64FromOffsetIndex( i );
			--printf( 'read: For %d/%d: Got %d possibly replacing %d', i, #self.slots, temp_pointer, self.slots[i] );
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
			address = self:getAddressFromOffsetIndex( i );
			printf( 'write: For %d/%d: Writing %d to %d', i, #self.slots, value, temp_address );
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
	_return = 0;
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
		empty_slot = self:getEmpty();
		self.slots[empty_slot] = value;
	end
end

function SlotTable:getAddressFromOffsetIndex( index )
	_return = nil;
	if( self.noop ~= true and index >= 0 and index < self.maxSlots ) then
		address_string = self.baseLabel;
		if( index > 0 ) then
			offset = string.format( '+%02x', i * 8 );
			address_string = address_string..offset;
		end
		_return = getAddressSafe( address_string );
	end
	return _return;
end

function SlotTable:getU64FromOffsetIndex( index )
	printf( 'getU64FromOffsetIndex received %d', index );
	_return = 0;
	address = self:getAddressFromOffsetIndex( index );
	if( self.noop ~= true and address ~= nil ) then
		temp_pointer = readQword( address );
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

slot_table = SlotTable:new();
slot_table[1] = 1;
print( 'slot_table:exists( 1 ) = ', slot_table:exists( 1 ) );
st2 = SlotTable:new( { 1, 2, 3, 4, 5 } );
print( 'st2.exists( 5 ) = ', st2:exists( 5 ) );
st = SlotTable:new();
printf( 'st = %s', st );
--index = st:exists( buffer_pointer );
--printf( 'index = %d', index );
st:add( 6 );
st:add( 7 );
print( st );

--[[function GetPointerArray()
	print('GetPointerArray');
	_return = { 0, 0, 0, 0, 0 };
    print( '_return length: ', #_return );
    for i = 1,5,1 do
    	--print('i: ', i);
    	offset = string.format( '%02x', i * 8 );
        --print('offset: ', offset);
        address_string = 'I1EffectiveAddressLabel+'..offset;
        --print('address_string: ', address_string);
    	temp_address = getAddressSafe( address_string );
        --print('temp_address: ', temp_address);
       	temp_pointer = readQword( test_address );
        --print('temp_pointer: ', temp_pointer);
		if( temp_pointer == nil ) then
        	temp_pointer = 0;
        elseif( temp_pointer > 0 ) then
        	_return[i] = temp_pointer;
        else
        	_return[i] = 0;
        end
        --print('_return[i]: ', _return[i]);
        printf( 'Get %d (%s=%d): %d => %d (#%d)', i, address_string, temp_address, temp_pointer, _return[i], #_return);
    end
    return _return;
end
function SetPointerArray( pointer_array )
	printf('SetPointerArray received array#%d', #pointer_array );
    for i,value in ipairs(pointer_array) do
    	offset = string.format( '%02x', i * 8 );
        address_string = 'I1EffectiveAddressLabel+'..offset;
    	temp_address = getAddressSafe( address_string );
        printf( 'Set %d=%d => %d', i, value, temp_address );
        writeQword( test_address, value );
    end
end
--	slot_address = getAddressSafe( 'I1CurrentPartySlotLabel' );
--    current_slot = readByte( slot_address, 1, false );
--if( current_slot < 5 ) then
	print('In luacode.');
    buffer_address = getAddressSafe( 'I1EffectiveAddressLabel' );
    --print('buffer_address: ', buffer_address);
    buffer_pointer = readPointer( buffer_address );
    --print('buffer_pointer: ', buffer_pointer);
    slot_pointer_array = GetPointerArray();
    exists = 0;
    printf( 'buffer=%d @ %d array#%d exists=%d', buffer_pointer, buffer_address, #slot_pointer_array, exists );
    for i = 1,#slot_pointer_array,1 do
    	printf('DoesExist? %d/%d: %d == %d ', i, #slot_pointer_array, slot_pointer_array[i], buffer_pointer );
    	if( slot_pointer_array[i] == buffer_pointer ) then
        	exists = i;
            i = #slot_pointer_array + 1;
            printf( 'Did exists; escaping... %d %d/%d', exists, i, #slot_pointer_array );
        end
    end
    if( exists == 0 ) then
    	for i = 1,#slot_pointer_array,1 do --CanSet
			printf( 'CanSet %d/%d: %d => %d', i, #slot_pointer_array, buffer_pointer, slot_pointer_array[i] );
            if( slot_pointer_array[i] == 0 ) then
            	slot_pointer_array[i] = buffer_pointer;
                print( 'post-assignment slot_pointer_array[i]=', slot_pointer_array[i] );
                SetPointerArray( slot_pointer_array );
                i = #slot_pointer_array + 1;
                printf( 'Did set? %d/%d', i, #slot_pointer_array );
        	end
    	end
    end
--end
]]
