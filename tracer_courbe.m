function[courbe_bezier, courbe_focale] = tracer_courbe(matrice_pk, matrice_mk, resolution, degre)
       %il faut diviser l'intervalle 1:resolution en k-sous-intervalle
   alpha = 0.2;
   %longueur d'un sous-intervalle
   long_k = floor(resolution/length(matrice_pk));
   for k = 1:(length(matrice_pk) - 1)
       %on calcule la courbe de bézier intermédiaire
       for t = 1:long_k 
           %comme on a besoin des points Pk, Pk+1, mk, mk+1, on crée une matrice intermédiaire
           mat_int(:, 1) = matrice_pk(:, k);
           mat_int(:, 2) = matrice_pk(:, k) + 1/3 * matrice_mk(:, k);
           mat_int(:, 3) = matrice_pk(:, k + 1) - 1/3 * matrice_mk(:, k + 1);
           mat_int(:, 4) = matrice_pk(:, k + 1);

           %calcul de la courbe de bézier
           courbe_bezier(1, (k - 1)*long_k + t) = casteljau(mat_int(1, :), t/long_k, degre + 1, 1);
           courbe_bezier(2, (k - 1)*long_k + t) = casteljau(mat_int(2, :), t/long_k, degre + 1, 1);

           %calcul de la courbure
           f_prim_t_x = f_prim(mat_int(1, 1), mat_int(1, 2), mat_int(1, 3), mat_int(1, 4), t/long_k);
           f_prim_t_y = f_prim(mat_int(2, 1), mat_int(2, 2), mat_int(2, 3), mat_int(2, 4), t/long_k);
           f_seconde_t_x = f_seconde(mat_int(1, 1), mat_int(1, 2), mat_int(1, 3), mat_int(1, 4), t/long_k);
           f_seconde_t_y = f_seconde(mat_int(2, 1), mat_int(2, 2), mat_int(2, 3), mat_int(2, 4), t/long_k);
           courbure((k - 1)*long_k + t)  = 1/((f_prim_t_x^2 + f_prim_t_y^2)^(3/2)/(f_seconde_t_y*f_prim_t_x - f_seconde_t_x*f_prim_t_y));

           %calcul de la courbe focale
           n = [-f_prim_t_y; f_prim_t_x];
           courbe_focale(:, (k-1)*long_k + t) = courbe_bezier(:, (k - 1)*long_k + t) + alpha*courbure((k - 1)*long_k + t) * n;
       end;
   end;