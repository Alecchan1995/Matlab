extext = input("in :","s");
start = 0 ;
s = 0;
addset = 0;
setset = 0;
res = "";
for i=1:length(extext)
    fprintf("i = %d text = %c\n",i,extext(i));
    if addset == 1
        setset = setset + 1;
        if setset <= 2
            continue;
        else
            addset = 0;
            setset = 0;
        end
    end
    if i > (length(extext) - 3) & start == 0
        break;
    end
    if "A" == extext(i)
        fprintf("1\n");
        if "T" == extext(i+1)
            fprintf("2\n");
            if "G" == extext(i+2)
                fprintf("3\n");
                start = 1;
                addset = 1;
                continue;
            end
        end
    end
    if "T" == extext(i)
        fprintf("4\n");
        if "A" == extext(i+1)
            fprintf("5\n");
            if "G" == extext(i+2) | "A" == extext(i+2)
                fprintf("6\n");
                start = 0 ; 
                addset = 1;
                if mod(length(res),3) == 0
                    fprintf("%s\n",res);
                    res = "";
                    s=0;
                else
                    res = "";
                    s=0;
                end
            end
        elseif "G" == extext(i+1)
            fprintf("7\n");
            if "A" == extext(i+2)
                fprintf("8\n");
                start = 0;
                addset = 1;
                if mod(length(res),3) == 0
                    fprintf("%s\n",res);
                    res = "";
                    s=0;
                else
                    res = "";
                    s=0;
                end
            end   
        end
    end
    if start == 1
        fprintf("9 extext = %s s=%d i=%d res=%s\n",extext(i),s,i,res);
        s = s+1;
        res(s) = extext(i);
        fprintf("res(%d) = %s \n",s,res);
    end
    
end