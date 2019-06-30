function kepler2cart(input,tag = nothing,GM = nothing)
    if input==nothing
        error("Input detected is not valid")
    end
    a = input.a
    ecc = input.ecc
    inc = input.inc
    omper = deepcopy(input.omper)
    omasc = deepcopy(input.omasc)
    anom = deepcopy(input.meananomaly)

    anom = anom[:]
    if tag == nothing
        tag = "true"
    end
    if GM == nothing
        println("using the default value of GM of the Earth")
        GM = iers2010("earth_gm")[1]
    end

    n = sqrt(GM/a^3)

    if tag == "tim"
        M = n.*anom
        (E,itr) = kepler(M,ecc,1e-10)
    elseif tag == "tru"
        f = anom/180*pi
        E = atan(sqrt(1-ecc.^2).*sin(f),ecc+cos(f))
    elseif tag == "ecc"
        E = anom./180*pi
    elseif tag== "mean"
        x=pi/180
        (E,itr) = kepler(x .*anom,ecc,1e-10)
    else
        error("undefined anomaly type tag")
    end

    pos = hcat(a.*(cos.(E) .-ecc), a.*sqrt.(1 .-ecc.^2).*sin.(E), zeros(size(anom)))

    vel = hcat(-sin.(E), sqrt.(1 .-ecc.^2).*cos.(E), zeros(size(anom)))

    vel = vel .* ((n  .*  a  ./  (1  .-  ecc  .*  cos.(E))) * [1 1 1])

    (rpos, cpos) = size(pos)

    (rvel, cvel) = size(vel)

    for k in 1:rpos
        (tmp,d) = rot(pos[k,1:3],-omper[k],3)
        (tmp,d) = rot(tmp,-inc,1)
        (tmp,d) = rot(tmp,-omasc[k],3)
        pos[k, 1:3] = deepcopy(tmp)

        (tmp,d) = rot(vel[k,1:3],-omper[k],3)
        (tmp,d) = rot(tmp,-inc,1)
        (tmp,d) = rot(tmp,-omasc[k],3)
        vel[k, 1:3] = deepcopy(tmp)
    end

    if length(anom) ==  1
        pos = pos'
        vel = vel'
    end
    obj = state_vector(pos[:,1],pos[:,2],pos[:,3],vel[:,1],vel[:,2],vel[:,3],"gcrs")
    return obj
end
