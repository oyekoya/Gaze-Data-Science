function get_data = readlog_getgazetargets(file1, file2)

fid = fopen(file1);%'sfd_client_spec_modified_05c_2.log'
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20] = textread(file1,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
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
% C12 = C{12}; %person_talking (1, 2, 3, 0[none]) - in future, use Player application to determine wallclocktime instead)
% C13 = C{13}; %instruction state (1 - start point of given instruction to successful identification/completion) - in future, use Player application
% C14 = C{14}; %gaze target (hit node)
% C15 = C{15}; %random target (hit node)
% C16 = C{16}; %head target (hit node)
% C17 = C{17}; %node grabbed
% C18 = C{18}; %H - horizontal gaze point
% C19 = C{19}; %V - vertical gaze point
% C20 = C{20}; %P - pupil diameter
clear C;

fid = fopen(file2,'w');%'output.log'
index = 1;
a=1;
y = zeros(20,1);
for x=1:size(C13)
    if (C13(x)==index) %if instruction has just been issued or cube has just been identified
        y(a,1) = x; % index of wallclocktime
        %y(a,2) = C1(x); %get wallclocktime    
        a = a + 1; %go to next point in y matrix
        index = not(index);
    end;
end;
y

start = C1(y(1,1));
for n=1:a-1
    count = 1;
    if (a~=1)
        fprintf(fid,'%d - %d\n',n,n+1);
        for m=y(n,1):y(n+1,1)
            if (strcmp(C14(m),C14(m+1)) == 1)
                count = count + 1;
            else
                diff_time = C1(m) - start;
                fprintf(fid,'%s;',mat2str(cell2mat(C14(m))));
                fprintf(fid,'%s;',int2str(count));
                fprintf(fid,'%s\n',int2str(diff_time));
                start = C1(m);
                count = 1;
            end;
%             if (strcmp(C3(m),nodeid)) == 1
%                 fprintf(fid,'%s;',int2str(C1(m)));
%                 fprintf(fid,'%s;',char(C3(m)));
%                 fprintf(fid,'%.3f;',C8(m));
%                 fprintf(fid,'%.3f;',C10(m));
%                 fprintf(fid,'%d;',C13(m));
%                 fprintf(fid,'%s;',mat2str(cell2mat(C14(m))));
%                 fprintf(fid,'%s;',mat2str(cell2mat(C15(m))));
%                 fprintf(fid,'%s;',mat2str(cell2mat(C16(m))));
%                 fprintf(fid,'%s\n',mat2str(cell2mat(C17(m))));
%             end;
        end;
    end;
end;
fclose(fid)

clear all;