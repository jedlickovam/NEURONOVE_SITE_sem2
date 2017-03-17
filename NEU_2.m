% Druh� semestr�ln� pr�ce z NEU
% Mark�ta Jedli�kov�

% Inicializace
clc;
clear all;

size = 10;
P = 3;

for i =1:P
    %nazev = [num2str(i-1),'_times']; % Protypy Times new roman
    nazev = num2str(i-1);             % Funguj�c� prototypy
    I  = imread(nazev,'jpg');         % nacteni ob�zk� a p�evod do cernob�le  
    P1 = im2bw(I);
    
    %figure(i);
    %imshow(P1);
    
    P1 = mat2vec(P1);                % p�evod na vektor
    P1 = double(P1);
      
    for n = 1:length(P1)             % pot�eba aby nebylo jen 1 a 0 ale 1 a -1 
        if P1(n) == 0;
            P1(n) = -1;
        end
    end
    
    up(:,i) = P1;                    % vytvo�en� prototyp�
    up = double(up);
    
    R1 = im2bw(I);                   % p�id�n� �umu k p�vodn�mu obrazu
    NoisePix = int32(0.3 * double(size) * double(size));
    locations = randi(size*size, [NoisePix, 1]);
    R1(locations) = 0;

    R1 = mat2vec(R1);
    R1 = double(R1);
    
    for n = 1:length(R1)             
        if R1(n) == 0;
            R1(n) = -1;
        end
    end
       
    ur(:,i) = R1;                    % hotov� za�um�nn� obrazy
    ur = double(ur);
end


%% Inicializace
vysl = 0;

% vahova matice
for k = 1:P
    vysl = vysl  + up(:,k)*up(:,k)';
end

w = vysl - P*eye(n);

%% Algoritmus
prototyp = 2;
y(:,1)  = ur(:,prototyp);

k= 1; 
output = up(:,prototyp);             % prototyp
output1 = ur(:,prototyp);            % zasumeny
while (~isequal( output,  output1))  % kontrola zda u� nejde o rovnov�n� stav
  output = y(:,k);
  for i = 1:size*size
    y(i,k+1) = sign(w(i,:)*y(:,k));   
  end
  y(y == 0) = 1; 
  output1 = y(:,k+1);
  k =k+1;
end

% Zobraz prvn� a posledn�
%for i = 1:k
    obr = vec2mat(y(:,1));
    figure(1);
    imshow(obr)
    
    obr = vec2mat(y(:,k));
    figure(k);
    imshow(obr)
%end
