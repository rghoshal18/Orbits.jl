function iers2010( name=nothing )
    if name == nothing
        STR = "\nusage: TypicalConstants(VALID_STRING) \n
                    \tastronomical_unit \n
                    \tearth_radius_equator \n
                    \tearth_gm \n
                    \tearth_j2 \n
                    \tearth_rotation_rate \n
                    \tearth_mean_equatorial_gravity \n
                    \tearth_density_sea_water \n
                    \tbig_g \n
                    \tmean_equatorial_gravity \n
                    \tspeed_of_light \n
                    \tsun_gm \n\n"
        println(STR)
        return
    else
        name = lowercase(name)

        if name == "astronomical_unit"
            val = 1.49597870700e+11
            unit = "m"
            uncertainty = -1

        elseif name == "earth_radius_equator"
            val = 6.3781366000e+06
            unit = "m"
            uncertainty = -1
        elseif name =="earth_gm"
            val = 3.9860044180e+14
            unit = "m^3/s^2"
            uncertainty = -1
        elseif name =="earth_j2"
            val = 1.0826359e-3
            unit = ""
            uncertainty = 1e-10
        elseif name =="earth_rotation_rate"
            val = 7.2921150000e-05
            unit = "rad/s"
            uncertainty = -1
        elseif name =="earth_mean_equatorial_gravity"
            val = 9.7803278000e+00
            unit = "m/s^2"
            uncertainty = 1e-6
        elseif name =="earth_density_sea_water"
            val = 1.0250000000e+03
            unit = "kg/m^3"
            uncertainty = -1
        elseif name =="big_g"
            val = 6.67428e-11
            unit = "m^3/(kg*s^2)"
            uncertainty = 6.7e-15
        elseif name =="speed_of_light"
            val = 299792458
            unit = "m/s"
            uncertainty = 0
        elseif name =="sun_gm"
            val = 1.32712442099e20
            unit = "m^3/s^2"
            uncertainty = 1e10
        else
            error("ERROR! constant name not found!")
        end
        return (val,unit,uncertainty)
    end
end
