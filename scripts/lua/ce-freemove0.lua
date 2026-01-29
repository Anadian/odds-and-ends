--print('LuaCode1');
if( isKeyPressed( VK_NUMPAD5 ) == true ) then
	--print('NUMPAD 5 pressed.');
	enabled_address = getAddressSafe( 'FreeMoveEnabledLabel' );
    --print( 'enabled_address:', enabled_address );
    byte_value = readByte( enabled_address, 1, false );
    if( byte_value ~= 0 ) then
    	byte_value = 0;
    else
       	byte_value = 1;
        address_list = getAddressList();
        speed_address = getAddressSafe( 'FreeMoveSpeedLabel' );
        x_memrec = address_list.getMemoryRecordByDescription( 'PosX' );
   		x_address = x_memrec.getCurrentAddress();
        x_f32 = readFloat( x_address );
        previous_x_f32 = x_f32;
        y_memrec = address_list.getMemoryRecordByDescription( 'PosY' );
   		y_address = y_memrec.getCurrentAddress();
        y_f32 = readFloat( y_address );
        previous_y_f32 = y_f32;
        z_memrec = address_list.getMemoryRecordByDescription( 'PosZ' );
        z_address = z_memrec.getCurrentAddress();
    	z_f32 = readFloat( z_address );
        previous_z_f32 = z_f32;
        yaw_memrec = address_list.getMemoryRecordByDescription( 'FirstPersonYaw (rad AntiCW from North)' );
        yaw_address = yaw_memrec.getCurrentAddress();
	end
    writeBytes( enabled_address, byte_value );
end
