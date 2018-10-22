function [x,y,z] = match_equality(file1,file2)

fid = fopen(file1);%'sfd_client_spec_modified_05c_2.log'
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24] = textread(file1,'%n%c%s%s%f%f%f%f%f%f%f%d%s%s%s%s%s%f%f%f%f%f%f%f', 'delimiter',';');
%C = textscan(fid,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fclose(fid);
% C1 = C{1};   %wallclocktime
% C2 = C{2};   %index char M(index character to denote node repositioning), C(obj loading), A(Attach), D(Detach)
% C3 = C{3};   %Node ID
% C4 = C{4};   %left/right
% C5 = C{5};   %up/down
% C6 = C{6};   %in/out
% C7 = C{7};   %pitch
% C8 = C{8};   %heading
% C9 = C{9};   %roll
% C10 = C{10}; %rotation angle
% C11 = C{11}; %scaling
% C12 = C{12}; %blinking state
% C13 = C{13}; %model target (hit node)
% C14 = C{14}; %tracked-gaze target (hit node)
% C15 = C{15}; %random target (hit node)
% C16 = C{16}; %static/head target (hit node)
% C17 = C{17}; %node grabbed
% C18 = C{18}; %H - horizontal gaze point
% C19 = C{19}; %V - vertical gaze point
% C20 = C{20}; %P - pupil diameter
% C21 = C{21}; %P - mv0
% C22 = C{22}; %P - mv1
% C23 = C{23}; %P - mv2
% C24 = C{24}; %P - mv3
clear C;

fid = fopen(file2);
[D1] = textread(file2,'%s', 'delimiter','\n');
fclose(fid);

count = 0;
head_eye_count = 0;
model_eye_count = 0;
random_eye_count = 0;
x1 = 0;
x2 = 0;
x3 = 0;
for a=2:size(C13)
    if((strcmp(C14(a),'NULL')==1)|(isempty(char(C14(a)))==1))%%if tracked is NULL target or empty
        continue;
    end;
    timedif = C1(a)-C1(a-1);
    %check if tracked gaze target = static/head target
    if ((strcmp(C14(a),C16(a))==1)&& ...
            ((strcmp(C14(a-1),C16(a-1))==1)) && ... 
            ((strcmp(C14(a),C14(a-1))==1))) 
        x3=x3+timedif;
    else
        if (x3<1500)
            head_eye_count = head_eye_count + x3; 
            x3=0; 
        end;
    end;
    %check if tracked-gaze target = model target
    if (((strcmp(C14(a),C13(a))==1)|(checkdb(D1,char(C14(a)),char(C13(a)))==1)) && ...
            ((strcmp(C14(a-1),C13(a-1))==1)|(checkdb(D1,char(C14(a-1)),char(C13(a-1)))==1)) && ... 
            ((strcmp(C14(a),C14(a-1))==1)|(checkdb(D1,char(C14(a)),char(C14(a-1)))==1))) 
        x1=x1+timedif;
    else
        if (x1<1500)
            model_eye_count = model_eye_count + x1; 
            x1=0; 
        end;
    end;
    %check if tracked-gaze target = random target
    if (((strcmp(C14(a),C15(a))==1)|(checkdb(D1,char(C14(a)),char(C15(a)))==1)) && ...
            ((strcmp(C14(a-1),C15(a-1))==1)|(checkdb(D1,char(C14(a-1)),char(C15(a-1)))==1)) && ... 
            ((strcmp(C14(a),C14(a-1))==1)|(checkdb(D1,char(C14(a)),char(C14(a-1)))==1))) 
        x2=x2+timedif;
    else
        if (x2<1500)
            random_eye_count = random_eye_count + x2; 
            x2=0; 
        end;
    end;
    %if (timedif < 1000)
    %    count = count + 1;
    %end;
end;
x = head_eye_count;
y = model_eye_count;
z = random_eye_count;


function found = checkdb(db,str1,str2)
% if((isempty(str1)) | (isempty(str2)))
%     found = 0;
%     return;
% end;
for i=1:size(db)
    if ((isempty(strfind(char(db(i)),str1))==0) && (isempty(strfind(char(db(i)),str2))==0))
        found = 1;
        return; 
    end;
    found = 0;
end;

