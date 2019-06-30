function gcrs2itrf(input,t,tscale;rot=nothing)
    pos = [input.x input.y input.z]
    vel = [input.x_dot input.y_dot input.z_dot]
    if rot!=nothing
        rot=lowercase(rot)
        if rot=="zrot"||rot=="zrotation"
            t0  = 2451545 - 2453491.5
            t   = t .+ t0*86400
            omega = iers2010("earth_rotation_rate")
            theta = t .* omega[1] .- 2.4627624687549
            theta = rem.((rem.(theta, 2*pi) .+ 2*pi), 2*pi)
            (Rmat,dR) = getrotmat(theta)

        elseif rot=="era"
            dt    = frac.(t ./86400)
            theta = 2*pi .* (dt .+ 0.7790572732640 .+ 0.00273781191135448 .*t ./86400)
            theta = rem.((rem.(theta, 2*pi) + 2*pi), 2*pi)
            Rmat, dR = getrotmat(theta)

        elseif rot=="gast" || rot=="noeop"
            x=pi/180
            theta = x .* (51544.5 .+ t ./86400)
            Rmat, dR = getrotmat(theta)
        else
            error("Unknown rotation type: $rot")
        end
    end
    obj = state_vector([0],[0],[0],[0],[0],[0],"itrf")
    if length(t)==1
        outpos = Rmat * pos[:]
        outvel = Rmat * vel[:] + dR * pos[:]
    else
        outpos = pos
        outpos[:,1] = sum(Rmat[:,1:3] .* pos, dims=2)
        outpos[:,2] = sum(Rmat[:,4:6] .* pos, dims=2)
        outpos[:,3] = sum(Rmat[:,7:9] .* pos, dims=2)

        outvel = vel
        outvel[:,1] = sum(Rmat[:,1:3] .* vel, dims=2) .+ sum(dR[:,1:3] .* pos, dims=2)
        outvel[:,2] = sum(Rmat[:,4:6] .* vel, dims=2) .+ sum(dR[:,4:6] .* pos, dims=2)
        outvel[:,3] = sum(Rmat[:,7:9] .* vel, dims=2) .+ sum(dR[:,7:9] .* pos, dims=2)
    end
    obj.x = outpos[:,1]
    obj.y = outpos[:,2]
    obj.z = outpos[:,3]
    obj.x_dot = outvel[:,1]
    obj.y_dot = outvel[:,2]
    obj.z_dot = outvel[:,3]
    return obj,Rmat,dR
end
