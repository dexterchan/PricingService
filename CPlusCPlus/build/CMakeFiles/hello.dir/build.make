# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.11

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/local/bin/cmake

# The command to remove a file.
RM = /opt/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build

# Include any dependencies generated for this target.
include CMakeFiles/hello.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/hello.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/hello.dir/flags.make

CMakeFiles/hello.dir/test.c.o: CMakeFiles/hello.dir/flags.make
CMakeFiles/hello.dir/test.c.o: ../test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/hello.dir/test.c.o"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hello.dir/test.c.o   -c /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/test.c

CMakeFiles/hello.dir/test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hello.dir/test.c.i"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/test.c > CMakeFiles/hello.dir/test.c.i

CMakeFiles/hello.dir/test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hello.dir/test.c.s"
	/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/test.c -o CMakeFiles/hello.dir/test.c.s

# Object files for target hello
hello_OBJECTS = \
"CMakeFiles/hello.dir/test.c.o"

# External object files for target hello
hello_EXTERNAL_OBJECTS =

libhello.a: CMakeFiles/hello.dir/test.c.o
libhello.a: CMakeFiles/hello.dir/build.make
libhello.a: CMakeFiles/hello.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libhello.a"
	$(CMAKE_COMMAND) -P CMakeFiles/hello.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hello.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/hello.dir/build: libhello.a

.PHONY : CMakeFiles/hello.dir/build

CMakeFiles/hello.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/hello.dir/cmake_clean.cmake
.PHONY : CMakeFiles/hello.dir/clean

CMakeFiles/hello.dir/depend:
	cd /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build /Users/dexter/sandbox/CplusplusPractise/PricingService/PricingService/CPlusCPlus/build/CMakeFiles/hello.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/hello.dir/depend

