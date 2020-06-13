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

You need to have :

```
julia (minimum 1.1.1)

```

### Installing

To start using this package:


```julia
using Pkg;
Pkg.add("https://github.com//rghoshal18//Orbits.jl);
```

An example.jl is there for a liitle demo of the functions in this package.

## Authors

* **Rajat Ghoshal** - *Initial work* - [rghoshal18](https://github.com/rghoshal18)
* **Prince Kumar** - *Initial work*


## License

This project is open source.

## Acknowledgments

