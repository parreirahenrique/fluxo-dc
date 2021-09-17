% ---FUNCAO PARA VERIFICAR SE O ERRO ESTA DENTRO DO TOLERADO---

function [C] = Convergencia(SomaP, Tol) % Tem como valores de entrada o valor do somatorio das potencia da barra e a tolerancia

global Nbus

for N = 1:(Nbus - 1)
    
    if abs(SomaP(N)) < Tol
        
        C = 'Converge'; % Converge quando o valor absoluto está abaixo da tolerancia
        
    else
        
        C = 'Diverge'; % Diverge quando o valor é igual ou esta acima da tolerancia
        break          % Interrrompe a funcao neste ponto
    
    end
    
end
