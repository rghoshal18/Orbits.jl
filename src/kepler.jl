function kepler(mm,ecc,tol=nothing)

   if tol == nothing
      tol = 1e-10
   elseif length(tol)!=1
      error("TOL should be scalar")
   end

   if ecc >= 1 || ecc < 0
      error("Invalid eccentricity")
   end

   maxitr = 20

   mm     = rem.(mm,2*pi)
   eeold  = mm
   eenew  = eeold + ecc.*sin.(eeold)
   itr    = 0

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
