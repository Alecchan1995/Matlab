ub = 600; 
lb = -600;
numWhale = 50; 
maxstep = 50; 
b = 1;
step = 1;
dim = 2; 
fitnesswhaleBest = 99999999; 
resultwhale = [];
whalespos = rand(numWhale, dim).*(ub-lb)+lb; 
for i=1:size(whalespos,1)
    count = 0;
    x1 = whalespos(i,1);
    x2 = whalespos(i,2);
    fitnesswhale = (((x1^2) + (x2^2))/4000) - (cos(x1)*cos((x2)/sqrt(2)))+1; 
    if fitnesswhale < fitnesswhaleBest
        fitnesswhaleBest = fitnesswhale;  
        BestSearchAgent = whalespos(i,:);
    end
end

for t=1:maxstep
    a = 2-(t-1)*((2)/maxstep);
    for i=1:size(whalespos,1)
        r1 = rand();
        r2 = rand();
        A = 2*a*r1-a;
        C = 2*r2;
        l = (a)*rand-1; 
        p = rand();
        if  p>=0.5
            distance2Leader = abs(BestSearchAgent-whalespos(i,:));
            whalespos(i,:) = distance2Leader*exp(b*l)*cos(2*pi*l)+BestSearchAgent;
        elseif p < 0.5
            if abs(A)>=1
                randomSearchAgentIndex = floor(numWhale*rand()+1);
                randomSearchAgent = whalespos(randomSearchAgentIndex,:);
                D_randomSearchAgent = abs((C*randomSearchAgent) - whalespos(i,:));
                whalespos(i,:) = randomSearchAgent - (A*D_randomSearchAgent);
            elseif abs(A)<1
                %--------Shrinking encircling mechanism---------
                D_BestSearchAgent = abs(C*BestSearchAgent - whalespos(i,:));
                whalespos(i,:) = BestSearchAgent - A*D_BestSearchAgent;
            end
        end    
    end
    for m=1:size(whalespos,1)
        x1 = whalespos(m,1);
        x2 = whalespos(m,2);
        fitnesswhale = (((x1^2) + (x2^2))/4000) - (cos(x1)*cos((x2)/sqrt(2)))+1; %fitnesswhale Function
        if fitnesswhale < fitnesswhaleBest
            fitnesswhaleBest = fitnesswhale;
            BestSearchAgent = whalespos(m,:);
        end
    end
    resultwhale(t) = fitnesswhaleBest;
    fprintf("Step : %d anwser : %f \n ",step,fitnesswhaleBest);
    step =step + 1;
end
nexttile
title('每代目標函數最小值')
plot(1:maxstep, resultwhale);
xlabel('Generation') 
ylabel('min  value') 