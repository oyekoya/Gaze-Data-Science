function blink_log(file1)
%[C1,C2,C3,C4] = textread(file1,'%s%s%s%s', 'delimiter','\t');
fid = fopen(file1);
X = textscan(fid,'%s', 'delimiter','\n');
C = X{1,1};

timestamp = zeros(1,15);
count = 1;
for x=1:size(C,1)
    if (isempty(strfind(char(C(x)),'START BLINK')) == 0)
        [col1 D1] = strtok(C(x),';');
        timestamp(count,1) = str2double(char(col1));
    end;
    if (isempty(strfind(char(C(x)),'2000000;MV1;')) == 0)
        [col1 D1] = strtok(C(x),';');
        [col2 D1] = strtok(D1,';');
        [col3 D1] = strtok(D1,';');
        timestamp(count,5) = str2double(char(col3));
        [col4 D1] = strtok(D1,';');
        [col5 D1] = strtok(D1,';');
        timestamp(count,6) = str2double(char(col5));
        [col6 D1] = strtok(D1,';');
        [col7 D1] = strtok(D1,';');
        timestamp(count,7) = str2double(char(col7));
        [col8 D1] = strtok(D1,';');
        [col9 D1] = strtok(D1,';');
        timestamp(count,8) = str2double(char(col9));
        [col10 D1] = strtok(D1,';');
        [col11 D1] = strtok(D1,';');
        timestamp(count,9) = str2double(char(col11));
        [col12 D1] = strtok(D1,';');
        [col13 D1] = strtok(D1,';');
        timestamp(count,10) = str2double(char(col13));
        [col14 D1] = strtok(D1,';');
        [col15 D1] = strtok(D1,';');
        timestamp(count,11) = str2double(char(col15));
        [col16 D1] = strtok(D1,';');
        [col17 D1] = strtok(D1,';');
        timestamp(count,12) = str2double(char(col17));
        [col18 D1] = strtok(D1,';');
        [col19 D1] = strtok(D1,';');
        timestamp(count,13) = str2double(char(col19));
        [col20 D1] = strtok(D1,';');
        [col21 D1] = strtok(D1,';');
        timestamp(count,14) = str2double(char(col21));
        [col22 D1] = strtok(D1,';');
        [col23 D1] = strtok(D1,';');       
        timestamp(count,15) = str2double(char(col23));
    end;
    if (isempty(strfind(char(C(x)),';Done Down;')) == 0)
        [col1 D1] = strtok(C(x),';');
        timestamp(count,2) = str2double(char(col1));
    end;
    if (isempty(strfind(char(C(x)),';up;1')) == 0)
        [col1 D1] = strtok(C(x),';');
        timestamp(count,3) = str2double(char(col1));
    end;
    if (isempty(strfind(char(C(x)),';FINISH BLINK;')) == 0)
        [col1 D1] = strtok(C(x),';');
        timestamp(count,4) = str2double(char(col1));
        count = count + 1;
    end;
end;
timestamp