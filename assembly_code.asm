asect 0xF0
	RightBatY: ds 1
	BallX: ds 1
	BallY: ds 1
	VX: ds 1
	VY:	ds 1	

asect 0x00
setsp 0xe0

BotMovement:

# Standard formula: d=y+(240-x)/(vx * vy)-255
# Result=255-d

	ldi r1, BallX			
	ld r1, r1	
			
	ldi r3, VX
	ld r3, r3
		
	#if ball on the right side, we don't count anything
	if
		tst r3
	is eq, or
		tst r1
	is eq
	then
		br 0x2b
	fi
	
	#(240 - x)
	ldi r0, 240
	sub r0, r1
		
	tst r1
	
	shra r1
	
	ldi r3, VY	
	ld r3, r3
	
	#vy = zero? Make it 1
	if
		tst r3
	is eq
		inc r1
	fi
	
	ldi r2, BallY
	ld r2, r2	
	
	if 
		add r2, r1
	is cs
		ldi r2, 255
		sub r1, r2
	fi
	
	ldi r3, 255
	sub r3, r2
	
	ldi r0, RightBatY
	st r0, r2
	
	br BotMovement

	rts

halt
end
