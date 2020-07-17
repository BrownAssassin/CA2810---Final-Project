# Mrinank Sivakumar (100748771), Farhan Irani (100748418), Ayi Pranayanda (100765502) -- 07/06/20
# FinalProject.asm -- A MIPS assembly code project that contains multiple utilities (BMI Calculator,
#			Farenheit to Celsius Converter, Pounds to Kilograms Converter,
#			and Fibonacci Sequence Calculator) and will allow the user to choose which
#			utility they want to use.
#			+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#			NOTE: This program uses Syscall services beyond 30 (which are not offered by
#			SPIM) and as such is only compatible with MARS
#			+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Registers used - {Independant lists for each util.}
.data
	utilityPrompt: .asciiz "'a' [BMI calculator]\n'b' [Farenheit to Celsius converter]\n'c' [Pounds to Kilograms converter]\n'd' [Fibonacci calculator\n-> "
	weightPrompt: .asciiz "\n\nEnter weight (kg): "
	weight2Prompt: .asciiz "\nEnter weight (lb): "
	heightPrompt: .asciiz "Enter height (cm): "
	float1: .float 100.00
	float2: .float 10.00
	float3: .float 32.0
	float4: .float 1.8
	float5: .float 2.2046
	BMIOutput: .asciiz "Your BMI is "
	exitPrompt: .asciiz "\nWould you like to exit the program?"
	tempPrompt: .asciiz "\nEnter temperature in Fahrenheit: "
	tempOutput: .asciiz "\nTemperature in Celsius: "
	kgOutput: .asciiz "\nYour weight (kg): "
	fibPrompt: .asciiz "\nEnter a number (n) greater than 1: "
	fibOutput: .asciiz "\nThe corresponding fibonacci number is: "
	
.text
	main:
		# Macros
		.macro exit # Exits the program
		li $v0, 10
		syscall
		.end_macro
		.macro print_int (%int) # Prints an integer
		li $v0, 1
		add $a0, $zero, %int
		syscall
		.end_macro
		.macro print_float (%flt) # Prints a float
		li $v0, 2
		mov.s $f12, %flt
		syscall
		.end_macro
		.macro print_double (%dbl) # Prints a double
		li $v0, 3
		add $f12, $zero, %dbl
		syscall
		.end_macro
		.macro print_str (%str) # Prints a string
		li $v0, 4
		la $a0, %str
		syscall
		.end_macro
		.macro print_char (%char) # Prints a character
		li $v0, 11
		add $a0, $zero, %char
		syscall
		.end_macro
		.macro input_int # Gets integer input ; stored in $v0
		li $v0, 5
		syscall
		.end_macro
		.macro input_float # Gets float input ; stored in $f0
		li $v0, 6
		syscall
		.end_macro
		.macro input_double # Gets double input ; stored in $f0
		li $v0, 7
		syscall
		.end_macro
		.macro input_str (%var, %x) # Gets string input ; stored in var
		li $v0, 8
		la $a0, %var
		li $a1, %x
		syscall
		.end_macro
		.macro input_char # Gets character input ; stored in $v0
		li $v0, 12
		syscall
		.end_macro
		.macro cnfmDialog (%msg) # Dialog Box used to get confirmation from user ; stored in $a0
		li $v0, 50
		la $a0, %msg
		syscall
		.end_macro
		.macro inDialogInt (%msg) # Dialog Box used to get int value from user ; stored in $a0
		li $v0, 51
		la $a0, %msg
		syscall
		.end_macro
		.macro inDialogFloat (%msg) # Dialog Box used to get float value from user ; stored in $f0
		li $v0, 52
		la $a0, %msg
		syscall
		.end_macro
		.macro inDialogStr (%msg, %var, %size) # Dialog Box used to get string/character value from user ; stored in %var
		li $v0, 54
		la $a0, %msg
		la $a1, %var
		li $a2, %size
		syscall
		.end_macro
		.macro MsgDialog (%msg, %typ) # Dialog Box used to display a message
		li $v0, 55
		la $a0, %msg
		li $a1, %typ
		syscall
		.end_macro
		
		loop:
			print_str (utilityPrompt)
			input_char
			beq $v0, 'a', U1
			beq $v0, 'b', U2
			beq $v0, 'c', U3
			beq $v0, 'd', U4
			j else
			
			U1:
				##########################################################################
				# Registers used:
				#	f4	- used to hold weight
				#		-- used to hold BMI
				#	f6	- used to hold height
				#	f8	- used to hold float1
				#	f10	- used to hold float2
				##########################################################################
				print_str (weightPrompt)
				input_float
				mov.s $f4, $f0
				print_str (heightPrompt)
				input_float
				mov.s $f6, $f0
				l.s $f8, float1
				l.s $f10, float2
				div.s $f6, $f6, $f8
				mul.s $f6, $f6, $f6
				div.s $f4, $f4, $f6
				mul.s $f4, $f4, $f10
				round.w.s $f0, $f4
				cvt.s.w $f4, $f0
				div.s $f4, $f4, $f10
				print_str (BMIOutput)
				print_float ($f4)
				j end
		
			U2:
				##########################################################################
				# Registers used:
				#	f4	- used to hold temperature
				#	f6	- used to hold float2 - 10
				#	f8	- used to hold float3 - 32
				#	f10	- used to hold float4 - 1.8
				##########################################################################
				# [Farenheit to Celsius Converter]
				print_str (tempPrompt)
				input_float
				mov.s $f4, $f0
				l.s $f6, float2
				l.s $f8, float3
				l.s $f10, float4
				sub.s $f4, $f4, $f8
				div.s $f4, $f4, $f10
				mul.s $f4, $f4, $f6
				round.w.s $f0, $f4
				cvt.s.w $f4, $f0
				div.s $f4, $f4, $f6
				print_str (tempOutput)
				print_float ($f4)
				j end
			U3:
				##########################################################################
				# Registers used:
				#	f4	- used to hold weight
				#	f6	- used to hold float5 - 2.2046
				#	f8	- used to hold float2
				##########################################################################
				# [Pounds to Kilograms Converter]
				print_str (weight2Prompt)
				input_float
				mov.s $f4, $f0
				l.s $f6, float5
				l.s $f8, float2
				div.s $f4, $f4, $f6
				mul.s $f4, $f4, $f8
				round.w.s $f0, $f4
				cvt.s.w $f4, $f0
				div.s $f4, $f4, $f8
				print_str (kgOutput)
				print_float ($f4)
				j end
			U4:
				##########################################################################
				# Registers used:
				#	t0	- used to hold subscript n
				#	t1	- used to hold user input n 
				#	t2	- used to hold Fn - 1
				#	t3	- used to hold Fn - 2
				#	t4	- used to hold fibonacci number (Fn)
				##########################################################################
				# [Fibonacci Calculator]
				print_str (fibPrompt)
				input_int
				move $t1, $v0
				li $t0, 2
				li $t2, 1
				li $t3, 0
				
				fibLoop:
					bgt $t0, $t1, endFib
					add $t4, $t2, $t3 # t4 = Fn-1 + Fn-2
					move $t3, $t2 # t3 = Fn-2
					move $t2, $t4 # t2 = Fn
					addi $t0, $t0, 1			
				j fibLoop
				
				endFib:
					print_str (fibOutput)
					print_int ($t4)
				j end
					
			else:
				j loop
		end:
	exit
