global DadosBarra DadosLinha...
       Nbus Nlinhas...
       Vi Tetai...
       Pd Pg Pi...
       De Para...
       LouD
   
Dados = fopen('Dados_Sistema.txt'); % Abre o arquivo para leitura

% --- INICIO DA MANIPULACAO DOS DADOS ---

% Eliminando as linhas desnecessarias do arquivo

for N = 1:3
    
    fgetl(Dados); 
    
end

Line = fgetl(Dados); % Le a primeira linha com os dados das barras

N = 1; % Contador

% Lendo e manipulando os dados das barras

while strcmp(Line(1:4), '####') == 0
    
    if strcmp(Line (34:35), 'SW') == 1
        
        Line (34:35) = '01'; % Seta a barra de referencia como 1
        NSW = N;             % Marca qual a barra de referência
        
    elseif strcmp(Line (34:35), 'PV') == 1
        
        Line (34:35) = '00'; % Seta demais barras como 0
    
    elseif strcmp(Line (34:35), 'PQ') == 1
        
        Line (34:35) = '00'; % Seta demais barras como 0
        
    end
    
    Line = str2num(Line);    % Transforma os strings em um vetor numerico
    DadosBarra(N,:) = Line;
    
    N = N + 1;               % Aumenta o contador em 1
    
    Line = fgetl(Dados);     % Le o dado da proxima barra para manipulacao
    
end

% Eliminando as linhas desnecessarias do arquivo

for N = 1:4
    
    fgetl(Dados);
    
end

% Le a primeira linha com os dados das linhas de transmissao

Line = fgetl(Dados);

N = 1; % Reiniciando o contador

while strcmp(Line(1:4), '####') == 0
    
    if strcmp(Line (79), 'L') == 1
        
        Line (79) = '1';    % Seta as linhas ligadas como 1
        
    else
        
        Line (79) = '0';    % Seta as linhas desligadas como 0
        
    end
    
    Line = str2num(Line);   % Transforma os strings em um vetor numerico
    DadosLinha(N,:) = Line; 
    
    N = N + 1;              % Aumenta o contador em 1
    
    Line = fgetl(Dados);    % Le o dado da proxima linha para manipulacao

end

fclose('all');

% ---------------------------------------------------------------------------------------

% --- DETERMINANDO VETORES DAS GRANDEZAS DAS BARRAS ---

[Nbus, ~] = size(DadosBarra);    % Determinando numero de barras
[Nlinhas, ~] = size(DadosLinha); % Determinando numero de linhas de transmissao

Vi = DadosBarra(:, 6);           % Vetor das magnitudes de tensoes nas barras
Tetai = DadosBarra(:, 7);        % Vetor dos angulos das tensoes nas barras
Pd = DadosBarra(:, 2);           % Vetor de potencia ativa consumida na barra
Pg = DadosBarra(:, 8);           % Vetor de potencia ativa gerada
Pi = Pg - Pd;                    % Vetor de potencia ativa liquida
Tipo = DadosBarra(:, 5);         % Vetor do tipo de barra
Perdas = zeros(Nbus, 1);         % Vetor de perdas nas linhas

% ---------------------------------------------------------------------------------------

% --- DETERMINANDO VETORES DAS GRANDEZAS DAS LINHAS ---

De = DadosLinha(:,1);                    % Vetor da posicao inicial da linha
Para = DadosLinha(:,2);                  % Vetor da posicao final da linha
Z = DadosLinha(:,4) + i*DadosLinha(:,5); % Vetor da impedancia de linha
X = DadosLinha(:,5);                     % Vetor da reatancia de linha
LouD = DadosLinha(:,9);                  % Vetor do estado (ligado ou desligado) de uma linha

% ---------------------------------------------------------------------------------------