global Ybus Gbus Bbus...
       Nbus Nlinhas...
       De Para...
       LouD

Ybus = zeros(Nbus); % Matriz de admitancia de barra
Gbus = zeros(Nbus); % Matriz de condutancia de barra
Bbus = zeros(Nbus); % Matriz de susceptancia de barra

% --- MONTAGEM DA YBUS ---

for L = 1:Nlinhas
        
    if LouD(L) == 1 % Apenas altera os valores da Ybus para as linhas que estao ligadas
        
        Ybus(De(L), Para(L)) = -(1/(Z(L)));                       % Termo Yik da matriz Ybus
        Ybus(Para(L), De(L)) = -(1/(Z(L)));                       % Termo Yki da matriz Ybus
        Ybus(De(L), De(L)) = Ybus(De(L), De(L)) + 1/Z(L);         % Termo Yii da matriz Ybus
        Ybus(Para(L), Para(L)) = Ybus(Para(L), Para(L)) + 1/Z(L); % Termo Ykk da matriz Ybus
        
        Bbus(De(L), Para(L)) = 1/X(L);                            % Termo Yik da matriz Ybus
        Bbus(Para(L), De(L)) = 1/X(L);                            % Termo Yki da matriz Ybus
        Bbus(De(L), De(L)) = Bbus(De(L), De(L)) - 1/X(L);         % Termo Yii da matriz Ybus
        Bbus(Para(L), Para(L)) = Bbus(Para(L), Para(L)) - 1/X(L); % Termo Ykk da matriz Ybus
        
    end
    
end

Gbus = real(Ybus);        % Matriz de condutancia sem os valores da barra de referencia
BSW = Bbus(NSW,NSW);      % Aloca o valor da susceptancia da barra de referencia
Bbus(NSW, NSW) = realmax; % Coloca um valor muito alto para Bkk da barra de referencia
InvB = inv(Bbus);         % Inversa da matriz Bbus