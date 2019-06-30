struct kepler_elements
    a :: Float64
    ecc :: Float64
    inc :: Float64
    omper :: Float64
    omasc :: Float64
    meananomaly :: Float64
end

mutable struct secular_kepler_elements
    a :: Float64
    ecc :: Float64
    inc :: Float64
    omper :: Vector{Float64}
    omasc :: Vector{Float64}
    meananomaly :: Vector{Float64}
end

mutable struct state_vector
    x :: Vector{Float64}
    y :: Vector{Float64}
    z :: Vector{Float64}
    x_dot :: Vector{Float64}
    y_dot :: Vector{Float64}
    z_dot :: Vector{Float64}
    ref_frame
end
