function node_durations

[f,f1,f2,f3,f4] = barplots('../data/tracked_conversation2.log','nodevalues_conversation.txt')
[c,c1,c2,c3,c4] = barplots('../data/tracked_cubes2.log','nodevalues_cubes.txt')
[m,m1,m2,m3,m4] = barplots('../data/tracked_miltonkeynes2.log','nodevalues_miltonkeynes.txt')
fid = fopen('barplot.log','a+');
fprintf(fid,'conversation\n');
for i=1:size(f)
    fprintf(fid,'%s;%d;%d;%d;%d\n',char(f(i)),f1(i),f2(i),f3(i),f4(i));
end;
fprintf(fid,'cubes\n');
for i=1:size(c)
    fprintf(fid,'%s;%d;%d;%d;%d\n',char(c(i)),c1(i),c2(i),c3(i),c4(i));
end;
fprintf(fid,'miltonkeynes\n');
for i=1:size(m)
    fprintf(fid,'%s;%d;%d;%d;%d\n',char(m(i)),m1(i),m2(i),m3(i),m4(i));
end;
fclose(fid);

function [D1,model_dur,tracked_dur,random_dur,static_dur] = barplots(file1,file2)

fid = fopen(file1);%'sfd_client_spec_modified_05c_2.log'
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24] = textread(file1,'%n%c%s%s%f%f%f%f%f%f%f%d%s%s%s%s%s%f%f%f%f%f%f%f', 'delimiter',';');
%C = textscan(fid,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fclose(fid);
% C13 = C{13}; %model target (hit node)
% C14 = C{14}; %tracked-gaze target (hit node)
% C15 = C{15}; %random target (hit node)
% C16 = C{16}; %static/head target (hit node)

fid = fopen(file2);
[D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20] = textread(file2,'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter',',');
fclose(fid);

[x y]=size(D1);
D1(x+1) = {'NULL'}; %add 'NULL'

model_dur = zeros(size(D1));
tracked_dur = zeros(size(D1));
random_dur = zeros(size(D1));
static_dur = zeros(size(D1));
for a=1:size(D1)
    for b=2:size(C13)
        %get cumulative duration for each unique node-transform id
        if (strcmp(C13(b),D1(a))==1)
            model_dur(a) = model_dur(a) + (C1(b)-C1(b-1));
        end;
        if (strcmp(C14(b),D1(a))==1)
            tracked_dur(a) = tracked_dur(a) + (C1(b)-C1(b-1));
        end;
        if (strcmp(C15(b),D1(a))==1)
            random_dur(a) = random_dur(a) + (C1(b)-C1(b-1));
        end;
        if (strcmp(C16(b),D1(a))==1)
            static_dur(a) = static_dur(a) + (C1(b)-C1(b-1));
        end;
    end;
end;