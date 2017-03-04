clc;
clear;
%Entrada do Modelo PV
q = 1.6e-19;
k = 1.38e-23;
Eg = 1.11; %%Band gap Silicio
Voc = 21.1 ; %tensoa de circuito aberto
Isc = 3.8; %Corrente curto circuito
Ki = 3e-3; 
Ns = 36; %Numero de celulas em serie
Np = 1; %Numero de celulas em paralelo
Tref = 25; 
A = 1.3; %Dado da Tabela fator de adaptacao
Tnoct = 49; %tabela
Rs = 0.5;
Vin = 0:.1:25;