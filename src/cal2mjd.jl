"""
    cal2mjd(Y = nothing, M = nothing, D = nothing, h = nothing, m = nothing, s = nothing)
`CAL2MJD` converts a calendar date to a modified Julian date
\n
INPUT
\n
`Y,M,D,[h,m,s]` - Year, month, day, hour, minutes, seconds [n x 1]
                All the inputs must be of the same size. The
                variables in the brackets are optional.

OUTPUT
\n
`mjd` - Modified Julian Date
"""
function cal2mjd(Y = nothing, M = nothing, D = nothing, h = nothing, m = nothing, s = nothing)
    if (Y == nothing || M == nothing || D == nothing)
        error("Insufficient input arguments")
    elseif h == nothing
        rY = length(Y)
        rM = length(M)
        rD = length(D)
        if (rY == rM && rY == rD)==0
            error("The dimensions of all the input arguments must be the same. Please verify")
        end
        h = zeros(rY)[:]
        m = zeros(rY)[:]
        s = zeros(rY)[:]
    elseif m == nothing
        rY = length(Y)
        rM = length(M)
        rD = length(D)
        rh = length(h)
        if (rY == rM && rY == rD && rY == rh)==0
            error("The dimensions of all the input arguments must be the same. Please verify")
        end
        m = zeros(rY)[:]
        s = zeros(rY)[:]
    elseif s == nothing
        rY = length(Y)
        rM = length(M)
        rD = length(D)
        rh = length(h)
        rm = length(m)
        if (rY == rM && rY == rD && rY == rH && rm == rY)==0
            error("The dimensions of all the input arguments must be the same. Please verify")
        end
        s = zeros(rY)[:]
    else
        rY = length(Y)
        rM = length(M)
        rD = length(D)
        rh = length(h)
        rm = length(m)
        rs = length(s)
        if (rY == rM && rY == rD && rh == rY && rm == rY && rs == rY)==0
            error("The dimensions of all the input arguments must be the same. Please verify")
        end
    end
    rY = length(Y)
    newM=[]
    newY=[]
    newb=[]
    for idx in 1:rY
        if M[idx] <=2
            append!(newM,M[idx]+12)
            append!(newY,Y[idx]-1)
        else
            append!(newM,M[idx])
            append!(newY,Y[idx])
        end
    end
    b = zeros(length(Y))
    for idx in 1:rY
        if (1e4 * Y[idx] + 100 * M[idx] + D[idx]) <= 15821004
            append!(newb, -2 + floor((Y[idx] + 4716)/4) - 1179)
        else
            append!(newb, floor(Y[idx]/400) - floor(Y[idx]/100) + floor(Y[idx]/4))
        end

    end
    mjd_ = 365 .*newY .- 679004 .+ newb .+ floor.(30.6001 .* (newM .+ 1)) .+ D

    Dfrac = (h .+ m ./60 .+ s ./3600) ./24

    mjd = mjd_ .+ Dfrac
    return mjd
end
