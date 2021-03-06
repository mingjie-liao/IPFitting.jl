
using Test, JuLIP
using IPFitting
using IPFitting: Dat
using IPFitting.Data: configtype

##

println("===================================")
println("Testing Dat:")
println("  * Dat constructor")
println("  * vec, devec")
println("  * energy(dat), forces(dat), virial(dat)")
println("  * (de-)dictionisation, ==")

at = rattle!(bulk(:Fe) * 3, 0.1)
lj = LennardJones(r0 = rnn(:Fe)) * C2Shift(2.5*rnn(:Fe))
dat = Dat(at, "test"; E = energy(lj, at),
                      F = forces(lj, at),
                      V = virial(lj, at) )

println(@test(configtype(dat) == "test"))
println(@test(energy(dat) == energy(lj, at)))
println(@test(forces(dat) == forces(lj, at)))
println(@test(virial(dat) ≈ virial(lj, at)))

D = Dict(dat)
dat1 = Dat(D)
println(@test(dat == dat1))
dat2 = convert(Val(Symbol("IPFitting.Dat")), D)
println(@test(dat == dat2))

println("===================================")
