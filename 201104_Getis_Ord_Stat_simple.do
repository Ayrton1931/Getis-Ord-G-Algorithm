

*********************************
********************************* Estadistico Getis Ord
*********************************

**** Call variables

mata: Y = st_matrix("Y")
mata: W = st_matrix("V")
mata: N = rows(W)
mata: v1 = J(N,1,1)
**** Replace matrix's diagonal from 0's to 1's
mata: W_1=W

mata
for(i=1; i<=N; i++){
W_1[i,i] = 1
}
end

mata: W = W_1
mata: mata drop W_1
****
mata: Q1 = (v1'*Y)*(1/N)
mata: Y_2 = Y
****
mata
for(i=1; i<=N; i++){
Y_2[i] = Y[i]^2 
}
end
****
mata: Q2s = (v1'*Y_2)*(1/N) 
mata: Q2  = Q2s - (Q1)^2
mata: G_divisor = v1'*Y
****
mata: Resultados = J(N,5,0)
mata
for(i=1; i<=N; i++){
Y_l = W[i,]*Y
ww = W[i,]*v1 
G = Y_l/G_divisor
E = ww/N
Var = ww*(N-ww)*Q2/((N^2)*(N-1)*(Q1^2))
std = Var^(1/2)  
z = (G - E)/std
G_z =  (Y_l - ww*Q1)/( Q2^(1/2) * ((N*ww - ww^2 )/(N-1))^(1/2)  )  
Resultados[i,1] = G
Resultados[i,2] = E
Resultados[i,3] = std
Resultados[i,4] = z
Resultados[i,5]	= G_z
}
end

mata: mata drop Y W Y_2 Y_l G E std Var G_divisor G_z Q1 Q2 Q2s
mata: st_matrix("Resultados"	, Resultados)
mat colnames Resultados = stat E std z G_z

 


