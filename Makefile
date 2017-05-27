TOOLCHAIN=GCC_ARM
MCU=NUCLEO_F401RE
VOLUME_PATH=/run/media/delta/NUCLEO
PROJECT_NAME=mbed_template
BIN=./BUILD/$(MCU)/$(TOOLCHAIN)/$(PROJECT_NAME).bin

$(BIN): main.cpp
	mbed compile -t $(TOOLCHAIN) -m $(MCU) --color

clean:
	rm -rf BUILD

write: build
	cp $(BIN) $(VOLUME_PATH)

