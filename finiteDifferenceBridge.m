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

G = zeros(W*L);
B = zeros(1,W*L);

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
            B(n) = 1;
        elseif(j==1)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif(j==W)
            G(n,:) = 0;
            G(n,n) = 1;
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

f1 = figure(1);
movegui(f1,'west')
surf(solution)
xlabel('X Position')
ylabel('Y Position')
zlabel('Electrostatic Potential (Units of V0)')
title('Finite Difference Solution for Case 2')
colormap cool
colorbar

a = W;
b = L/2;
x = linspace(-37,37,75);
y = linspace(0,50,75);
x = meshgrid(x);
y = transpose(meshgrid(y));

keepGoing = 1;

counter = 1;
sumSolution = zeros(75);
f2 = figure(2);
movegui(f2,'east')
while keepGoing == 1
    lastSum = sum(sum(sumSolution));
    temp = (4/pi).*(cosh((counter*pi.*x)./a)./(counter*cosh(counter*pi*b/a))).*sin(counter*pi*y/a);
    currentSum = sum(sum(sumSolution + temp));
    if(currentSum >= lastSum)
        sumSolution = sumSolution + temp;
    else
        keepGoing = 0;
    end
    surf(x,y,sumSolution)
    xlabel('X Position')
    ylabel('Y Position')
    zlabel('Electrostatic Potential (Units of V0)')
    title('Analytical Solution for Case 2')
    colormap cool
    colorbar   
    counter = counter + 2; 
    pause(0.01)
end