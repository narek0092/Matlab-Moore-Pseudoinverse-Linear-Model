%% INFORME_1
%

%% Grafica de Solucion real y Solucion con Pseudoinversa de Penrose
clear,clc

A=randi([-5,5],10,2)
R=randi([-3,3],10,1)
B=pinv(A)*R

R_Penrose=A*B

x=A(:,1), y=A(:,2), z=R;

f=@(x,y) x.*B(1,:) + y.*B(2,:);
ezmesh(f,[-10,10],10)
colormap([0 0 1])
alpha(.4)
hold on

scatter3(x,y,z,'r','fill')
grid on
