"""
    rot(xin,dxin,alfa,i=nothing)

ROT  performs 3D rotations

    INPUT
    \n`xin`   - input coordinates  Nx3 or 3xN matrix
    \n`dxin`  - variances of input coordinates
    \n`alfa`  - rotation angle [degree]	vector
    \n`i`     - rotation axis 		scalar

    OUT
    \n`xout`  - output coordinates 	Nx3 or 3xN matrix
    \n`dxout` - variances of output coordinates

"""
function rot(xin,dxin,alfa,i=nothing)
    if i == nothing
        i = alfa
        alfa = dxin
        dxin = [0 0 0]
    end

    if length(i)!=1
        error("I should be scalar")
    end

    c  = cosd.(alfa)
    s  = sind.(alfa)
    x  = xin[1]
    dx = dxin[1]
    y  = xin[2]
    dy = dxin[2]
    z  = xin[3]
    dz = dxin[3]
    if i == 1
        xout  =  [    x  ,      c * y+s * z     ,    -s * y+c * z    ]
        dxout =  [   dx  ,  c^2 * dy+s^2 * dz , s^2 * dy+c^2 * dz]
    elseif i == 2
        xout  =  [    c * x-s * z     ,     y     ,    s * x+c * z    ]
        dxout =  [c^2 * dx+s^2 * dz ,    dy     ,s^2 * dx+c^2 * dz]
    elseif i == 3
        xout  =  [    c * x+s * y     ,    -s * x+c * y    ,     z ]
        dxout =  [c^2 * dx+s^2 * dy , s^2 * dx+c^2 * dy,    dz ]
    else
        error("Choose axis I = 1, 2 or 3")
    end

    return (xout,dxout)
end
