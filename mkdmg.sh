#! /bin/sh

rm -f "Singular.dmg" || exit 1
./buildDMG.pl -dmgName Singular -volName Singular -compressionLevel 9 -slaRsrcFile ./SLA.r Singular.app -deleteHeaders || exit 1

