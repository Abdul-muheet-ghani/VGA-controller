
if [ "$1" = "clean" ]; then
    rm -rf obj*
    echo "Clean-up Done"
elif [ "$1" = "compile" ]; then
    verilator -I../src -cc vga_out.sv --exe main.cpp -o vga_output -CFLAGS "$(sdl2-config --cflags)" -LDFLAGS "$(sdl2-config --libs)"
    make -C ./obj_dir -f Vvga_out.mk
elif [ "$1" = "VGA" ]; then
    ./obj_dir/vga_output
else
    echo "Wrong Arguement"
fi