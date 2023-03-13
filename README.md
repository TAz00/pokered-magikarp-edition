# Batteryless Cartridge Save Patch


So I wanted to flash my magikarp game onto some cartridges, and I run into the problem of batteryless save cartridges.
Can't save the game because it expects battery powered SRam.


So using the BGB emulator, lots of notepad, bit of chatgpt, I've gone from knowing no assembly, to a build-from-source patch that works with my cartridges.


I havnt yet figured out the details of the commands sent to (0555) and (02AA) to control the read/write/erase, just that they work for this cartridge.


The original patch, used the cartridge checksum, inplace of the chipID and/or ManufacturerID, which is verified before saving.
It also only seems to erase the first romBank of the 4 (half-filled) banks used for the save data, so I tweaked it a bit. (saves are slower)


It was quite fun to figure out the LOAD UNION commands to define code meant to execute from memory.


Not quite sure if the stack position in WRAM0 is still going to work, might collide with the space im using for executing in memory.
The reason im still using the method of loading code to memory, is I couldnt fit it all ROM0.

<p float="left">
  <img src="/pokemon-blue.png" width="300" />
  <img src="/pokemon-red.png" width="300" /> 
</p>

Some things I could've done

	- Use more of the pokémon built-in commands to transfer memory, didnt do this because it would make the code less portable.
	
	- Shrink the code better, yeah well, I have 7 days of assembly experience now :p 
	
	- Instead of using 2000 bytes of 4000 to save the data in 4 rombanks, could save it in two now
	
	- Move the save/load mainroutines out of C1 to their own bank, then use small jumps to header to load that codebank

# Pokémon Red and Blue [![Build Status][ci-badge]][ci]

This is a disassembly of Pokémon Red and Blue.

It builds the following ROMs:

- Pokemon Red (UE) [S][!].gb `sha1: ea9bcae617fdf159b045185467ae58b2e4a48b9a`
- Pokemon Blue (UE) [S][!].gb `sha1: d7037c83e1ae5b39bde3c30787637ba1d4c48ce2`
- BLUEMONS.GB (debug build) `sha1: 5b1456177671b79b263c614ea0e7cc9ac542e9c4`
- dmgapae0.e69.patch `sha1: 0fb5f743696adfe1dbb2e062111f08f9bc5a293a`
- dmgapee0.e68.patch `sha1: ed4be94dc29c64271942c87f2157bca9ca1019c7`

To set up the repository, see [**INSTALL.md**](INSTALL.md).


## See also

- [**Wiki**][wiki] (includes [tutorials][tutorials])
- [**Symbols**][symbols]
- **Discord:** [pret][discord]
- **IRC:** [libera#pret][irc]

Other disassembly projects:

- [**Pokémon Yellow**][pokeyellow]
- [**Pokémon Gold/Silver**][pokegold]
- [**Pokémon Crystal**][pokecrystal]
- [**Pokémon Pinball**][pokepinball]
- [**Pokémon TCG**][poketcg]
- [**Pokémon Ruby**][pokeruby]
- [**Pokémon FireRed**][pokefirered]
- [**Pokémon Emerald**][pokeemerald]

[pokeyellow]: https://github.com/pret/pokeyellow
[pokegold]: https://github.com/pret/pokegold
[pokecrystal]: https://github.com/pret/pokecrystal
[pokepinball]: https://github.com/pret/pokepinball
[poketcg]: https://github.com/pret/poketcg
[pokeruby]: https://github.com/pret/pokeruby
[pokefirered]: https://github.com/pret/pokefirered
[pokeemerald]: https://github.com/pret/pokeemerald
[wiki]: https://github.com/pret/pokered/wiki
[tutorials]: https://github.com/pret/pokered/wiki/Tutorials
[symbols]: https://github.com/pret/pokered/tree/symbols
[discord]: https://discord.gg/d5dubZ3
[irc]: https://web.libera.chat/?#pret
[ci]: https://github.com/pret/pokered/actions
[ci-badge]: https://github.com/pret/pokered/actions/workflows/main.yml/badge.svg
