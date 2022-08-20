# ModLoader
Source mod loader for barotrauma  

Very basic proof of concept for a source mod loader, by recompiling the game source on launch. Surprisingly fast, less than 20 seconds on a Ryzen 7 3700X, with subsequent launches being faster.  

It is currently a bash script, compatible with Bash 3.0 and up. Requires dotnet SDK for compiling and git for fetching the source code. Place the script in the Barotrauma root folder.

Mods are placed into /Mods or /LocalMods. The structure must match that of the source code, and should look like  
/Mods/[modname]/BarotraumaClient|BarotraumaServer|BarotraumaShared/[...]  
```
 Mods
└── [modname]
    ├── BarotraumaClient
    │   └── ClientSource
    │       ├── client2.cs
    │       └── client.cs
    ├── BarotraumaServer
    │   └── ServerSource
    │       └── server.cs
    └── BarotraumaShared
        └── SharedSource
            └── shared.cs
```
<sup>Something like this</sup>  
My implementation is crude, and was thrown together quite quickly, but theoretically, this method could be extended to patch individual classes, too. As it stands, however, you can only add or modify source files.  

Since mods can be stored in /Mods, they can theoretically be shared on Steam, and reap all the benefits thereof. This makes mod management much easier for everyone.  
