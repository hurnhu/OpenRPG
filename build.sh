#!/bin/bash

cwd=$(pwd)

build_cpp(){
    if hash cmake 2>/dev/null; then
        if hash make 2>/dev/null; then
            if [ ! -d "$cwd/build" ]; then
                mkdir "$cwd/build"
            fi

            pushd $cwd/build/

            #TODO should we check the arch we are building for?

            if [[ ! -a "Makefile" ]]; then
                cmake ..
            fi

            make
            popd
        else
            echo "MAKE NOT INSTALLED, ABORTING..."
    	    
            STATUS=-1;
        fi
    else
        echo "CMAKE NOT INSTALLED, ABORTING..."
	
	STATUS=-1;
    fi
}

built_api(){
   if hash cargo 2>/dev/null; then
        if [[ ! -a "Cargo.toml" ]]; then

              pushd $cwd/api/

              cargo build

              popd
        else
              echo "CARGO.TOML NOT FOUND..."
        fi
   else
        echo "CARGO/RUST NOT INSTALLED..."
   fi
}

if [[ $OSTYPE == "linux"* || $OSTYPE == "darwin"*  ||  $OSTYPE == "cygwin" ]] && [[ $# -eq 0 ]]; then
    build_cpp
elif [[ "$1" == "api" ]]; then

    echo "BUILDING CPP SOURCE..."

    STATUS=1;

    build_cpp
    if [[ $STATUS > 0  ]]; then
        echo "FINISHED.... MOVING FILES..."
        if [ ! -d "$cwd/build" ]; then
            mkdir $cwd/api/build/
        fi
        cp $cwd/build/{character-generator,name-generator,roll,openrpg} $cwd/api/build/ 

        echo "FINISHED.... BUILDING API..."

        built_api
    else
        echo "THERE WAS AN ERROR BUILDING CPP SOURCES..."
    fi
elif [[ "$1" == "clean-api" ]]; then
    if [ -d "$cwd/api/build/" ]; then

      echo "REMOVING API/BUILD"  

      rm -r "$cwd/api/build/"
    fi

    pushd $cwd/api/

    echo "CLEANING API DIR"

    cargo clean

    echo "API CLEAN... FINISHED"

    popd
else
    echo "UNSUPORTED PLATFORM $OSTYPE OR INVALID ARGUMENT"
fi
