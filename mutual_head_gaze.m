function getdata = get_mutual_headgaze(file1, file2, file3, file4)

fid = fopen(file1);
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24] = textread(file1,'%n%f%f%f%f%f%f%n%n%n%n%f%s%s%s%s%f%f%f%f%f%f%f%f', 'delimiter',';');
%C = textscan(fid,'%n%f%f%f%f%f%f%s%s%s%s', 'delimiter',';');
fclose(fid);
% C1 = C{1};   %time difference btw eye targets
% C2 = C{2};   %distance btw eye and its target - guide max 10
% C3 = C{3};   %angular distance of eye target from head gaze - guide max 100 deg
% C4 = C{4};   %angular velocity btw eye targets (or magnitude) - guide max 100 deg/s
% C5 = C{5};   %x-distance - guide min -10 to max 10
% C6 = C{6};   %y-distance
% C7 = C{7};   %z-distance
% C8 = C{8};  % AB - set to 1 if A is looking at B's left/right eyes
% C9 = C{9};  % BA
% C10 = C{10}; % AC
% C11 = C{11}; % CA
% C12 = C{12};  % difference between last and current head orientation
% C13 = C{13};  %gaze target (hit node)
% C14 = C{14};  %random target (hit node)
% C15 = C{15}; %head target (hit node)
% C16 = C{16}; %node grabbed
clear C;

%int32(ceil([max(C1) max(C2) max(C3) max(C4) max(C5) max(C6) max(C7) max(C12)]))

fid = fopen(file2,'a+');%'output.log'
% check for mutual gaze info
for a=1:size(C8)
    if ((C8(a)==1) && (C9(a)==1)) % detected AB mutual gaze
        if ((C8(a-1)==1) && (C9(a-1)==1))
            continue;
        end;
        AB = 0; n = a - 1;
        while (C8(n)==1)
            AB = AB + C1(n);
            n = n - 1;
        end;
        BA = 0; n = a - 1;
        while (C9(n)==1)
            BA = BA + C1(n);
            n = n - 1;
        end;
        AB_BA = C1(a); n = a + 1;
        while ((C8(n)==1) && (C9(n)==1))
            AB_BA = AB_BA + C1(n);
            n = n + 1;
        end;
        fprintf(fid,'AB;%s;%s;%s\n',int2str(AB),int2str(BA),int2str(AB_BA));
    end;
    if ((C10(a)==1) && (C11(a)==1)) % detected AC mutual gaze
        if ((C10(a-1)==1) && (C11(a-1)==1))
            continue;
        end;
        AC = 0; n = a - 1;
        while (C10(n)==1)
            AC = AC + C1(n);
            n = n - 1;
        end;
        CA = 0; n = a - 1;
        while (C11(n)==1)
            CA = CA + C1(n);
            n = n - 1;
        end;
        AC_CA = C1(a); n = a + 1;
        while ((C10(n)==1) && (C11(n)==1))
            AC_CA = AC_CA + C1(n);
            n = n + 1;
        end;
        fprintf(file2,'AC;%s;%s;%s\n',int2str(AC),int2str(CA),int2str(AC_CA));
    end;
end;
fclose(file2);

if (isempty(strfind(file1,'v2')) == 0)
    return; 
end;

count = 0;
file3 = fopen(file3,'w');%'output.log'
%check if head gaze = eye gaze 
for a=1:size(C13)
    if ((strcmp(C13(a),C15(a))==1) && (strcmp(C16(a),'NULL')~=1)) 
        if ((a~=1) & (strcmp(C13(a-1),C15(a-1))==1) & (strcmp(C13(a-1),C13(a))==1)) continue; end;
        n = a;
        while (strcmp(C13(n),C15(n))==1) 
            count = count + C1(n);
            n = n + 1; 
            if (n>size(C13)) n=n-1; break; end;
        end;
        fprintf(file3,'%s;',mat2str(cell2mat(C13(a))));
        fprintf(file3,'%s\n',int2str(count));
        count = 0;
    end;
end;
fclose(file3);

count = 0;
file4 = fopen(file4,'w');%'output.log'
%check if eye gaze = grabbed/moving object 
for a=1:size(C13)
    if ((strcmp(C13(a),C16(a))==1) && (strcmp(C16(a),'NULL')~=1))
        if ((a~=1) & (strcmp(C13(a-1),C16(a-1))==1) & (strcmp(C13(a-1),C13(a))==1)) continue; end;
        n = a;
        while (strcmp(C13(n),C16(n))==1)
            count = count + C1(n);
            n = n + 1; 
            if (n>size(C13)) n=n-1; break; end;
        end;
        fprintf(file4,'%s;',mat2str(cell2mat(C16(a))));
        fprintf(file4,'%s\n',int2str(count));
        count = 0;
    end;
end;
fclose(file4);