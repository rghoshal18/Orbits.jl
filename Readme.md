# Orbits.jl

This is a package which can be used for doing basic simulation of orbital parameters.
It was a part of my summer project in the year 2019 under the guidance of Prof. Balaji Devaraju,
Department of Civil Engineering, IIT Kanpur.


## Getting Started

Before starting to use this tool, you need to have some knowledge of:

[Keplerian Elements](https://www.tutorialspoint.com/satellite_communication/satellite_communication_orbital_mechanics.htm)
, [Coordinate Systems like GCRS, ITRF etc.](http://www.igig.up.wroc.pl/satgeonaw2011/.%5Cdownload%5CPrezentacje%5CSesja1%5CBrzezinskiLiwoszRogowski-Global%20reference%20systems%20and%20Earth%20rotation.pdf)
, [Julian Date](https://www.aavso.org/about-jd)
, [IERS Convention](https://www.iers.org/IERS/EN/Publications/TechnicalNotes/tn36.html)
, [j2 effect of earth](https://link.springer.com/chapter/10.1007%2F3-540-26932-0_6)
and basic coordinate geometry concepts.

### Prerequisites

You need to have julia (min 1.1.1) installed in your system for using this package.

#### On Linux
```bash
cd ~/Downloads
wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.2-linux-x86_64.tar.gz
tar -xvzf julia-1.4.2-linux-x86_64.tar.gz
sudo cp -r julia-1.4.2 /opt/
sudo ln -s /opt/julia-1.4.2/bin/julia /usr/local/bin/julia
```

#### On Windows

Install julia using windows executable file from [here](https://julialang.org/downloads/).

### Installing

To start using this package:


```julia
using Pkg;
Pkg.add(PackageSpec(url="https://github.com/rghoshal18/Orbits.jl"))
using Orbits
```

An example.jl is there for a liitle demo of the functions in this package.

## Authors

* **Rajat Ghoshal** - [rghoshal18](https://github.com/rghoshal18)
* **Prince Kumar**


## License

This project is open source.
