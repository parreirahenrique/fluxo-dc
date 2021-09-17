% ---FUNCAO PARA O CALCULO DA POTENCIA ATIVA LIQUIDA---

% Variaveis de entrada:
% i: contador que indica o fluxo de potencia ativa sendo calculado

function [P] = CalculoPi(I)

global  Nbus Tetai Gbus Bbus

Gik = Gbus(I, 1:Nbus); % Matriz de condutancia do sistema
Bik = Bbus(I, 1:Nbus); % Matriz de susceptancia do sistema

P = 0;

for K = 1:Nbus
    
    P = P + ((1/2)*Gik(K)*((Tetai(I) - Tetai(K))^2) + Bik(K)*(Tetai(I) - Tetai(K)));
    
end