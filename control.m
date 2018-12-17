%% INFORME_2
%
%

%% Data-set, calculo del modelo inicial X_0 y su grafica 3D
clear all
clc
format long

Mrand=randi([-5,5],10,2);
vrand=randi([-3,3],10,1);
%M=input('Introduce la matriz de actualizaciones:   ')
%v=input('Introduce el vector de escala de clasificacion:   ')

Ma=[1 1; 2 3; 3 3], va=[2; 4; 6];
Mb=[-4 1; 3 -3; -2 2; 0 2; -4 3], vb=[-1; -5; -3; 5; -4];
Mc=[20 -12; 11 2; 3 5; 18 -19; 3 5; -20 -6; -16 -18; 15 0; -1 -13; 14 -15], vc=[3; 2; 2; 1; 7; 3; 6; 7; 5; 6];

M=Mb
v=vb

x_0=pinv(M)*v
v_0=M*x_0;

na=40; 

mx=M(:,1); my=M(:,2); mz=v;
f=@(ex,ey) ex.*x_0(1,:) + ey.*x_0(2,:);


%na=input('Ingrese el numero de actualizaciones: ')
y=[1:na+1];

Mact=[];
v_request=[2 2] 
%v_request=input('Ingrese el vector request: ')

v_rep=v_request;
%v_rep=input('Ingrese el vector representacion: ')


for i=1:na
    Mact(i,:)=v_request;
end


figure, ezmesh(f,[-10,10],10)
title('Grafica del modelo inicial')
colormap([0 0 1])
alpha(.4)
hold on
scatter3(mx,my,mz,'r','fill')
grid on

%% Sin actualizar Modelo 
modelos_sin_actualizar(:,1)=x_0;

for i=1:na
mm=[M;Mact(i,:)];
vv=[v;(Mact(i,:)*x_0)];
modelos_sin_actualizar(:,i+1)=pinv(mm)*vv;
end

L1=length(modelos_sin_actualizar);
deterioro_modelos_sin_actualizaro=abs(modelos_sin_actualizar(:,1))-abs(modelos_sin_actualizar(:,L1))

det_sin_act=[modelos_sin_actualizar(:,1)  modelos_sin_actualizar(:,L1)]


%% Modelo no acumulativo
modelos_NO_acumulativo(:,1)=x_0;

for i=1:na
mm=[M;Mact(i,:)];
vv=[v;(Mact(i,:)*modelos_NO_acumulativo(:,i))];
modelos_NO_acumulativo(:,i+1)=pinv(mm)*vv;
end

L1=length(modelos_NO_acumulativo);
deterioro_NO_acumulativo=abs(modelos_NO_acumulativo(:,1))-abs(modelos_NO_acumulativo(:,L1))

det_na=[modelos_NO_acumulativo(:,1)  modelos_NO_acumulativo(:,L1)]


%% Modelo acumulativo
mm=[M];
vv=[v];
modelos_acumulativo(:,1)=x_0;

for i=1:na 
mm=[mm;Mact(i,:)];
vv=[vv;(Mact(i,:)*modelos_acumulativo(:,i))];
modelos_acumulativo(:,i+1)=pinv(mm)*vv;
end

L2=length(modelos_acumulativo);
deterioro_acumulativo=abs(modelos_acumulativo(:,1))-abs(modelos_acumulativo(:,L2))
det_a=[modelos_acumulativo(:,1)  modelos_acumulativo(:,L1)]


%% Representacion grafica  

za=v_request*modelos_NO_acumulativo;
zna=v_request*modelos_acumulativo;
zsinact=v_request*modelos_sin_actualizar;

figure, subplot(1,2,1), plot(y,za,'r'), subplot(1,2,2), plot(y,zna,'b')
title(subplot(1,2,1), {'Variacion del modelo no'; 'acumulativo'})
xlabel(subplot(1,2,1),'i actualizaciones')
yy=ylabel(subplot(1,2,1),'Vrp*X_i', 'rot', 0)
set(yy, 'Units', 'Normalized', 'Position', [0.9, 1, 0]);
grid on

title(subplot(1,2,2), {'Variacion del modelo'; ' acumulativo'})
xlabel(subplot(1,2,2),'i actualizaciones')
yy=ylabel(subplot(1,2,2),'Vrp*X_i', 'rot', 0)
set(yy, 'Units', 'Normalized', 'Position', [1, 1, 0]);
grid on

figure, plot(y,zsinact)
title('Variacion de modelos sin actualizar')
xlabel('i actualizaciones')
yy=ylabel('Vrp*X_0', 'rot', 0)
set(yy, 'Units', 'Normalized', 'Position', [1, 1, 0]);
grid on


%% Perturbacion 
mm=[M];
vv=[v];
modelos_acumulativo_per(:,1)=x_0;


    
for i=1:na

      if i==na/4;
        Mact(i,:)=Mact(1,:);
        mm=[mm;(Mact(i,:))];
        vv=[vv; v(1)];
        modelos_acumulativo_per(:,i+1)=pinv(mm)*vv;

      elseif i==na/2;
       Mact(i,:)=Mact(1,:);
        mm=[mm;(Mact(i,:))];
        vv=[vv; v(1)];
        modelos_acumulativo_per(:,i+1)=pinv(mm)*vv;

      elseif i==na*(3/4);
        Mact(i,:)=Mact(1,:);
        mm=[mm;(Mact(i,:))];
        vv=[vv; v(1)];
        modelos_acumulativo_per(:,i+1)=pinv(mm)*vv;

      elseif i==na;
       Mact(i,:)=Mact(1,:);
        mm=[mm;(Mact(i,:))];
        vv=[vv; v(1)];
        modelos_acumulativo_per(:,i+1)=pinv(mm)*vv;

    end    

mm=[mm;(Mact(i,:))];
vv=[vv;(Mact(i,:)*modelos_acumulativo_per(:,i))];
modelos_acumulativo_per(:,i+1)=pinv(mm)*vv;
end


L2=length(modelos_acumulativo_per);
deterioro_perturbacion=abs(modelos_acumulativo_per(:,1))-abs(modelos_acumulativo_per(:,L2))

z=v_request*modelos_acumulativo_per;
figure, plot(y,z,'r')
title({'Variacion del modelo con introduccion';'de un valor del data-set'})
xlabel(' i actualizaciones')
yy=ylabel('Vrp*X_i', 'rot', 0)
set(yy, 'Units', 'Normalized', 'Position', [1, 1, 0]);
grid on

%% Modificacion del vector request
mm=[M];
vv=[v];


x1=fun(na);
x2=sin (y);
x3=5*y;
x4=log(y);




funciones=[x4; x3; x2; x1];

for j=1:4
    
    deterioro_modelos_acumulativo_mod=[];
    modelos_acumulativo_mod=[];
    modelos_acumulativo_mod(:,1)=x_0;
    x=[];
    x=funciones(j,:);
    x;
    
    for i=1:na            
    mm=[mm;(Mact(i,:)*x(i))];
    vv=[vv;(Mact(i,:)*(x(i))*modelos_acumulativo_mod(:,i))];
    modelos_acumulativo_mod(:,i+1)=pinv(mm)*vv;
    end


    L2=length(modelos_acumulativo_mod);
    deterioro_modelos_acumulativo_mod=abs(modelos_acumulativo_mod(:,1))-abs(modelos_acumulativo_mod(:,L2))
    modelos_acumulativo_mod(:,L2)
    
    z_mam=v_request*modelos_acumulativo_mod;

    figure, subplot(1,2,1), plot(y,z_mam,'r'), subplot(1,2,2), plot(y,x,'b')
    title(subplot(1,2,1), 'Variacion del modelo')
    xlabel(subplot(1,2,1),'i actualizaciones')
    yy=ylabel(subplot(1,2,1),'Vrp*X_i', 'rot', 0)
    set(yy, 'Units', 'Normalized', 'Position', [1, 1, 0]);
    grid on
    
    title(subplot(1,2,2), '  Funcion modificadora')
    xlabel(subplot(1,2,2),'i actualizaciones')
    yy=ylabel(subplot(1,2,2),'Vrp*X_i', 'rot', 0)
    set(yy, 'Units', 'Normalized', 'Position', [1, 1, 0]);
    grid on

end

