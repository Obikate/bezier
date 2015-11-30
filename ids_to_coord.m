function[matrice_pk] = ids_to_coord(ids_pk)
    matrice_pk = 0;
    for i = 1:length(ids_pk)
        pos_i = getPosition(ids_pk(i));
        matrice_pk(1, i) = pos_i(1);
        matrice_pk(2, i) = pos_i(2);
    end;
