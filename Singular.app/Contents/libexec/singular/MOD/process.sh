#!/bin/sh

# cat ./todo | xargs -I '{}' strip './{}' 


#cat ./todo | xargs -I '{}' install_name_tool -change "/usr/lib/libncurses.5.4.dylib" "@executable_path/../mylibs/libncurses.dylib" "./{}"
#cat ./todo | xargs -I '{}' install_name_tool -change "/usr/local/lib/libgmp.10.dylib" "@executable_path/../mylibs/libgmp.dylib" "./{}"

cat ./todo | xargs -I '{}' otool -L './{}' | sort | uniq | grep -E 'lib(gmp|ncurses|edit).*dylib' | sed -e 's| (.*$||g' -e 's|[ 	]*||g' > libs

cat ./libs | sed -e 's|^.*/lib||g' | sed -e 's|\..*dylib$||g'  > names

for n in `cat ./names` 
do
#  echo $n
  L=`grep "${n}" ./libs`
#  echo $L
  cat ./todo | xargs -I '{}' ./install_name_tool -change "$L" "@executable_path/../mylibs/lib${n}.dylib" "./{}" 
done

#cat ./todo | xargs -I '{}' install_name_tool -change "/usr/lib/libedit.3.dylib" "@executable_path/../mylibs/libedit.dylib" "./{}" 

# | sort | uniq

exit 0



# install_name_tool: object: ./libgmp.10.dylib malformed object (unknown load command 11) ????
# cat ./todo | grep libgmp | xargs -I '{}' install_name_tool -id "@executable_path/../mylibs/libgmp.dylib" "./{}"



# i386 ?
##### cat ./todo | xargs -I '{}' mv './{}' './FAT/FAT.{}' || exit 1
### cat ./todo | xargs -I '{}' lipo './FAT/FAT.{}' -thin x86_64  -output './{}' || exit 1
##cat ./todo | xargs -I '{}' lipo -create -arch i386 './32.{}' -arch x86_64 './64.{}' -output './FAT/FAT.{}' || exit 1
## cat ./todo | xargs -I '{}' rm -f './32.{}' './64.{}' || exit 1
