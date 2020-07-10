# Mrinank Sivakumar (100748771), Farhan Irani (100748418), Ayi Pranayanda (100765502) -- mm/dd/yy
# FinalProject.asm -- [File desc.]
.data
	utilityPrompt: .asciiz "'a' [BMI calculator]\n'b' [Farenheit to Celsius converter]\n'c' [Pounds to Kilograms converter]\n'd' [Fibonacci calculator\n-> "
	weightPrompt: .asciiz "\n\nEnter weight (kg): "
	heightPrompt: .asciiz "Enter height (cm): "
	float1: .float 100.00
	float2: .float 10.00
	BMIOutput: .asciiz "Your BMI is "
	exitPrompt: .asciiz "\nWould you like to exit the program?"
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
		.macro input_str (%var, %x) # Gets atring input    ############################################
		li $v0, 8					    #
		la $a0, %var					    # Not sure about this one
		li $a1, %x					    # Will need to be tested
		syscall						    #
		.end_macro					    ############################################
		.macro input_char # Gets character input ; stored in $v0
		li $v0, 12
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
				##########################################################################
				# [Farenheit to Celsius Converter]
				j end
			U3:
				##########################################################################
				# Registers used:
				##########################################################################
				# [Pounds to Kilograms Converter]
				j end
			U4:
				##########################################################################
				# Registers used:
				##########################################################################
				# [Fibonacci Calculator]
				j end
			else:
				j loop
		end:
	exit
