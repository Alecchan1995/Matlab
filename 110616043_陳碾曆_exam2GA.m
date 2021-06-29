marge = {};
result = [];
age = 1;
total=1000;
remin =[];
rex=[];
rey=[];
redata=[];
for i=1:total
    marge{i}=randi([0 1],1,26);  
    x=bin2dec(num2str(marge{i}(1:13)));
    y=bin2dec(num2str(marge{i}(14:26)));
    x = round(-1.5 + x * 5500 / 8191 /1000, 3); 
    y = round(-3.0 + y * 6000 / 8191 /1000, 3);
    result(i)=(sin(x+y)+(x-y)^2-1.5*x+2.5*y+1);     
end
[remine,xyindex]=sort(result);
fprintf("x = %d , y = %d , mine = %d\n",bin2dec(num2str(marge{xyindex(1)}(1:13))),bin2dec(num2str(marge{xyindex(1)}(14:26))),remine(1));
remin(1)=min(result,[],2);
resultsum=result+min(result);
repi=resultsum/sum(resultsum);
repi2=repi; %eval postition round
for step=2:1000
    redataresult={} ; %直面要最小的4個值
    [redata,index]=sort(result);
    for i=1:400
        redataresult{i}=marge{index(i)};
    end
    for i=1:400 %放入index1-4
        marge{i}=redataresult{i};
    end
    newdata={}; %chechk data
    repost=[]; %交配的記 index4-8 用剛剛1-4
    index=401;
    newmatchdata={};
    for i=1:400 %index
        peoplechoose=randi([1,400]); %跟誰換
        bitchange=randi([1,26]); %bit 的交換
        repost(i)=peoplechoose; % 那一位配
    %    fprintf("2peoplechoose: %d bitchange %d\n",peoplechoose,bitchange);
        monther=marge{i}(1:bitchange);
        father=marge{peoplechoose}(1:bitchange);
        for j=bitchange+1:26
            monther(end+1)=marge{peoplechoose}(j);
            father(end+1)=marge{i}(j);
        end
         mx=bin2dec(num2str(monther(1:13)));     
         my=bin2dec(num2str(monther(14:26)));    
         mx = round(-1.5 + mx * 5500 / 8191 /1000, 3); 
         my = round(-3.0 + my * 6000 / 8191 /1000, 3);
         monresult=(sin(mx+my)+(mx-my)^2-1.5*mx+2.5*my+1);
         fx=bin2dec(num2str(father(1:13)));     
         fy=bin2dec(num2str(father(14:26)));        
         fx = round(-1.5 + x * 5500 / 8191 /1000, 3);
         fy = round(-3.0 + y * 6000 / 8191 /1000, 3);
         faresult=(sin(fx+fy)+(fx-fy)^2-1.5*fx+2.5*fy+1);
         if monresult <= faresult
             newmatchdata{index} = monther;
         else
             newmatchdata{index} = father;
         end
         index=index+1;
    end
    for i=401:800
        marge{i}=newmatchdata{i};
    end
    for i=801:1000
        numberbitchangerd = randi([1,26]); %change the bits 突變
       %changetrue = randi([1,10]); % change True
        numberwhochange = randi([1,800]); %change postition
      %  fprintf("3people %d numberbitchangerd %d\n",numberwhochange,numberbitchangerd);
         marge{i} =  marge{numberwhochange};
        if  marge{i}(numberbitchangerd) == 0
            marge{i}(numberbitchangerd) = 1;
        else
            marge{i}(numberbitchangerd) =0;
        end
    end
    for i=1:total
        x=bin2dec(num2str(marge{i}(1:13)));     
        y=bin2dec(num2str(marge{i}(14:26)));        
        %x = round(-1.5 + x * ((4.0-(-1.5)) /2^13-1), 3);
        %y = round(-3.0 + y * ((3.0-(-3.0))/2^13-1), 3);
        x = round(-1.5 + x * 5500 / 8191 /1000, 3); 
        y = round(-3.0 + y * 6000 / 8191 /1000, 3);
        result(i)=(sin(x+y)+(x-y)^2-1.5*x+2.5*y+1);     
    end
    [remine,xyindex]=sort(result);
    fprintf("x = %d , y = %d , mine = %d\n",bin2dec(num2str(marge{xyindex(1)}(1:13))),bin2dec(num2str(marge{xyindex(1)}(14:26))),remine(1));
    remin(step)=min(result,[],2);
    resultsum=result+min(result);
    repi=resultsum/sum(resultsum);
    repi2=repi;
    
end
 plot(remin);
 a=[1,2,3,4,5];
 plot(a);