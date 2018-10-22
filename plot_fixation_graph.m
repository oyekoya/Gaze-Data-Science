function [X1,Y1,X2,Y2,X3,Y3] = plot_fixation_graph(file1, file2)

fid = fopen(file1);
[C1,C2,C3] = textread(file1,'%s%d%d', 'delimiter',';');
%C = textscan(fid,'%s%d%d', 'delimiter',';');
fclose(fid);
% C1 = C{1};   %node gaze_target
% C2 = C{2};   %frame count?
% C3 = C{3};   %fixation duration
clear C;

%int32(ceil([max(C2) max(C3)]))

% fixation duration graphs
x1 = 500:500:5500;
x2 = 500:500:5500;
x3 = 500:500:5500;
y1 = zeros(1,11);
y2 = zeros(1,11);
y3 = zeros(1,11);
for a=1:size(C3)
    b = floor((C3(a)/500)+1);
    %if (b>11) b=11; end;
    %if (b<1) b=1; end;
    if ((b>=1) && (b<=11)) 
        y1(1,b) = y1(1,b)+C3(a);
        if (isempty(strfind(mat2str(cell2mat(C1(a))),'FACES')) == 1) %if avatar
            y2(1,b) = y2(1,b)+C3(a);
        end;
        if (isempty(strfind(mat2str(cell2mat(C1(a))),'FACES')) == 0) %if object
            y3(1,b) = y3(1,b)+C3(a);
        end;
    end;
end;
X1 = x1;
X2 = x2;
X3 = x3;
if (sum(y1)~=0) 
    Y1 = y1/sum(y1)*100;
else
    Y1 = y1*100;
end;
if (sum(y2)~=0) 
    Y2 = y2/sum(y2)*100; 
else
    Y2 = y2*100;
end;
if (sum(y3)~=0) 
    Y3 = y3/sum(y3)*100; 
else
    Y3 = y3*100;
end;
% plot(x,y)
% imagefile2 = strcat('fixation_',file2)
% saveas(gca,imagefile2)

