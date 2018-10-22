function [X1,Y1,X2,Y2,X3,Y3,X7,Y7] = plot_graph(file1, file2)

fid = fopen(file1);
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24] = textread(file1,'%n%f%f%f%f%f%f%n%n%n%n%f%s%s%s%s%f%f%f%f%f%f%f%f', 'delimiter',';');
%C = textscan(fid,'%n%f%f%f%f%f%f%s%s%s%s', 'delimiter',';');
fclose(fid);
% C1 = C{1};   %time difference btw eye targets
% C2 = C{2};   %distance btw eye and its target - guide max 10
% C3 = C{3};   %angular distance of eye target from head gaze - guide max 100 deg
% C4 = C{4};   %angular velocity btw eye targets (or magnitude) - guide max 100 deg/s
% C5 = C{5};   %x-distance - guide min -10 to max 10
% C6 = C{6};   %y-distance
% C7 = C{7};   %z-distance
% C8 = C{8};  % AB - set to 1 if A is looking at B's left/right eyes
% C9 = C{9};  % BA
% C10 = C{10}; % AC
% C11 = C{11}; % CA
% C12 = C{12};  % difference between last and current head orientation
% C13 = C{13};  %gaze target (hit node)
% C14 = C{14};  %random target (hit node)
% C15 = C{15}; %head target (hit node)
% C16 = C{16}; %node grabbed
clear C;

%int32(ceil([max(C1) max(C2) max(C3) max(C4) max(C5) max(C6) max(C7) max(C12)]))
% x = zeros(size(C1),1);
% y = zeros(b,1);

% distance graphs
x = 0:1:20;
y = zeros(1,21);
for a=1:size(C2)
    b = ceil((C2(a)*1)+1);
    if ((b>=1) && (b<=21)) 
        y(1,b) = y(1,b)+C1(a);
    end;
end;
X1 = x;
if (sum(y)~=0)
    Y1 = y/sum(y)*100;
else
    Y1 = y*100;
end;
% plot(x,y)
% imagefile2 = strcat('dist_',file2)
% saveas(gca,imagefile2)

%angular distance (eccentricity) graphs
x = 0:5:100;
y = zeros(1,21);
for a=1:size(C3)
    b = floor((C3(a)/5)+1);
    if ((b>=1) && (b<=21)) 
        y(1,b) = y(1,b)+C1(a);
    end;
end;
X2 = x;
if (sum(y)~=0)
    Y2 = y/sum(y)*100;
else
    Y2 = y*100;
end;
% plot(x,y)
% imagefile2 = strcat('angle_dist_',file2)
% saveas(gca,imagefile2)

%velocity
x = 50:50:1000;
y = zeros(1,20);
for a=1:size(C4)
    b = ceil(((C4(a))/50));
    if ((b>=1) && (b<=20)) 
        y(1,b) = y(1,b)+C1(a);
    end;
end;
X3 = x;
if (sum(y)~=0)
    Y3 = y/sum(y)*100;
else
    Y3 = y*100;
end;
% plot(x,y)
% imagefile2 = strcat('velocity_',file2)
% saveas(gca,imagefile2)

%magnitude
x = 5:5:100;
y = zeros(1,20);
for a=1:size(C17)
    b = ceil(((C17(a))/5));
    if ((b>=1) && (b<=20)) 
        y(1,b) = y(1,b)+C1(a);
    end;
end;
X7 = x;
if (sum(y)~=0)
    Y7 = y/sum(y)*100;
else
    Y7 = y*100;
end;
% plot(x,y)
% imagefile2 = strcat('velocity_',file2)
% saveas(gca,imagefile2)

% % x-distance graphs
% x = -10:.1:10;
% y = zeros(1,201);
% for a=1:size(C5)
%     b = ceil((C5(a)*10)+101);
%     if (b>201) b=201; end;
%     if (b<1) b=1; end;
%     y(1,b) = y(1,b)+C1(a);
% end;
% plot(x,y)
% imagefile2 = strcat('x_dist_',file2)
% saveas(gca,imagefile2)
% 
% % y-distance graphs
% x = -10:.1:10;
% y = zeros(1,201);
% for a=1:size(C6)
%     b = ceil((C6(a)*10)+101);
%     if (b>201) b=201; end;
%     if (b<1) b=1; end;
%     y(1,b) = y(1,b)+C1(a);
% end;
% plot(x,y)
% imagefile2 = strcat('y_dist_',file2)
% saveas(gca,imagefile2)
% 
% % z-distance graphs
% x = -10:.1:10;
% y = zeros(1,201);
% for a=1:size(C7)
%     b = ceil((C7(a)*10)+101);
%     if (b>201) b=201; end;
%     if (b<1) b=1; end;
%     y(1,b) = y(1,b)+C1(a);
% end;
% plot(x,y)
% imagefile2 = strcat('z_dist_',file2)
% saveas(gca,imagefile2)
