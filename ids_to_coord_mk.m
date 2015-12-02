function[matrice_mk] = ids_to_coord_mk(ids_pk, ids_mk)
    matrice_mk = 0;
    for i = 1:length(ids_pk)
        pos_pk = getPosition(ids_pk(i));
        pos_mk = getPosition(ids_mk(i));
        matrice_mk(1, i) = pos_mk(1) - pos_pk(1);
        matrice_mk(2, i) = pos_mk(2) - pos_pk(2);
    end;
