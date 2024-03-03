
if [ "$1" = "clean" ]; then
    rm -rf obj*
    echo "Clean-up Done"
elif [ "$1" = "compile" ]; then
    verilator -I../src -cc top_square.sv --exe main_square.cpp -o square -CFLAGS "$(sdl2-config --cflags)" -LDFLAGS "$(sdl2-config --libs)"
    make -C ./obj_dir -f Vtop_square.mk
elif [ "$1" = "VGA" ]; then
    ./obj_dir/square
else
    echo "Wrong Arguement"
fi