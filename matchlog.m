function transferdata_client_spec = matchlog(file1, file2, file3)

fid = fopen(file1);%'ucl_client_01a.log'
C = textscan(fid,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fclose(fid);
C1 = C{1};   %wallclocktime
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

fid = fopen(file2);%'sfd_client_spec_01a.log'
D = textscan(fid,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fclose(fid);
D1 = D{1};   %wallclocktime
D2 = D{2};   %index char M(index character to denote node repositioning), C(obj loading), A(Attach), D(Detach)
D3 = D{3};   %Node ID
D4 = D{4};   %left/right
D5 = D{5};   %up/down
D6 = D{6};   %in/out
D7 = D{7};   %pitch
D8 = D{8};   %heading
D9 = D{9};   %roll
D10 = D{10}; %rotation angle
D11 = D{11}; %scaling
D12 = D{12}; %person_talking (1, 2, 3, 0[none]) - in future, use Player application to determine wallclocktime instead)
D13 = D{13}; %instruction state (1 - start point of given instruction to successful identification/completion) - in future, use Player application
D14 = D{14}; %gaze target (hit node)
D15 = D{15}; %random target (hit node)
D16 = D{16}; %head target (hit node)
D17 = D{17}; %node grabbed
D18 = D{18}; %H - horizontal gaze point
D19 = D{19}; %V - vertical gaze point
D20 = D{20}; %P - Pupil diameter
clear D;

fid = fopen(file3,'w');%'sfd_client_spec_modified_01a.log'
index = 1;
%a=1;
for x=1:size(D1,1) %for each line in spec log
    y = zeros(size(C1,1),1); %create 2-dimensional matrx
    for b=1:size(C1,1)
        y(b)=sqrt((D1(x)-C1(b))*(D1(x)-C1(b))); %uint32(C1(x)-D1(b));
        if ((y(b))==0) 
            a=b; 
            break; 
        end;
    end
    if (b == size(C1,1)) %only get minimum of y if loop-break was not encountered
        [c,a] = min(y);%minimum of y
    end;
    fprintf(fid,'%s;',int2str(D1(x)));
    fprintf(fid,'%c;',D2(x));
    fprintf(fid,'%s;',char(D3(x)));
    fprintf(fid,'%s;',mat2str(cell2mat(D4(x))));
    if (D2(x)=='M')
        fprintf(fid,'%.3f;',D5(x));
        fprintf(fid,'%.3f;',D6(x));
        fprintf(fid,'%.3f;',D7(x));
        fprintf(fid,'%.3f;',D8(x));
        fprintf(fid,'%.3f;',D9(x));
        fprintf(fid,'%.3f;',D10(x));
        fprintf(fid,'%.3f;',D11(x));
        fprintf(fid,'%d;',C12(a));
        fprintf(fid,'%d;',C13(a));
        fprintf(fid,'%s;',mat2str(cell2mat(C14(a))));
        fprintf(fid,'%s;',mat2str(cell2mat(C15(a))));
        fprintf(fid,'%s;',mat2str(cell2mat(C16(a))));
        fprintf(fid,'%s;',mat2str(cell2mat(C17(a))));
        fprintf(fid,'%.3f;',C18(a));
        fprintf(fid,'%.3f;',C19(a));
        fprintf(fid,'%.3f\n',C20(a));
    else
        fprintf(fid,'\n','');        
    end;
%     if C1(index)<D1(x)
%     else
%         index=index+1;
%     end;
%     if (C13(x)==index) %instruction issued and completion
%         if (index==1) 
%             y(a,1) = C1(x); %get wallclocktime for instruction issued
%         else
%             y(a,2) = C1(x);
%             a = a + 1;
%         end;
%         index = not(index);
%     end;
end;
fclose(fid)

clear all;