function[f_prim_t] = f_prim(b0, b1, b2, b3, t)
    f_prim_t = 3*((1-t)^2*(b1 - b0) + (b2 - b1)*2*t*(1-t) + (b3 - b2)*t^2);
