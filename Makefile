dependency:
	cd build && cmake .. --graphviz=graph.dot && dot -Tpng graph.dot -o graphImage.png

prepare:
	@rm -rf build
	@mkdir build

conan_d:
	rm -rf build
	mkdir build
	cd build && conan install .. -s build_type=Debug -s compiler.cppstd=17 --output-folder=. --build missing

conan_r:
	rm -rf build
	mkdir build
	cd build && conan install .. -s build_type=Rlease -s compiler.cppstd=17 --output-folder=. --build missing