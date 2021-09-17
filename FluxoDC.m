% Fluxo DC com perdas
% Disciplina: Planejamento e Operação de Sistemas de Potência
% Professor: Leonidas Chaves
% Aluno: Henrique Parreira Castro
% Matricula: 150950052

global DadosLinha DadosBarra...
       Ybus Gbus Bbus...
       Nbus Nlinhas...
       Vi Tetai...
       Pd Pg Pi Pik Pki...
       De Para...
       LouD Tol

clear all, clc;

% --- LEITURA DOS DADOS ---

LeituraDados;

Tol = 0.0001; % Tolerancia do erro

% -------------------------------------------------------------------------------------------------

% --- MONTAGEM DA MATRIZ YBUS ---

MontarYbus;

% -------------------------------------------------------------------------------------------------

% --- INICIO DAS ITERACOES PARA DETERMINACAO DO VETOR DOS ANGULOS ---

Tetai = -InvB*(Pi - Perdas); % Valor inicial do vetor angulo de barra

Converg = 'Diverge';            % Somatorio da potencia das barras
NIteracoes = 1;              % Contador do numero de iteracoes

while strcmp(Converg, 'Diverge') == 1 && NIteracoes <= 100

    Tetai = -InvB*(Pi - Perdas); % Valor inicial do vetor angulo de barra
    Perdas = zeros(Nbus, 1);     % Vetor de perdas nas linhas
    
    % Calculo das perdas
    for N1 = 1:Nbus
        
        for N2 = 1:Nbus
            
            Perdas(N1) = Perdas(N1) - (1/2)*Gbus(N1,N2)*((Tetai(N1) - Tetai(N2))^2); % Soma a perda da linha que liga as barras i e k
            
        end
        
    end
    
    SomaP = Pi - Perdas + Bbus*Tetai;   % Somatorio de todas as potencias da barra
    
    Converg = Convergencia(SomaP, Tol); % Testa a convergencia para a tolerancia desejada
    
    NIteracoes = NIteracoes + 1;

end

% -------------------------------------------------------------------------------------------------

% --- CALCULO DAS POTENCIAS LIQUIDAS EM CADA BARRA ---

% Calculo das potencias liquidas de cada barra

Bbus(NSW,NSW) = BSW;

Pi = -Bbus*Tetai + Perdas % Potencia liquida injetada na barra

Pg = Pi + Pd;             % Potencia gerada na barra

% -------------------------------------------------------------------------------------------------

% --- CALCULO DO FLUXO DE POTENCIA NAS LINHAS ---

for N = 1:Nlinhas
    
    Pik(N) = Bbus(De(N), Para(N))*(Tetai(De(N)) - Tetai(Para(N)));               % Fluxo de potencia ativa da barra i para k
    
    Pki(N) = Bbus(Para(N), De(N))*(Tetai(Para(N)) - Tetai(De(N)));               % Fluxo de potencia ativa da barra k para i
    
    Perdasik(N) = abs(Gbus(Para(N), De(N))*((Tetai(Para(N)) - Tetai(De(N)))^2)); % Perdas ativas na linha de transmissao da barra i para k
    
end

% -------------------------------------------------------------------------------------------------

% --- ESCRITA DOS RESULTADOS NO ARQUIVO DE SAIDA ---

MostrarResultados;

fprintf('Os dados de saída se encontram no arquivo "Dados_Saida.txt".\n\n')

% -------------------------------------------------------------------------------------------------