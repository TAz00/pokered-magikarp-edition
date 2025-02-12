# It's Red and Blue, but its mostly magikarps

- Trainers are magikarps
- Rival is a magikarp
- Gym leaders are themselves, but with magikarps
- Pokemon look like magikarp, but act like their normal selves
- Last rival battle features lvl 100 magikarps
- POKé replaced by KARP
- Dialouge modified
- And some other little magikarp tweaks

Why? My brother and I were brainstorming ideas after he got an IPS modded gameboy

<p float="left">
  <img src="/MagikarpBoxArt.png" width="300" />
  <img src="/magikarp-mon.png" width="335" /> 
</p>
<p float="left">
  <img src="/hello-there.png" width="300" />
  <img src="/books.png" width="300" /> 
</p>

# Build with docker

Install Docker for Desktop https://www.docker.com/products/docker-desktop/

![alt text](https://github.com/TAz00/pokered-magikarp-edition/blob/master/docker-folder.png?raw=true)

### dockerfile

```
# syntax=docker/dockerfile:1
FROM ubuntu:18.04

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    build-essential make clang git sed gcc bison pkg-config libpng-dev && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/archive/* /var/lib/apt/lists/*

RUN git clone https://github.com/gbdev/rgbds
WORKDIR /rgbds
RUN make -j4
RUN make install
WORKDIR /
RUN mkdir /pokered
WORKDIR /pokered

CMD make clean && make -j4
```

### build-windows.bat - Build the docker image

```
@REM Build docker image
docker build -t docker-poke-builder:latest . 
pause
```

### run-windows.bat - Compile

```
@REM Run docker image 
docker container run -v /c/build/pokered-magikarp-edition-master:/pokered docker-poke-builder:latest  
copy C:\build\pokered-magikarp-edition-master\pokered.gbc C:\build\POKEMONR.GBC /Y
copy C:\build\pokered-magikarp-edition-master\pokeblue.gbc C:\build\POKEMONB.GBC /Y
pause
```


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
