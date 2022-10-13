# Harmony for Barotrauma
Source mod loader/patcher for Barotrauma using Harmony.

Adds a new ModContent type: Harmony  
```xml
<Harmony file="[Local]Mods/Example DLL Mod/Example.dll" />
```

As the name suggests, this content type allows for Harmony patches to be applied (and any other form of code injection)

**For Users:** Download the latest release and unzip it to your game directory. Mods go in the normal mod folders.  
**For Mod Developers:** For the most part, you're just making standard Harmony patches. A few things to note:
- Your assemblies entry point **must** be a static method named `Main()`, inside a class with the same name as your assembly.
- Most of Barotrauma's classes are internal, so you'll have to use AccessTools to access them.
- You should include any external referenced assemblies within your mod's folder.


# Example Mod
Included as a demo and reference. Changes the time a chat  message was recieved to a different string.

To this:

**Example.cs**
```c#
using System;  
using System.Runtime;  
using System.Reflection;  
using HarmonyLib;  
using Barotrauma;  

public class Example
{
	public static void Main()
	{
		var harmony = new Harmony("com.example.patch");
		harmony.PatchAll();
	}
}

[HarmonyPatch]
class Patch
{
	public static MethodBase TargetMethod()
	{
		var type = AccessTools.TypeByName("ChatMessage");
		return AccessTools.Method(type, "GetTimeStamp");
	}
	static void Postfix(ref string __result)
	{
		__result = $"[MODDY] ";
	}
}
```
**filelist.xml**
```xml
<?xml version="1.0" encoding="utf-8"?>
<contentpackage name="Example DLL Mod" path="LocalMods/Example DLL Mod/filelist.xml" corepackage="false" gameversion="0.19.11.0">
  <Harmony file="LocalMods/Example DLL Mod/Example.dll" />
</contentpackage>
```
