
module DataTypes

using StaticArrays
using JuLIP: vecs, mat, JVec, energy, forces, virial
import IPFitting: vec_obs, devec_obs, eval_obs, weighthook, Dat, err_weighthook

export ENERGY, FORCES, VIRIAL

# some convenience functions to dispatch string arguments
vec_obs(s::AbstractString, args...) = vec_obs(Val(Symbol(s)), args...)
devec_obs(s::AbstractString, args...) = devec_obs(Val(Symbol(s)), args...)
eval_obs(s::AbstractString, args...) = eval_obs(Val(Symbol(s)), args...)
weighthook(s::AbstractString, args...) = weighthook(Val(Symbol(s)), args...)

# ------------------- DEFAULTS ------------------

vec_obs(::Val, x::AbstractVector{<: AbstractFloat}) = collect(x)
devec_obs(::Val,  x::AbstractVector) = x

# ------------------- ENERGY ------------------

const ENERGY = "E"
const ValE = Val{:E}
vec_obs(::ValE, E::Real) = [E]
vec_obs(::ValE, E::Vector{<: Real}) = E
devec_obs(::ValE, x::AbstractVector) = ((@assert length(x) == 1); x[1])
eval_obs(::ValE, B, dat::Dat) = energy(B, dat.at)
weighthook(::ValE, d::Dat) = 1.0 / sqrt(length(d.at))
err_weighthook(::ValE, d::Dat) = 1.0 / length(d.at)


# ------------------- FORCES ------------------

const FORCES = "F"
const ValF = Val{:F}
vec_obs(v::ValF, F::AbstractVector{<:JVec}) = vec_obs(v, mat(F))
vec_obs(::ValF, F::AbstractMatrix) = vec(F)
devec_obs(::ValF, x::AbstractVector) = vecs(reshape(x, 3, :))
eval_obs(::ValF, B, dat::Dat) = forces(B, dat.at)

function vec_obs(valF::ValF, F::Vector{<: Vector})
   nbasis = length(F)
   nat = length(F[1])
   Fmat = zeros(3*nat, nbasis)
   for ib = 1:nbasis
      Fmat[:, ib] .= vec_obs(valF, F[ib])
   end
   return Fmat
end

# ------------------- VIRIAL ------------------
# using Voigt convention for vectorising  symmetric 3 x 3 matrix
#  1  6  5
#  6  2  4
#  5  4  3
const _IV = [1,5,9,6,3,2]
const _IVst = SVector(1,5,9,6,3,2)
const VIRIAL = "V"
const ValV = Val{:V}
vec_obs(::ValV, v::AbstractVector{<: Real}) = (@assert length(v) == 6; collect(v))
vec_obs(::ValV, V::AbstractMatrix) = (@assert size(V) == (3,3); V[_IV])
devec_obs(::ValV, x::AbstractVector) =
   SMatrix{3,3}(x[1], x[6], x[5], x[6], x[2], x[4], x[5], x[4], x[3])
eval_obs(::ValV, B, dat::Dat) = virial(B, dat.at)
weighthook(::ValV, d::Dat) = 1.0 / sqrt(length(d.at))
err_weighthook(::ValV, d::Dat) = 1.0 / length(d.at)

function vec_obs(valV::ValV, V::AbstractVector{<: AbstractMatrix})
   nbasis = length(V)
   Vmat = zeros(6, nbasis)
   for ib = 1:nbasis
      Vmat[:, ib] .= vec_obs(valV, V[ib])
   end
   return Vmat
end



end
