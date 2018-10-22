function getdata = geteyemetrics(file1, file2)

fid = fopen(file1);
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24,C25,C26,C27] = textread(file1,'%s%f%f%f%f%f%f%n%n%n%n%f%s%s%s%s%f%f%f%f%f%f%f%f%f%f%f', 'delimiter',';');
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
% C17 = C{17}; %saccade magnitude
% C18 = C{18}; %head euler h
% C19 = C{19}; %head euler p
% C20 = C{20}; %head euler r
% C21 = C{21}; %eye euler h
% C22 = C{22}; %eye euler p
% C23 = C{23}; %eye euler r
% C24 = C{24}; %distance btw head and eye euler angles
% C25 = C{25}; %hor gaze
% C26 = C{26}; %vert gaze
% C27 = C{27}; %pupil diameter
% clear C;

fid = fopen(file2,'a+');%'output.log'
fprintf(fid,'%s\n',file1);
m = 2;
pupil_size = zeros(1,1);
sac_speed = 0;
fix_count = 0;
index = 0;
x = 0.25:.01:0.5;
y = zeros(1,26);
for a=2:size(C1) %start from 2
    if (strcmp(C1(a),sprintf('%d - %d',m,m+1)))
     	X = x;
		if (sum(y)~=0)
            Y = y/sum(y)*100;
		else
            Y = y*100;
		end;
        k = kurtosis(Y);
        n = a - 1;
        fix_count = 1;
        count = 1;
        obj_interest = C13(n);
        while (strcmp(C13(n),'')==0)
            if ((strcmp(C13(n),C13(n-1))==0)&&(strcmp(C13(n),obj_interest)==1))
                fix_count = fix_count + 1; %increment everytime node changes from interest node
            end;
            %if ((strcmp(C13(n),C13(n-1))==0)&&(strcmp(C13(n),obj_interest)==1)&&(count<6)) 
            if ((strcmp(C13(n),C13(n-1))==0)&&(count<6)) 
                [p q] = size(C4);
                if (n+3<=p)
                    sac_speed = max([C4(n),C4(n+1),C4(n+2),C4(n+3)]);
                else 
                    sac_speed = C4(n);
                end;
                count = count + 1;
                fprintf(fid,'%.3f;',sac_speed); %get max from next 4 saccade speeds
            end;
            n = n - 1;
        end;
        %record results
        fprintf(fid,'%d;%.3f',fix_count,k);
        fprintf(fid,'\n');
		%figure, plot(X,Y);
		%xlabel(sprintf('%.3f',k));
		m = m + 1;
		%reset all
		y = zeros(1,26);
		index = 0;
		sac_speed = 0;
		pupil_size = zeros(1,1);
		continue;
    else
        %perform increments etc
        index = index + 1;
        pupil_size(index,1)=C27(a);
        b = round((C27(a)*100)-25);
        if ((b>=1) && (b<=26))
            y(1,b) = y(1,b)+str2double(C1(a));
        end;
    end;
end;

fclose(fid);
