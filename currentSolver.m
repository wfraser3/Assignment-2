%{
ELEC 4700: Assignment 2
William Fraser
101001393
%}

%{
        L - (i) 
     W   ___________________________
     |  |1 8                        |
    (j) |2 ?                        |
        |3                          |
        |4                          |
        |5                          | 
        |6                          | 
        |7__________________________|
%}

W = 50;
L = 75;

cmap = ones(W,L);
contactsCond = 10^(-2);
cmap(1:21,31:45) = contactsCond;
cmap(30:50,31:45) = contactsCond;
figure(1)
imagesc(cmap)
colorbar
colormap cool

G = zeros(W*L);
B = zeros(1,W*L);
%B(1:W) = 1;

for i = 1:L
    for j = 1:W
        n = j + (i-1)*W;
        if(i==1)
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = 1;
        elseif(i==L)
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = 1;
        elseif(j==1)
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            %nym = j-1 + (i-1)*L;
            nyp = j + 1 + (i-1)*W;
            
            resXM = (cmap(j,i)+cmap(j,i-1))/2;
            resXP = (cmap(j,i)+cmap(j,i+1))/2;
            resYP = (cmap(j,i)+cmap(j+1,i))/2;
            
            G(n,n) = -(resXM+resXP+resYP);
            G(n,nxm) = resXM;
            G(n,nxp) = resXP;
            G(n,nyp) = resYP;
            %G(n,nym) = 1;
        elseif(j==W)
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            nym = j-1 + (i-1)*W;
            %nyp = j + 1 + (i-1)*L;
            
            resXM = (cmap(j,i)+cmap(j,i-1))/2;
            resXP = (cmap(j,i)+cmap(j,i+1))/2;
            resYM = (cmap(j,i)+cmap(j-1,i))/2;
            
            G(n,n) = -(resXM+resXP+resYM);
            G(n,nxm) = resXM;
            G(n,nxp) = resXP;
            %G(n,nyp) = 1;
            G(n,nym) = resYM; 
        else
            nxm = j + (i-2)*W;
            nxp = j + i*W;
            nym = j-1 + (i-1)*W;
            nyp = j + 1 + (i-1)*W;
            
            resXM = (cmap(j,i)+cmap(j,i-1))/2;
            resXP = (cmap(j,i)+cmap(j,i+1))/2;
            resYM = (cmap(j,i)+cmap(j-1,i))/2;
            resYP = (cmap(j,i)+cmap(j+1,i))/2;
            
            G(n,n) = -(resXM+resXP+resYM+resYP);
            G(n,nxm) = resXM;
            G(n,nxp) = resXP;
            G(n,nyp) = resYM;
            G(n,nym) = resYP; 
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

figure(2)
surf(solution)
colormap cool
colorbar