function []= kebab()

resolution = 1000; %resolution de la courbe BSpline
K = 0;            %variable d'état
matrice_pk = 0;      %P_i, points de contrôle
matrice_mk = 0;
degre = 3;   %degré par défaut des courbes BSpline
max_points = 100; %on se limite par défaut à 100 points de contrôle
clear ids_pk;  %on utilise des ensembles d'IDs pour avoir des points 
clear ids_mk;  %drag&drop
clear current_plot;  %pour facilement effacer un plot

while K ~= 4
    %on crée le menu
    K = menu('Menu de malade', 'donner les points de contrôle - méthode 1', 'donner les points de contrôle - méthode 2','saisir m0 et mN à la souris', 'arrêter');
    
    if (((K == 1) || (K == 2)) || (K == 3))   %on ajoute les P_i        
        %paramètrage de la fenêtre
        clf;
        hold on;
        axis([-1 1 -1 1]);
        axis off;
        %on reinitialise l'ensemble des P_i
        matrice_pk = 0;
        clear ids_pk;
        %on prend en compte les P_i initialisés par la souris (ginput) et on s'arrête
        %si l'utilisateur appuie sur ENTER (isempty(X))
        for i = 1:max_points
            [x, y] = ginput(1); %on crée 1 point avec la souris
            if isempty(x) %si x est vide, alors l'entrée vient pas de la souris => on s'arrête
                break;
            end;
            %on sauvegarde P_i, le point courant
            matrice_pk(1, i) = x;
            matrice_pk(2, i) = y;
            %on crée un point "draggable"
            ids_pk(i) = impoint(gca, x, y);
            %chaque point "draggable" dispose d'une fonction qu'il appelle lorsqu'il a une nouvelle position
            addNewPositionCallback(ids_pk(i), @update);
            %plot(matrice_pk(1, :), matrice_pk(2, :), 'b');  %tracé polygone de contrôle
        end;
        %tracé de la courbe B-i
        dim = size(matrice_pk);
        %on veut la tracer que si on a >= 2 points
        if (dim(2) > 1)
            if (K == 1) %Catmull-Rom splines
                ids_mk = initDerivate(matrice_pk, 0);  %on initialise les IDs des mk
            else  %cardinal splines
                prompt = 'Entrez la valeur du paramètre de tension svp. Entre 0 et 1 ';
                c = input(prompt);
                while ((c <= 0) || (c > 1))  %on vérifie que c est bon
                    input(prompt);
                end;
                ids_mk = initDerivate(matrice_pk, c);
            end;

            matrice_mk = ids_to_coord(ids_mk);  %on recupère les coordonnées des mk
            [courbe_bezier, courbe_focale] = tracer_courbe(matrice_pk, matrice_mk, resolution, degre); %et on peut tracer
            current_plot = plot(courbe_bezier(1, :), courbe_bezier(2, :), 'r', courbe_focale(1, :), courbe_focale(2, :), 'b');       %la courbe de Bézier
        end;
    end;
end;    
close;  
%fonction de relachement des points "draggables"
function update(pos)
        matrice_pk = ids_to_coord(ids_pk);
        matrice_mk = ids_to_coord(ids_mk);
        courbe_bezier = tracer_courbe(matrice_pk, matrice_mk, resolution, degre);
        delete(current_plot);
        current_plot = plot(courbe_bezier(1, :), courbe_bezier(2, :), 'r');
end
%fonction d'initialisation des mk et des IDs des mk
function[ids_mk] = initDerivate(matrice_pk, tension)
    clear ids_mk;
    matrice_mk = 0;
    for i = 1:(length(matrice_pk) - 1)
        matrice_mk(1, i) = (1 - tension) * (matrice_pk(1, i+1) - matrice_pk(1, i)); %calcul selon le modèle naïf
        matrice_mk(2, i) = (1 - tension) * (matrice_pk(2, i+1) - matrice_pk(2, i));
    end;
    if (length(matrice_pk) > 2) %pour le dernier mk, on fait la moyenne des deux mk précédents, sauf s'il n'y a que 2 points en tout
        matrice_mk(:, length(matrice_pk)) = 0.5*matrice_mk(:, (length(matrice_pk) - 1)) + 0.5*matrice_mk(:, (length(matrice_pk) - 2));
    else
        matrice_mk(:, length(matrice_pk)) = matrice_mk(:, length(matrice_pk) - 1);
    end;
    %et on s'occupe du vecteur ids_mk

    for i = 1:length(matrice_mk) %on procède comme pour les IDs des pk
        ids_mk(i) = impoint(gca, matrice_mk(1, i), matrice_mk(2, i));
        addNewPositionCallback(ids_mk(i), @update);
    end
end
end
