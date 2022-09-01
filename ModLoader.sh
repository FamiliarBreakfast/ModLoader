#!/bin/bash
if [ -d ./Source/.git ]; then
	cd ./Source
	git pull
	cd ..
else
	git clone https://github.com/Regalis11/Barotrauma Source
fi

if [ -d ./SourceTemp ]; then
	rm -rf ./SourceTemp
fi

mkdir ./SourceTemp
cp -r ./Source/* ./SourceTemp

#Yes i am aware this is ugly and stupid, but it's compatible, and thats what matters
IFS=$'\n' mods=($(find ./Mods -maxdepth 2 \( -name "BarotraumaClient" -o -name "BarotraumaServer" -o -name "BarotraumaShared" \)))
IFS=$'\n' localmods=($(find ./LocalMods -maxdepth 2 \( -name "BarotraumaClient" -o -name "BarotraumaServer" -o -name "BarotraumaShared" \)))

#Copy mod code to working folder
for mod in "${mods[@]}"
do
	cp -r $mod ./SourceTemp/Barotrauma
done
for mod in "${localmods[@]}"
do
	cp -r $mod ./SourceTemp/Barotrauma
done

#Compile
dotnet publish ./SourceTemp/Barotrauma/BarotraumaClient/LinuxClient.csproj -c Release -clp:"ErrorsOnly;Summary" --self-contained -r linux-x64 \/p:Platform="x64"
dotnet publish ./SourceTemp/Barotrauma/BarotraumaServer/LinuxServer.csproj -c Release -clp:"ErrorsOnly;Summary" --self-contained -r linux-x64 \/p:Platform="x64"

#Copy finished code and cleanup
cp -r ./SourceTemp/Barotrauma/bin/ReleaseLinux/netcoreapp3.1/linux-x64/* .
rm -rf ./SourceTemp
