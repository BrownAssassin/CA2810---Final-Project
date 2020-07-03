# Mrinank Sivakumar (100748771), Farhan Irani (100748418), Ayi Pranayanda (100765502) -- mm/dd/yy
# FinalProject.asm -- [File desc.]
.data
	utilityPrompt: .asciiz "'a' [BMI calculator]\n'b' [Farenheit to Celsius converter]\n'c' [Pounds to Kilograms converter]\n'd' [Fibonacci calculator\n-> "
.text
	main:
		# Macros
		
		
		loop:
			li $v0, 4
			la $a0, utilityPrompt
			syscall
			li $v0, 12
			syscall
			beq $v0, 'a', U1
			beq $v0, 'b', U2
			beq $v0, 'c', U3
			beq $v0, 'd', U4
			j else
			U1:
				##########################################################################
				# Registers used:
				##########################################################################
				# [BMI Calculator]
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
	li $v0, 10
	syscall