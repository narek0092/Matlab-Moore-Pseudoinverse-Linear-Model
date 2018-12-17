%% INFORME 3
%
%

function y=fun(na)

ancho=0.05*na;

recta1=(ones(1,na*0.4+1));
pico_positivo=na.*(ones(1,ancho));
pico_negativo=-na.*(ones(1,ancho));
recta2=(ones(1,na*0.1));
recta3=recta2;

long_recta4=(1:na*0.2);
recta4=50*long_recta4;

y=[recta1 pico_positivo pico_negativo recta2 pico_positivo pico_negativo recta3 recta4 ];

%length(x), length(y)
%plot(x,y);
%grid on
%axis([0 na*1.2 -na*1.2 na*11]);
