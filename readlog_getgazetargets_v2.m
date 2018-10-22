function get_data = readlog_getgazetargetsv2(file1, file2, index)

fid = fopen(file1);
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24] = textread(file1,'%n%c%s%s%f%f%f%f%f%f%f%d%s%s%s%s%s%f%f%f%f%f%f%f', 'delimiter',';');
fclose(fid);

fid = fopen(file2,'w');%'output.log'
% index = 1;
% a=1;
% y = zeros(20,1);
% for x=1:size(C13)
%     if (C13(x)==index) %if instruction has just been issued or cube has just been identified
%         y(a,1) = x; % index of wallclocktime
%         %y(a,2) = C1(x); %get wallclocktime    
%         a = a + 1; %go to next point in y matrix
%         index = not(index);
%     end;
% end;
% y
if (index=='1'), D=C13; end;
if (index=='2'), D=C14; end;
if (index=='3'), D=C15; end;
if (index=='4'), D=C16; end;
start = C1(1);
for m=1:size(D)-1 %n=1:a-1
    count = 1;
    if (C2(m)=='M') %(a~=1)
        %fprintf(fid,'%d - %d\n',n,n+1);
        %for m=y(n,1):y(n+1,1)
            if (strcmp(D(m),D(m+1)) == 1)
                count = count + 1;
            else
                diff_time = C1(m) - start;
                fprintf(fid,'%s;',mat2str(cell2mat(D(m))));
                fprintf(fid,'%s;',int2str(count));
                fprintf(fid,'%s\n',int2str(diff_time));
                start = C1(m);
                count = 1;
            end;
        %end;
    end;
end;
fclose(fid)

clear all;