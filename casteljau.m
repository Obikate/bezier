function[val] = casteljau(vect, t0, n, i)

if n==1
    val=vect(1, i);
else
    val=(1-t0)*casteljau(vect, t0, (n-1), i) + t0*casteljau(vect, t0, (n-1), (i+1));
end
