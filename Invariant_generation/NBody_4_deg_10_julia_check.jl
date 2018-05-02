function invariants_Q6_check(x)
pv=zeros(6,1);

v=zeros(6,1);
 v[1] = 1
 pv[1] = x[1]^2*x[2] + x[1]*x[2]^2 + x[1]^2*x[4] + 
x[2]^2*x[4] + x[1]*x[4]^2 + x[2]*x[4]^2 + 
x[1]^2*x[3] + x[2]^2*x[3] + x[1]*x[3]^2 + 
x[2]*x[3]^2 + x[1]^2*x[5] + x[4]^2*x[5] + 
x[3]^2*x[5] + x[1]*x[5]^2 + x[4]*x[5]^2 + 
x[3]*x[5]^2 + x[2]^2*x[6] + x[4]^2*x[6] + 
x[3]^2*x[6] + x[5]^2*x[6] + x[2]*x[6]^2 + 
x[4]*x[6]^2 + x[3]*x[6]^2 + x[5]*x[6]^2
 v[2:2] = pv[1:1]
 pv[2] = x[1]^3*x[2] + x[1]*x[2]^3 + x[1]^3*x[4] + 
x[2]^3*x[4] + x[1]*x[4]^3 + x[2]*x[4]^3 + 
x[1]^3*x[3] + x[2]^3*x[3] + x[1]*x[3]^3 + 
x[2]*x[3]^3 + x[1]^3*x[5] + x[4]^3*x[5] + 
x[3]^3*x[5] + x[1]*x[5]^3 + x[4]*x[5]^3 + 
x[3]*x[5]^3 + x[2]^3*x[6] + x[4]^3*x[6] + 
x[3]^3*x[6] + x[5]^3*x[6] + x[2]*x[6]^3 + 
x[4]*x[6]^3 + x[3]*x[6]^3 + x[5]*x[6]^3
 v[3:3] = pv[2:2]
 pv[3] = x[1]^5 + x[2]^5 + x[4]^5 + x[3]^5 + x[5]^5 + 
x[6]^5
 v[4:4] = pv[3:3]
 v[5] = pv[1]*pv[1]
 v[6] = pv[2]*pv[3]
 Primary_invariants=
[
    x[1] + x[2] + x[3] + x[4] + x[5] + x[6],
    x[1]*x[6] + x[2]*x[5] + x[3]*x[4],
    x[1]^2 + x[2]^2 + x[3]^2 + x[4]^2 + x[5]^2 + x[6]^2,
    x[1]*x[2]*x[3] + x[1]*x[4]*x[5] + x[2]*x[4]*x[6] + x[3]*x[5]*x[6],
    x[1]^3 + x[2]^3 + x[3]^3 + x[4]^3 + x[5]^3 + x[6]^3,
    x[1]^4 + x[2]^4 + x[3]^4 + x[4]^4 + x[5]^4 + x[6]^4
]

return Primary_invariants, v

end
x = rand(6)
display(invariants_Q6_check(x))
