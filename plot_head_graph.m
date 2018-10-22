function [X,Y] = plot_head_graph(file1, file2)

fid = fopen(file1);
[C1,C2,C3] = textread(file1,'%s%d%s', 'delimiter',';');
%C = textscan(fid,'%s%d%d', 'delimiter',';');
fclose(fid);
% C1 = C{1};   %node gaze_target
% C2 = C{2};   %duration
clear C;

%int32(ceil([max(C2) max(C3)]))

% duration graphs
x = 500:500:5500;
y = zeros(1,11);
for a=1:size(C2)
    b = ceil((C2(a)/500));
    if ((b>=1) && (b<=11)) 
        y(1,b) = y(1,b)+C2(a);
    end;
end;
X = x;
if (sum(y)~=0) 
    Y = y/sum(y)*100; 
else
    Y = y*100;
end;
% plot(x,y)
% imagefile2 = strcat('headgaze',file2)
% saveas(gca,imagefile2)

