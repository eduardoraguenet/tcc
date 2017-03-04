%Entrada do Modelo PV
clc;
clear;
q = 1.6e-19;
k = 1.38e-23;
t = 0:.1:24;  %% Instantes de tempo do dia
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
lambda = exp(-2*(t-12).^2); %modeo gauss para radiacao
%Tamb = 10*exp((-1/8)*(t-12).^2) + 25; %Modelo Gauss temperatura ambiente
Vin = 0:.1:25; %Tensão de Entrada

Tamb = 25;
lambda = 1;

%%Temperatura da célula (TC)
Tc = Tamb + ((Tnoct-20)/0.8)*lambda; %%mudanca do artigo

Tc = Tc + 273; %Conversão para Kelvin
Tref = Tref + 273; %Conversão para Kelvin

Iph = (Isc + Ki.*(Tc-Tref)).*lambda;

Irs = Isc ./ (exp((q*Voc)./(Ns*k.*A.*Tc)) - 1);

Is = (Irs).*((Tc./Tref).^3).*exp((q.*Eg/(k*A)).*((1./Tref) - (1./Tc)));

I = Iph - (Is.*(exp(((q.*Vin)./(Ns.*k.*Tc.*A)))-1));

for j=1:size(I,2)
    I_corrigido(j) = fzero(@(X) -X + Iph - (Is.*(exp((q.*(Vin(j)+Rs*X)./(Ns.*k.*Tc.*A)))-1)) , 3);
    if I(j)<0
        I(j) = 0;
    end
    if I_corrigido(j)<0
        I_corrigido(j) = 0;
    end
end

plot(Vin,I);

title('Corrente em f(V)');
figure

plot(Vin,Vin.*I)
title('Potência')
%%Modelo da radiação solar - gaussiana média 12 dp = 0.5



%plot(t,exp(-2*(t-12).^2))

%%Modelo da temperatura - gaussiana média 12 dp = 2
%plot(t,10*exp((-1/8)*(t-12).^2) + 25)