using Pkg;
Pkg.add(PackageSpec(url="https://github.com/rghoshal18/Orbits.jl"))
using Orbits

println("Loading Software ... ")

ae          = iers2010("earth_radius_equator")[1]
GM          = iers2010("earth_gm")[1]
e_rot       = iers2010("earth_rotation_rate")[1]
J2000       = cal2mjd(2000, 1, 1, 12, 0, 0)

println("Setting up initial parameters of the satellite configuration ... ")

sat_alt = ((GM/(e_rot)^2) * (365*1000/5620299)^2)^(1/3) - ae

sat_1 = kepler_elements(sat_alt,0.01,45*pi/180,pi/4,pi,pi/9)
sat_2 = kepler_elements(sat_alt,0.01,89.5*pi/180,pi/4,pi,pi/6)
sat_3 = kepler_elements(sat_alt,0.01,63.4*pi/180,pi/4,pi,pi/6)

t0          = cal2mjd(1998, 7, 16, 0)
duration    = 0.5
step_size   = 5

println("Computing J2 secular orbits of the satellite configuration")

println("Satellite 1 ... ")
(t, secularsat1) = j2secularorbit(sat_1, t0, duration, step_size,ae)

println("Satellite 2 ... ")
(t, secularsat2) = j2secularorbit(sat_2, t0, duration, step_size,ae)

println("Satellite 3 ... ")
(t, secularsat3) = j2secularorbit(sat_3, t0, duration, step_size,ae)

println("Converting Kepler elements to cartesian coordinates in the inertial reference frame ... ")

println("Satellite 1 ... ")
sat1state1 = kepler2cart(secularsat1,"mean", GM)
sat1state2,Rmat,dR = gcrs2itrf(sat1state1,(t .-J2000) .*86400,"GPS" , rot="zrot")

println("Satellite 2 ... ")
sat2state1 = kepler2cart(secularsat2,"mean", GM)
sat2state2,Rmat,dR = gcrs2itrf(sat2state1,(t .-J2000) .*86400,"GPS" , rot="zrot")

println("Satellite 3 ... ")
sat3state1 = kepler2cart(secularsat3,"mean", GM)
sat3state2,Rmat,dR = gcrs2itrf(sat3state1,(t .-J2000) .*86400,"GPS" , rot="zrot")
