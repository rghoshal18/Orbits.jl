"""
    getrotmat(theta)
GETROTMAT gives us the rotation matrix for the input angles for rotation around
    z-axis.

INPUT
\n
`theta` : It contains list of angles in degrees.
\n
OUTPUT
\n
`(Rmat,dR)` : Rmat : a matrix of n * 9 elements where each row is the
                    rotation matrix for corresponding theta angle.
"""
function getrotmat(theta)
    omega = iers2010("earth_rotation_rate")[1]
    if length(theta) ==1
        Rmat = [ cos(theta) sin(theta) 0 -sin(theta) cos(theta) 0  0   0   1]
        dR   = omega .* [-sin(theta)  cos(theta) 0 -cos(theta) -sin(theta) 0  0  0  0];
    else
        theta = theta[:]
        sifr = zeros(size(theta));
        one  = ones(size(theta));
        Rmat = [ cos.(theta) sin.(theta) sifr -sin.(theta) cos.(theta) sifr sifr   sifr     one]

        dR   =  omega * [-sin.(theta)  cos.(theta) sifr -cos.(theta) -sin.(theta) sifr sifr   sifr  sifr]
    end
    return  Rmat,dR
end
