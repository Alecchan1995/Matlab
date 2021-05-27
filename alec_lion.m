manrun = 1000;
Bstrength = 20;
matage=3;
Bcount=0;
nowgen=0;
uX = 600;
uY = 600;
lX = -600;
lY = -600;
bestlion = [];
Mx = randi([0 1],1,48);
Fx = randi([0 1],1,48);
nowage=0;
while(nowgen<=manrun)
    newCubs={};
    male={};
    female={};
    location=[];
    Cublocation=[];
    newcross={}; %交配
    mutation={}; %突變
    for i=1:4%交配
       choose=randi([1,48]);
       monther=Mx(1:choose);
       father=Fx(1:choose);
       for j=choose+1:48
           monther(end+1)=Fx(j);
           father(end+1)=Mx(j);
       end
        mx2=bin2dec(num2str(monther(1:24)));     
        my2=bin2dec(num2str(monther(25:48)));   
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        mx=lX+mx2*coex;
        my=lY+my2*coey;
        monresult=(mx^2 + my^2)/4000 - cos(mx)*cos(my/sqrt(2))+1;
        fax2=bin2dec(num2str(father(1:24)));     
        fay2=bin2dec(num2str(father(25:48)));   
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        fax=lX+fax2*coex;
        fay=lY+fay2*coey;
        fatresult=(fax^2 + fay^2)/4000 - cos(fax)*cos(fay/sqrt(2))+1;
        if monresult <= fatresult
             newcross{i} = monther;
         else
             newcross{i} = father;
         end
    end
    for i=1:4%突變
         numberbitchangerd = randi([1,48]);
         whochoose=randi([1,4]);
         mutation{i} = newcross{whochoose};
         if mutation{i}(numberbitchangerd) == 1
            mutation{i}(numberbitchangerd) = 0;
         else
             mutation{i}(numberbitchangerd) = 1;
         end
    end
    newCubs=[newcross,mutation];
    bit2x = bin2dec(num2str(newCubs{1}(1:24)));
    bit2y = bin2dec(num2str(newCubs{1}(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    locatx = lX+bit2x*coex;
    locaty = lY+bit2y*coey;
    location = [locatx,locaty];
    for i=2:length(newCubs)
            bit2x = bin2dec(num2str(newCubs{i}(1:24)));
            bit2y = bin2dec(num2str(newCubs{i}(25:48)));
            coex=(uX-lX) / (2^24-1);
            coey=(uY-lY) / (2^24-1);
            locatx = lX+bit2x*coex;
            locaty = lY+bit2y*coey;
            nextlocat = [locatx,locaty];
        location = cat(1,nextlocat,location); %排列X,Y
    end
    [FMteam,C] = kmeans(location, 2);
    for i=1:length(newCubs)
            if(FMteam(i)==1)
                %male cubs
                male{end+1} = newCubs{i}; %女
            else
                %female cubs
                female{end+1} = newCubs{i}; %男
            end
    end
        if (length(female) ~= length(male))
             dist = abs(length(female) - length(male));
             if(length(female)>length(male));
         %       fprintf("Female Chnage\n");
                Femaleresutl=[];
                for i=1:length(female)
                    bit2x = bin2dec(num2str(female{i}(1:24)));
                    bit2y = bin2dec(num2str(female{i}(25:48)));
                    coex=(uX-lX) / (2^24-1);
                    coey=(uY-lY) / (2^24-1);
                    X = lX+bit2x*coex;
                    Y = lY+bit2y*coey;
                    Femaleresult(i)=(X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
                end
                for j=1:dist
                    [bag, badindex] = max(Femaleresult); 
                    Femaleresult(badindex) = [];
                    female(badindex) = [];
                end
             else
        %          fprintf("Male Chnage\n");
                   Maleresult=[];
                    for i=1:length(male)
                        bit2x = bin2dec(num2str(male{i}(1:24)));
                        bit2y = bin2dec(num2str(male{i}(25:48)));
                        coex=(uX-lX) / (2^24-1);
                        coey=(uY-lY) / (2^24-1);
                        X = lX+bit2x*coex;
                        Y = lY+bit2y*coey;
                        Maleresult(i)=(X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
                    end
                    for j=1:dist
                        [bag, badindex] = max(Maleresult); 
                        Maleresult(badindex) = [];
                        male(badindex) = [];
                    end
             end
        end
      
  %  fprintf("finish build the Cubs\n");
    fprintf("");
    nowage=0;
    flag = true;
    while(matage >= nowage)
      %  fprintf("build lion\n")
        otherlion = randi([0 1],1,48);
        bit2x = bin2dec(num2str(otherlion(1:24)));
        bit2y = bin2dec(num2str(otherlion(25:48)));
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        X = lX+bit2x*coex;
        Y = lY+bit2y*coey;
        olionpower = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
        bit2x = bin2dec(num2str(Mx(1:24)));
        bit2y = bin2dec(num2str(Mx(25:48)));
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        X = lX+bit2x*coex;
        Y = lY+bit2y*coey;
        Mxpower = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
        if (olionpower < Mxpower)
            malelength=length(male);
            perator=0;
            for i=1:malelength
                mx2=bin2dec(num2str(male{i}(1:24)));     
                my2=bin2dec(num2str(male{i}(25:48)));   
                coex=(uX-lX) / (2^24-1);
                coey=(uY-lY) / (2^24-1);
                mx=lX+mx2*coex;
                my=lY+my2*coey;
                maleresult=(mx^2 + my^2)/4000 - cos(mx)*cos(my/sqrt(2))+1;
                fax2=bin2dec(num2str(female{i}(1:24)));     
                fay2=bin2dec(num2str(female{i}(25:48)));   
                coex=(uX-lX) / (2^24-1);
                coey=(uY-lY) / (2^24-1);
                fax=lX+fax2*coex;
                fay=lY+fay2*coey;
                femaleresult=(fax^2 + fay^2)/4000 - cos(fax)*cos(fay/sqrt(2))+1;
                perator=perator+((maleresult+maleresult)/malelength);
            end
            Mx2=bin2dec(num2str(Mx(1:24)));     
            My2=bin2dec(num2str(Mx(25:48)));   
            coex=(uX-lX) / (2^24-1);
            coey=(uY-lY) / (2^24-1);
            mx=lX+Mx2*coex;
            my=lY+My2*coey;
            mxresult=(mx^2 + my^2)/4000 - cos(mx)*cos(my/sqrt(2))+1;
            Fx2=bin2dec(num2str(Mx(1:24)));     
            Fy2=bin2dec(num2str(Mx(25:48)));   
            coex=(uX-lX) / (2^24-1);
            coey=(uY-lY) / (2^24-1);
            fx=lX+Fx2*coex;
            fy=lY+Fy2*coey;
            fxresult=(fx^2 + fy^2)/4000 - cos(fx)*cos(fy/sqrt(2))+1;
            pridev = (1/2*(1+malelength))*(mxresult+fxresult+(matage/nowage+1)*perator);
            if (olionpower < pridev)
                male={};
                female={};
                Mx = otherlion;
                flag = false;
                break
            end
        else
            nowage=nowage+1;
        end
    end
    if (~flag)
        continue
    end
   % fprintf("3333333333333\n")
    bit2x = bin2dec(num2str(Mx(1:24)));
    bit2y = bin2dec(num2str(Mx(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    X = lX+bit2x*coex;
    Y = lY+bit2y*coey;
    Mxpower = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    bit2x = bin2dec(num2str(Fx(1:24)));
    bit2y = bin2dec(num2str(Fx(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    X = lX+bit2x*coex;
    Y = lY+bit2y*coey;
    Fxpower = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    maleFit=[];
    femaleFit=[];
    for k=1:length(male) %count male cubs fitness
       bit2x = bin2dec(num2str(male{k}(1:24)));
        bit2y = bin2dec(num2str(male{k}(25:48)));
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        X = lX+bit2x*coex;
        Y = lY+bit2y*coey;
        maleFit(end+1) = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    end
    for k=1:length(female)
         bit2x = bin2dec(num2str(female{k}(1:24)));
        bit2y = bin2dec(num2str(female{k}(25:48)));
        coex=(uX-lX) / (2^24-1);
        coey=(uY-lY) / (2^24-1);
        X = lX+bit2x*coex;
        Y = lY+bit2y*coey;
        femaleFit(end+1) = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    end
    [bestMale, bestMaleindex] = min(maleFit); 
    [bestFemale, bestFemaleindex] = min(femaleFit);  
    if(bestMale < Mxpower)
     %bestMaleCubs win!!
        Xm = male{bestMaleindex};
    end
    if(bestFemale < Fxpower)
    %bestFemaleCubs win!!
        Xf = female{bestFemaleindex};
        Bcount = 0;
    else
        %bestFemaleCubs lose.
        Bcount = Bcount + 1;
    end
    bit2x = bin2dec(num2str(Fx(1:24)));
    bit2y = bin2dec(num2str(Fx(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    X = lX+bit2x*coex;
    Y = lY+bit2y*coey;
    FxFit = (X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    if(Bcount>Bstrength)
        newFemaleLionFitness = 9999999999;
        count = 0;
        while(newFemaleLionFitness >= FxFit)
         %   disp("find new Female\n");
            newFemaleLion = randi([0 1],1,48);
            bit2x = bin2dec(num2str(newFemaleLion(1:24)));
            bit2y = bin2dec(num2str(newFemaleLion(25:48)));
            coex=(uX-lX) / (2^24-1);
            coey=(uY-lY) / (2^24-1);
            X = lX+bit2x*coex;
            Y = lY+bit2y*coey;
            NFV=(X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
            fprintf("nowGen:%d,count:%d, new:%f, old:%f \n",nowgen,count,newFemaleLionFitness,FxFit);
            count = count+1;
            if(count > 1000)
                newFemaleLion = Fx;
                break
            end
        end
        Fx = newFemaleLion;
    end
    nowgen=nowgen+1;
   % fprintf("nowgen : %d\n",nowgen)
    bit2x = bin2dec(num2str(Mx(1:24)));
    bit2y = bin2dec(num2str(Mx(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    X = lX+bit2x*coex;
    Y = lY+bit2y*coey;
    Mxpower=(X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    bit2x = bin2dec(num2str(Fx(1:24)));
    bit2y = bin2dec(num2str(Fx(25:48)));
    coex=(uX-lX) / (2^24-1);
    coey=(uY-lY) / (2^24-1);
    X = lX+bit2x*coex;
    Y = lY+bit2y*coey;
    Fxpower=(X^2 + Y^2)/4000 - cos(X)*cos(Y/sqrt(2))+1;
    if(Mxpower<Fxpower)
        %Xm win
        BestLionFitness = Mxpower; 
    else
        %Xf win
        BestLionFitness = Fxpower;
    end
    bestlion(nowgen) = BestLionFitness;
    fprintf("nowGen:%d,count:%d, new:%f \n",nowgen,count,BestLionFitness);
end
nexttile
title('每代染色體Fitness最大值')
plot(1:manrun, bestlion(1:manrun));
xlabel('Generation') 
ylabel('Min Objection Function Value') 