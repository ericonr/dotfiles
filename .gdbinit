# funcoes para facilitar o uso do arm-none-eabi-gdb

# sequencia inicial
def rst
	monitor reset halt
	tb main
	continue
end

# essa eh necessaria com a STM32F4 para programar
def mrh
	monitor reset halt
end

# para conectar ao microcontrolador
def loco
	target remote localhost:3333
end

def semihosting
	monitor arm semihosting enable
end
