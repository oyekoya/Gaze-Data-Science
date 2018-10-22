function [x,y,z] = match_equalityv2(file1,file2,file3,dur)

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

% fid = fopen(file3);
% [E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20] = textread(file3,'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter',',');
% fclose(fid);
% total_dist = 0;
% for b=1:size(E1)
%     dist = sqrt((E14(b)-E11(b)).^2 + (E13(b)-E10(b)).^2 + (E12(b)-E9(b)).^2);
%     total_dist = total_dist + dist;
% end;
% [a1,a2]=size(E1);
% total_dist/a1
% total_spacing = 0;
% total_avg_space = 0;
% for b=1:size(E1)
%   for c=1:size(E1)
%     spacing = sqrt((E2(b)-E2(c)).^2 + (E2(b)-E2(c)).^2 + (E2(b)-E2(c)).^2);
%     total_spacing = total_spacing + spacing;
%   end;
%   avg_space = total_spacing/a1;
%   total_avg_space = total_avg_space + avg_space;
%   total_spacing = 0;
% end;
% total_avg_space/a1

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
    timedif = C1(a)-C1(a-1); %a fair assessment should be count rather than timedif (as timedif depends on frame rate)
    %check if tracked gaze target = static/head target
    if (strcmp(C14(a),C16(a))==1)%(&& ...
            %((strcmp(C14(a-1),C16(a-1))==1)) && ... 
            %((strcmp(C14(a),C14(a-1))==1))) 
        x1=x1+1;%timedif;
    else
        %if ((x1>0)&&(x1<dur))
            head_eye_count = head_eye_count + x1; 
        %end;
        x1=0; 
    end;
    %check if tracked-gaze target = model target
    if ((strcmp(C14(a),C13(a))==1)|(checkdb(D1,char(C14(a)),char(C13(a)))==1))%( && ...
            %((strcmp(C14(a-1),C13(a-1))==1)|(checkdb(D1,char(C14(a-1)),char(C13(a-1)))==1)) && ... 
            %((strcmp(C14(a),C14(a-1))==1)|(checkdb(D1,char(C14(a)),char(C14(a-1)))==1))) 
        x2=x2+1;%timedif;
    else
        %if ((x2>0)&&(x2<dur))
            model_eye_count = model_eye_count + x2; 
        %end;
        x2=0; 
    end;
    %check if tracked-gaze target = random target
    if ((strcmp(C14(a),C15(a))==1)|(checkdb(D1,char(C14(a)),char(C15(a)))==1))%( && ...
            %((strcmp(C14(a-1),C15(a-1))==1)|(checkdb(D1,char(C14(a-1)),char(C15(a-1)))==1)) && ... 
            %((strcmp(C14(a),C14(a-1))==1)|(checkdb(D1,char(C14(a)),char(C14(a-1)))==1))) 
        x3=x3+1;%timedif;
    else
        %if ((x3>0)&&(x3<dur))
            random_eye_count = random_eye_count + x3;
        %end;
        x3=0;
    end;
    count = count + timedif;
end;
x = head_eye_count;%/count*100;
y = model_eye_count;%/count*100;
z = random_eye_count;%/count*100;


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

