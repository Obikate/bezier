function[f_seconde_t] = f_seconde(b0, b1, b2, b3, t)
    f_seconde_t = 6*((1-t) * (b2 - 2*b1 + b0) + t*(b3 - 2*b2 + b1));
