function plot_saliency = plotsaliency(file1)

%[C1,C2,C3,C4] = textread(file1,'%s%s%s%s', 'delimiter','\t');
fid = fopen(file1);
C = textscan(fid,'%s%s%s%s', 'delimiter','\t');
fclose(fid);
C1 = C{1};   %timestamp, timestamp difference, time difference, instruct state, node grabbed
C2 = C{2};   %NODE_SALIENCY, [repeated for each node in scene ->] Node ID, eccentricity, 
             %magnitude, bounding volume (local coords), bounding volume (world coords), distance
C3 = C{3};   %GAZE_TARGET, Node ID, gaze_target, recorded gaze_target
C4 = C{4};   %HISTORY, Total time history, [repeated for each unique gaze_target node ->] Node ID, 
             %cumulative dwell time (frame duration)

D1 = C1;
[timestamp, D1] = strtok(D1, ';'); %timestamp
[timestamp_diff, D1] = strtok(D1, ';'); %timestamp difference
[token, D1] = strtok(D1, ';'); %skip
[instruction, D1] = strtok(D1, ';'); %instruct_state
index = 1;
a = 1;
y = zeros(20,1);
for x=1:size(C1)
    if (str2double(char(instruction(x)))==index) %if instruction has just been issued or cube has just been identified
        y(a,1) = x; % index of timestamp
        a = a + 1; %go to next point in y matrix
        index = not(index);
    end;
end;
y

time = 0;
i=1; j=1;
col = y(a-1,1) - y(1,1) + 1;
row = 32;
X = zeros(1,col);
Y1 = zeros(row,col);
if (a~=1)
    %fprintf(fid,'%d - %d\n',n,n+1);
    for m=y(1,1):y(a-1,1)
        str = C2(m);
        [token, str] = strtok(str, ';'); %skip first token 'NODE_SALIENCY'
        while true
            if isempty(char(token))
                i = 1;
                break; 
            end
            [nodeid, str] = strtok(str, ';'); %get node id
            [token, str] = strtok(str, ';'); %get eccentricity
            Y1(i,j) = str2double(char(token));
            [token, str] = strtok(str, ';'); %get magnitude
            [token, str] = strtok(str, ';'); %get bounding volume (local)
            [token, str] = strtok(str, ';'); %skip bounding volume (world)
            [token, str] = strtok(str, ';'); %get eye distance
            i = i + 1;
        end;
        time = time + str2double(char(timestamp_diff(m)));
        X(1,j) = time;
        j = j + 1;
    end;
end;
view = 500;
h = plot(X(:,1:view),Y1(:,1:view));
set(h,'EraseMode','xor')
[d1,d2] = size(X);
for p=view+1:d2
   drawnow
   %x = x + s*randn(n,1);
   %y = y + s*randn(n,1);
   XX = X(:,p-view:p-1);
   YY = Y1(:,p-view:p-1);
   set(h,'XData',XX,'YData',YY)
end
