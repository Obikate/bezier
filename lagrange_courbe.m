function [x_lag] = lagrange_courbe( matrice_pk, x)
    matrice_tmp=matrice_pk;
    for j=1:(length(matrice_tmp)-1)
        for i=1:(length(matrice_tmp) -j)
            %formule de récurrence
            matrice_tmp(:,i)=((matrice_pk(1,i)-x)*matrice_tmp(:,i+1)+(x-matrice_pk(1,i+j))*matrice_tmp(:,i))/(matrice_pk(1,i)-matrice_pk(1,i+j));
        end;
    end;
    x_lag=matrice_tmp(:,1);
end
