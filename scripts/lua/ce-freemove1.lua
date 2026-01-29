cond_left = isKeyPressed( VK_NUMPAD4 );
cond_right = isKeyPressed( VK_NUMPAD6 );
cond_forward = isKeyPressed( VK_NUMPAD8 );
cond_backward = isKeyPressed( VK_NUMPAD2 );
cond_ascend = isKeyPressed( VK_NUMPAD7 );
cond_descend = isKeyPressed( VK_NUMPAD1 );

speed_f32 = readFloat( speed_address );
yaw_f32 = readFloat( yaw_address );
function Overflow( input, min, max )
	_return = 0.0;
	if( input < min ) then
		_return = max - ( ( min - input ) % ( max - min ) );
	elseif( input > max ) then
		_return = min + ( ( input - max ) % ( max - min ) );
	else
		_return = input;
	end
	return _return;
end
--print( 'speed: ', speed_f32, 'yaw: ', yaw_f32 );
if( (cond_left == true) or (cond_right == true) or (cond_forward == true) or (cond_backward == true) ) then
	direction_f32 = 0.0;
	skip_horizontal = 0;
    if( cond_left == true ) then
		if( cond_forward == true ) then
			direction_f32 = math.pi / 4;
		elseif( cond_backward == true ) then
			direction_f32 = math.pi * (3 / 4);
		else
			direction_f32 = math.pi / 2;
		end
    elseif( cond_right == true ) then
		if( cond_forward == true ) then
			direction_f32 = -math.pi / 4;
		elseif( cond_backward == true ) then
			direction_f32 = -math.pi * (3 / 4);
		else
			direction_f32 = -math.pi / 2;
		end
    else
		if( cond_forward == true ) then
			direction_f32 = 0.0;
		elseif( cond_backward == true ) then
			direction_f32 = math.pi;
		else
			skip_horizontal = 1;
		end
    end
	adjusted_f32 = yaw_f32 + direction_f32;
	if( math.abs(adjusted_f32) > math.pi ) then
		adjusted_f32 = Overflow( adjusted_f32, -math.pi, math.pi );
	end
    x_vel_f32 = -1 * speed_f32 * math.sin(adjusted_f32);
    z_vel_f32 = speed_f32 * math.cos(adjusted_f32);
    if( x_vel_f32 ~= 0.0 ) then
    	--print( 'vel.x: ', x_vel_f32 );
    	x_f32 = previous_x_f32 + x_vel_f32;
    end
    if( z_vel_f32 ~= 0.0 ) then
    	--print( 'vel.z: ', z_vel_f32 );
    	z_f32 = previous_z_f32 + z_vel_f32;
    end
end
if( (cond_ascend == true) or (cond_descend == true) ) then
    if( cond_ascend == true ) then
   		y_f32 = previous_y_f32 + speed_f32;
   	elseif( cond_descend == true ) then
   		y_f32 = previous_y_f32 - speed_f32;
    end
else
	y_f32 = previous_y_f32;
end
writeFloat( x_address, x_f32 );
previous_x_f32 = x_f32;
writeFloat( y_address, y_f32 );
previous_y_f32 = y_f32;
writeFloat( z_address, z_f32 );
previous_z_f32 = z_f32;
