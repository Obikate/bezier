function [ courbe_lagrange ] = tracer_lagrange(matrice_pk, resolution)
x_min=min(matrice_pk(1,:));
x_max=max(matrice_pk(1,:));
x=linspace(x_min,x_max,resolution);
courbe_lagrange(1, 1) = 0;
courbe_lagrange(2, 1) = 0;
disp(matrice_pk);
for (i=1:length(x))
    courbe_lagrange(:, i) = lagrange_courbe(matrice_pk,x(i));
end;
end

