%{
ELEC 4700: Assignment 2
William Fraser
101001393
%}

%{
        L ? (i) 
     W   ___________________________
     ?  |1 8                        |
    (j) |2 ?                        |
        |3                          |
        |4                          |
        |5                          | 
        |6                          | 
        |7__________________________|
%}

W = 10;
L = 15;

G = zeros(W*L);
B = zeros(1,W*L);
%B(1:W) = 1;

for i = 1:L
    for j = 1:W
        n = j + (i-1)*W;
        if i==1
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = 1;
        elseif(i==L)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif(j==1)
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            %nym = j-1 + (i-1)*L;
            nyp = j + 1 + (i-1)*W;
            
            G(n,n) = 1;
            G(n,nxm) = 0;
            G(n,nxp) = 0;
            G(n,nyp) = -1;
            %G(n,nym) = 1;
        elseif(j==W)
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            nym = j-1 + (i-1)*W;
            %nyp = j + 1 + (i-1)*L;
            
            G(n,n) = 1;
            G(n,nxm) = 0;
            G(n,nxp) = 0;
            %G(n,nyp) = 1;
            G(n,nym) = -1; 
        else
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            nym = j-1 + (i-1)*W;
            nyp = j + 1 + (i-1)*W;
            
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nyp) = 1;
            G(n,nym) = 1; 
        end
    end
end

T = G\B';

solution = zeros(W,L);
row = 1;
column = 1;

for loop = 1:length(T)
    solution(row,column) = T(loop);
    if(row == W)
        row = 1;
        column = column + 1;
    else
        row = row + 1;
    end
end

surf(solution)
colormap cool
colorbar