function j2secularorbit(in_put, t0 = nothing, duration = nothing, step_size = nothing,ae = nothing)
    if in_put==nothing
        error("No Input detected")
    elseif t0 == nothing
        t0 = cal2mjd(2000, 1, 1, 0)
        duration = 1
        step_size = 10
    elseif duration == nothing
        duration = 1
        step_size = 10
    elseif step_size == nothing
        step_size = 10
    elseif ae == nothing
        ae = iers2010("earth_radius_equator")[1]
    end

    if length(t0)!=1
        error("Initial epoch t0 must be a scalar value")
    end
    if length(duration)!=1
        error("Duration of the satellite orbit must be a scalar value")
    end
    if length(step_size)!=1
        error("Along track sampling step size must be a scalar value")
    end

    GM  = iers2010("earth_gm")[1]
    ae  = iers2010("earth_radius_equator")[1]
    C20 = iers2010("earth_j2")[1]

    a   = ae + in_put.a
    n   = sqrt(GM/a^3)

    common_factor   = 3/4 * n * C20 * 1/(1-in_put.ecc^2)^2 * (ae/a)^2
    omper_dot       = common_factor * (1 - (5 * cos(in_put.inc)^2))
    omasc_dot       = 2 * common_factor * cos(in_put.inc)
    M_dot           = n - ( common_factor * sqrt(1 - in_put.ecc^2) * ((3 * cos(in_put.inc)^2) - 1))

    t=[t0[1]]

    outomper = [in_put.omper]
    outomasc = [in_put.omasc]
    outm     = [in_put.meananomaly]

    for i in 0:step_size:duration*86400
        append!(t,t0[1]+i/86400)
        append!(outomper,in_put.omper+i*omper_dot)
        append!(outomasc,in_put.omasc+i*omasc_dot)
        temp = in_put.meananomaly + i*M_dot
        append!(outm,mod(mod(temp, 2*pi), 2*pi))
    end
    obj = secular_kepler_elements(in_put.a+ae,in_put.ecc,in_put.inc .*180/pi,outomper .*180/pi,outomasc .*180/pi, outm .*180/pi)
    return t,obj
end
