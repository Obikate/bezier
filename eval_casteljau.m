function[Bezier_curve_points] = eval_casteljau(matrice, resolution)

n=size(matrice,2) - 1;
temps=1:resolution;
for t=temps
    Bezier_curve_points(1,t) = casteljau(matrice(1,:), t/resolution, (n+1), 1);
    Bezier_curve_points(2,t) = casteljau(matrice(2,:), t/resolution, (n+1), 1);
end
