"""
   kepler(mm,ecc,tol=nothing)

   KEPLER returns the eccentric anomaly from mean anomaly and eccentricity
       by Newton-Raphson iteration of Kepler's equation: M = E - e sinE.
       Max number of iterations equals 20.

   (ee,itr) = kepler(mm,ecc,tol)

   INPUT
    \n`mm`  - mean anomaly [rad]	- matrix
    \n`ecc` - eccentricity        - matrix
    \n`tol` - tolerance level (def: 1e-10)
   OUT
    \n`ee`  - eccentric anomaly [rad]
    \n`itr` - number of iterations (optional)
"""
function kepler(mm,ecc,tol=nothing)

   if tol == nothing
      tol = 1e-10 #defaul tolerance level
   elseif length(tol)!=1
      error("TOL should be scalar")
   end

   if ecc >= 1 || ecc < 0
      error("Invalid eccentricity")
   end

   maxitr = 20  #% maximum #iterations

   mm     = rem.(mm,2*pi)
   eeold  = mm
   eenew  = eeold + ecc.*sin.(eeold)
   itr    = 0
#iterate until all elements suffice TOL criterium
   while any(any(abs.(eenew-eeold) .> tol)) && (itr < maxitr)
      itr   = itr + 1
      eeold = eenew
      fold  = eeold-ecc.*sin.(eeold)-mm
      fpold   = 1  .- ecc.*cos.(eeold)
      eenew = eeold .- fold./fpold
   end

   if (itr == maxitr) && any(any(abs(eenew-eeold) > tol))
      error(">> KEPLER.M << didn''t achieve convergence within 20 iterations")
   else
      ee = eenew;
   end
   return (ee,itr)
end
