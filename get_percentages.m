function [x,y,z] = get_percentages(file1)

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

count = 0;
head_eye_count = 0;
head_model_count = 0;
eye_model_count = 0;
for a=1:size(C13)
    %check if head gaze = eye gaze 
    if ((strcmp(C13(a),C15(a))==1) && (strcmp(C15(a),'NULL')~=1))
        head_eye_count = head_eye_count + C1(a);
    end;
    %check if head gaze = model gaze 
    if ((strcmp(C14(a),C15(a))==1) && (strcmp(C14(a),'NULL')~=1))
        head_model_count = head_model_count + C1(a);
    end;
    %check if model gaze = eye gaze 
    if ((strcmp(C13(a),C14(a))==1) && (strcmp(C13(a),'NULL')~=1))
        eye_model_count = eye_model_count + C1(a);
    end;
    count = count + C1(a);
end;
x = head_eye_count/count*100;
y = head_model_count/count*100;
z = eye_model_count/count*100;

