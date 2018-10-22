function get_data = readlog_getgazetargets(file1, file2)

fid = fopen(file1);%'sfd_client_spec_modified_05c_2.log'
C = textscan(fid,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fclose(fid);
C1 = C{1};   %wallclocktime
C2 = C{2};   %index char M(index character to denote node repositioning), C(obj loading), A(Attach), D(Detach)
C3 = C{3};   %Node ID
C4 = C{4};   %left/right
C5 = C{5};   %up/down
C6 = C{6};   %in/out
C7 = C{7};   %pitch
C8 = C{8};   %heading
C9 = C{9};   %roll
C10 = C{10}; %rotation angle
C11 = C{11}; %scaling
C12 = C{12}; %person_talking (1, 2, 3, 0[none]) - in future, use Player application to determine wallclocktime instead)
C13 = C{13}; %instruction state (1 - start point of given instruction to successful identification/completion) - in future, use Player application
C14 = C{14}; %gaze target (hit node)
C15 = C{15}; %random target (hit node)
C16 = C{16}; %head target (hit node)
C17 = C{17}; %node grabbed
C18 = C{18}; %H - horizontal gaze point
C19 = C{19}; %V - vertical gaze point
C20 = C{20}; %P - pupil diameter
clear C;

fid = fopen(file2,'w');%'output.log'
count = 1;
starttime=0;
for x=1:size(C13)-1
    if (strcmp(C2(x),'M') == 1)
        if (C18(x) == C18(x+1))
            if (count==1) starttime=C1(x); end;
            count = count + 1;
        else
            diff_time = C1(x) - starttime;
            fprintf(fid,'%f;',C18(x));
            fprintf(fid,'%f;',C19(x));
            fprintf(fid,'%s;',int2str(count));
            fprintf(fid,'%s\n',int2str(diff_time));
            count = 1;
        end;
        if (C13(x) == 1) break; end;
    end;
end;
% y
% 
% for n=1:a-1
%     start = C1(y(n,1));
%     if (a~=1)
%         fprintf(fid,'%d - %d\n',n,n+1);
%         for m=y(n,1):y(n+1,1)
% %             if (strcmp(C3(m),nodeid)) == 1
% %                 fprintf(fid,'%s;',int2str(C1(m)));
% %                 fprintf(fid,'%s;',char(C3(m)));
% %                 fprintf(fid,'%.3f;',C8(m));
% %                 fprintf(fid,'%.3f;',C10(m));
% %                 fprintf(fid,'%d;',C13(m));
% %                 fprintf(fid,'%s;',mat2str(cell2mat(C14(m))));
% %                 fprintf(fid,'%s;',mat2str(cell2mat(C15(m))));
% %                 fprintf(fid,'%s;',mat2str(cell2mat(C16(m))));
% %                 fprintf(fid,'%s\n',mat2str(cell2mat(C17(m))));
% %             end;
%         end;
%     end;
% end;
fclose(fid)

clear all;