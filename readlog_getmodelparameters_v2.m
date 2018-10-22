function get_data = readlog(file1, nodeid, file2)

global cube01_id cube02_id cube03_id cube04_id cube05_id cube06_id cube07_id cube08_id;
global dummy01_id dummy02_id dummy03_id dummy04_id dummy05_id;
%[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20] = textread(file1,'%n%c%s%s%f%f%f%f%f%f%f%d%d%s%s%s%s%f%f%f', 'delimiter',';');
fid = fopen(file1);
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
index = 1;
a=1;
y = zeros(20,9);
node = struct('id',{},'obj',{},'x',{},'y',{},'z',{},'rx',{},'ry',{},'rz',{},'w',{},'gaze_target',{},'random_target',{},'head_target',{},'node_grabbed',{}); %assumes a maximum of 100 objects within scene
node_num = 0;
for x=1:size(C13)
    if (C13(x)==index) %if instruction has just been issued or cube has just been identified
        y(a,1) = x; % index of wallclocktime
        %y(a,2) = C1(x); %get wallclocktime    
        a = a + 1; %go to next point in y matrix
        index = not(index);
    end;
    if (C2(x)=='C')
        node_num = node_num + 1;
        node(node_num).id = C3(x);
        node(node_num).obj = C4(x);
        % store eyes, head and body info for global coords calculation
        if (strcmp(C3(x),strcat(nodeid,'el')) == 1) left_eye_index = node_num; end;
        if (strcmp(C3(x),strcat(nodeid,'er')) == 1) right_eye_index = node_num; end;
        if (strcmp(C3(x),strcat(nodeid,'h')) == 1) head_index = node_num; end;
        if (strcmp(C3(x),nodeid) == 1) body_origin_index = node_num; end;
        % store sfd and rdg participant avatar node ids
        if (strcmp(C4(x),'robin_body.obj') == 1) sfd_nodeid = strrep(C3(x),'b','et'); sfd_et_index = node_num; end;
        if (strcmp(C4(x),'robin_body_rdg.obj') == 1) rdg_nodeid = strrep(C3(x),'b','et'); rdg_et_index = node_num; end;
    end;
end;
%y
% store eyes, head and body info for global coords calculation
for p=1:node_num 
    if (strcmp(node(p).id,strrep(sfd_nodeid,'et','er')) == 1) sfd_er_index = p; end;
    if (strcmp(node(p).id,strrep(sfd_nodeid,'et','el')) == 1) sfd_el_index = p; end;
    if (strcmp(node(p).id,strrep(sfd_nodeid,'et','h')) == 1) sfd_h_index = p; end;
    if (strcmp(node(p).id,strrep(sfd_nodeid,'et','')) == 1) sfd_b_index = p; end;
    if (strcmp(node(p).id,strrep(rdg_nodeid,'et','er')) == 1) rdg_er_index = p; end;
    if (strcmp(node(p).id,strrep(rdg_nodeid,'et','el')) == 1) rdg_el_index = p; end;
    if (strcmp(node(p).id,strrep(rdg_nodeid,'et','h')) == 1) rdg_h_index = p; end;
    if (strcmp(node(p).id,strrep(rdg_nodeid,'et','')) == 1) rdg_b_index = p; end;
    tmp_nodeid = mat2str(cell2mat(node(p).id));
	switch mat2str(cell2mat(node(p).obj))
       case 'cube01.wrl'
          cube01_id = tmp_nodeid;
       case 'cube02.wrl'
          cube02_id = tmp_nodeid;
       case 'cube03.wrl'
          cube03_id = tmp_nodeid;
       case 'cube04.wrl'
          cube04_id = tmp_nodeid;
       case 'cube05.wrl'
          cube05_id = tmp_nodeid;
       case 'cube06.wrl'
          cube06_id = tmp_nodeid;
       case 'cube07.wrl'
          cube07_id = tmp_nodeid;
       case 'cube08.wrl'
          cube08_id = tmp_nodeid;
       case 'dummy01.wrl'
          dummy01_id = tmp_nodeid;
       case 'dummy02.wrl'
          dummy02_id = tmp_nodeid;
       case 'dummy03.wrl'
          dummy03_id = tmp_nodeid;
       case 'dummy04.wrl'
          dummy04_id = tmp_nodeid;
       case 'dummy05.wrl'
          dummy05_id = tmp_nodeid;
	end
end;

% A (ucl) is main participant while B (sfd) and C (rdg) are confederates
AB = false; % set to true if A looks at B's eye region
BA = false;
AC = false;
CA = false;
prev_timestamp = 0;
prev_head_w = 0;
last_eyetarget_x = 0;
last_eyetarget_y = 0;
last_eyetarget_z = 0;
last_globeyecoord_x = 0;
last_globeyecoord_y = 0;
last_globeyecoord_z = 0;
for m=1:size(C13) %n=1:a-1
    if (C2(m)=='M') %(a~=1)
        %fprintf(fid,'%d - %d\n',n,n+1);
        %for m=y(n,1):y(n+1,1)
            % update node information at every loop
            for r=1:node_num 
                if (strcmp(node(r).id,C3(m)) == 1)
                    node(r).x = str2double(C4(m));
                    node(r).y = C5(m);
                    node(r).z = C6(m);
                    node(r).rx = C7(m);
                    node(r).ry = C8(m);
                    node(r).rz = C9(m);
                    node(r).w = C10(m);
                    node(r).gaze_target = C14(m);
                    node(r).random_target = C15(m);
                    node(r).head_target = C16(m);
                    node(r).node_grabbed = C17(m);
					break;
                end;
            end;
            
            if (strcmp(node(r).id,strcat(nodeid,'et')) == 1) % ucl 'et'
                % calc time difference from last eye target
                if (prev_timestamp ~= 0) 
                    time_diff = C1(m) - prev_timestamp;
                else 
                    time_diff = 0; 
                end;
                fprintf(fid,'%s;',int2str(time_diff));
                % --------------------------------------------------------
                % convert eye to global coords - body*head*right_eye matrix
                % calc distance from right eye (global coords) to eye target
                node1 = node;
                body = body_origin_index;
                head = head_index;
                eye = right_eye_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_eye_x = glob_matrix(1,4);
                glob_coord_eye_y = glob_matrix(2,4);
                glob_coord_eye_z = glob_matrix(3,4);
                distance = sqrt(((glob_coord_eye_x-node(r).x).^2)+((glob_coord_eye_y-node(r).y).^2)+((glob_coord_eye_z-node(r).z).^2));
                fprintf(fid,'%.3f;',distance);
                % --------------------------------------------------------
                % calc angular distance of eye target from centre of gaze
                % eccentricity (w-value of node er)
                angular_distance = node(right_eye_index).w;
                fprintf(fid,'%.3f;',angular_distance);
                % --------------------------------------------------------
                % calc saccade velocity between last eye target, A and 
                % current eye target, B (saccade magnitude / time)
                norm_A = sqrt(last_eyetarget_x.^2 + last_eyetarget_y.^2 + last_eyetarget_z.^2);
                unit_vector_A = [last_eyetarget_x/norm_A last_eyetarget_y/norm_A last_eyetarget_z/norm_A];
                norm_B = sqrt((node(r).x-last_globeyecoord_x).^2 + (node(r).y-last_globeyecoord_y).^2 + (node(r).z-last_globeyecoord_z).^2);
                unit_vector_B = [(node(r).x-last_globeyecoord_x)/norm_B (node(r).y-last_globeyecoord_y)/norm_B (node(r).z-last_globeyecoord_z)/norm_B];
                angle = rad2deg(acos(dot(unit_vector_A,unit_vector_B)));
                velocity = angle/(0.001*time_diff);
                fprintf(fid,'%.3f;',velocity);
                last_eyetarget_x = node(r).x - glob_coord_eye_x;
                last_eyetarget_y = node(r).y - glob_coord_eye_y;
                last_eyetarget_z = node(r).z - glob_coord_eye_z;
                last_globeyecoord_x = glob_coord_eye_x;
                last_globeyecoord_y = glob_coord_eye_y;
                last_globeyecoord_z = glob_coord_eye_z;
                % --------------------------------------------------------
                % x, y and z distance values of target from eye position 
                % in world coordinate
                eyetarget_dist_x = node(r).x - glob_coord_eye_x;
                eyetarget_dist_y = node(r).y - glob_coord_eye_y;
                eyetarget_dist_z = node(r).z - glob_coord_eye_z;
                fprintf(fid,'%.3f;',eyetarget_dist_x);
                fprintf(fid,'%.3f;',eyetarget_dist_y);
                fprintf(fid,'%.3f;',eyetarget_dist_z);
                % --------------------------------------------------------
                % mutual gaze
                % check if A is looking at B or C's left or right eyes
                node1 = node;
                body = sfd_b_index;
                head = sfd_h_index;
                eye = sfd_er_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_er_x = glob_matrix(1,4);
                glob_coord_er_y = glob_matrix(2,4);
                glob_coord_er_z = glob_matrix(3,4);
                A_et_dist_B_er = sqrt(((glob_coord_er_x-node(r).x).^2)+((glob_coord_er_y-node(r).y).^2)+((glob_coord_er_z-node(r).z).^2));
                eye = sfd_el_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_el_x = glob_matrix(1,4);
                glob_coord_el_y = glob_matrix(2,4);
                glob_coord_el_z = glob_matrix(3,4);
                A_et_dist_B_el = sqrt(((glob_coord_el_x-node(r).x).^2)+((glob_coord_el_y-node(r).y).^2)+((glob_coord_el_z-node(r).z).^2));
                if (A_et_dist_B_er <= 0.3)|(A_et_dist_B_el <= 0.3) 
                    AB = true;
%                     if (time_elapsed_AB == 0)
%                         time_elapsed_AB = 1; % set to 1ms to allow recording on next loop
%                     else 
%                         time_elapsed_AB = time_elapsed_AB + (C1(m) - prev_timestamp);
%                     end;
                else
                    AB = false;
%                     time_elapsed_AB = 0;
                end;
                node1 = node;
                body = rdg_b_index;
                head = rdg_h_index;
                eye = rdg_er_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_er_x = glob_matrix(1,4);
                glob_coord_er_y = glob_matrix(2,4);
                glob_coord_er_z = glob_matrix(3,4);
                A_et_dist_C_er = sqrt(((glob_coord_er_x-node(r).x).^2)+((glob_coord_er_y-node(r).y).^2)+((glob_coord_er_z-node(r).z).^2));
                eye = rdg_el_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_el_x = glob_matrix(1,4);
                glob_coord_el_y = glob_matrix(2,4);
                glob_coord_el_z = glob_matrix(3,4);
                A_et_dist_C_el = sqrt(((glob_coord_el_x-node(r).x).^2)+((glob_coord_el_y-node(r).y).^2)+((glob_coord_el_z-node(r).z).^2));
                if (A_et_dist_C_er <= 0.3)|(A_et_dist_C_el <= 0.3) 
                    AC = true;
%                     if (time_elapsed_AC == 0)
%                         time_elapsed_AC = 1; % set to 1ms to allow recording on next loop
%                     else 
%                         time_elapsed_AC = time_elapsed_AC + (C1(m) - prev_timestamp); 
%                     end;
                else
                    AC = false;
%                     time_elapsed_AC = 0;
                end;
                % check if B or C is looking at A's left or right eyes
                % sfd 'et'
                node1 = node; body = body_origin_index;
                head = head_index; eye = right_eye_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_er_x = glob_matrix(1,4);
                glob_coord_er_y = glob_matrix(2,4);
                glob_coord_er_z = glob_matrix(3,4);
                B_et_dist_A_er = sqrt(((glob_coord_er_x-node(sfd_et_index).x).^2)+((glob_coord_er_y-node(sfd_et_index).y).^2)+((glob_coord_er_z-node(sfd_et_index).z).^2));
                node1 = node; body = body_origin_index;
                head = head_index; eye = left_eye_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_el_x = glob_matrix(1,4);
                glob_coord_el_y = glob_matrix(2,4);
                glob_coord_el_z = glob_matrix(3,4);
                B_et_dist_A_el = sqrt(((glob_coord_el_x-node(sfd_et_index).x).^2)+((glob_coord_el_y-node(sfd_et_index).y).^2)+((glob_coord_el_z-node(sfd_et_index).z).^2));
                if (B_et_dist_A_er <= 0.3)|(B_et_dist_A_el <= 0.3) 
                    BA = true;
%                     if (time_elapsed_BA == 0)
%                         time_elapsed_BA = 1; % set to 1ms to allow recording on next loop
%                     else 
%                         time_elapsed_BA = time_elapsed_BA + (C1(m) - prev_timestamp);
%                     end;
                else
                    BA = false;
%                     time_elapsed_BA = 0;
                end;
                % rdg 'et'
                node1 = node; body = body_origin_index;
                head = head_index; eye = right_eye_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_er_x = glob_matrix(1,4);
                glob_coord_er_y = glob_matrix(2,4);
                glob_coord_er_z = glob_matrix(3,4);
                C_et_dist_A_er = sqrt(((glob_coord_er_x-node(rdg_et_index).x).^2)+((glob_coord_er_y-node(rdg_et_index).y).^2)+((glob_coord_er_z-node(rdg_et_index).z).^2));
                node1 = node; body = body_origin_index;
                head = head_index; eye = left_eye_index;
                glob_matrix = getglobmatrix(node1,body,head,eye);
                glob_coord_el_x = glob_matrix(1,4);
                glob_coord_el_y = glob_matrix(2,4);
                glob_coord_el_z = glob_matrix(3,4);
                C_et_dist_A_el = sqrt(((glob_coord_el_x-node(rdg_et_index).x).^2)+((glob_coord_el_y-node(rdg_et_index).y).^2)+((glob_coord_el_z-node(rdg_et_index).z).^2));
                if (C_et_dist_A_er <= 0.3)|(C_et_dist_A_el <= 0.3) 
                    CA = true;
%                     if (time_elapsed_CA == 0)
%                         time_elapsed_CA = 1; % set to 1ms to allow recording on next loop
%                     else 
%                         time_elapsed_CA = time_elapsed_CA + (C1(m) - prev_rdg_timestamp);
%                     end;
                else
                    CA = false;
%                     time_elapsed_CA = 0;
                end;
                % record gaze state true/1 if gaze target = left/right eyes
                fprintf(fid,'%s;%s;%s;%s;',int2str(AB),int2str(BA),int2str(AC),int2str(CA));
                % --------------------------------------------------------
                % head gaze compared to eye gaze
                % w-value of node h - how long was head still b4 head gaze = eye gaze
                head_move = node(head_index).w - prev_head_w;
                head_move = sqrt(head_move^2);
                fprintf(fid,'%.3f;',head_move);
                prev_head_w = node(head_index).w;
                % --------------------------------------------------------
                % store gaze_target node id
                fprintf(fid,'%s;',findnodeid(mat2str(cell2mat(C14(m)))));
                % --------------------------------------------------------
                % store random_target node id
                fprintf(fid,'%s;',findnodeid(mat2str(cell2mat(C15(m)))));
                % --------------------------------------------------------
                % store head_target node id
                fprintf(fid,'%s;',findnodeid(mat2str(cell2mat(C16(m)))));
                % --------------------------------------------------------
                % store grabbed node id
                fprintf(fid,'%s;',mat2str(cell2mat(C17(m))));
                prev_timestamp = C1(m); 
                % --------------------------------------------------------
                % store saccade magnitude
                fprintf(fid,'%.3f;',angle);
                % --------------------------------------------------------
                % record euler angles of head and eye
                % record distance between euler orientations
                head = head_index; eye = right_eye_index;
                axis_angle = [node(head).rx,node(head).ry,node(head).rz,node(head).w*pi/180];
                head_angles = axis2euler(axis_angle);
                axis_angle = [node(eye).rx,node(eye).ry,node(eye).rz,node(eye).w*pi/180];
                eye_angles = axis2euler(axis_angle);
                euler_distance = sqrt(((head_angles(1)-eye_angles(1)).^2)+((head_angles(2)-eye_angles(2)).^2)+((head_angles(3)-eye_angles(3)).^2));
                fprintf(fid,'%.3f;%.3f;%.3f;%.3f;%.3f;%.3f;%.3f\n',head_angles(1),head_angles(2),head_angles(3),eye_angles(1),eye_angles(2),eye_angles(3),euler_distance);
            end;
        %end;
    end;
end;
fclose(fid)

clear cube01_id cube02_id cube03_id cube04_id cube05_id cube06_id cube07_id cube08_id;
clear dummy01_id dummy02_id dummy03_id dummy04_id dummy05_id;
clear all;

%------------------------------------------------------------------------
function global_matrix = getglobmatrix(node1,body,head,eye)
if ((isempty(node1(body).x) == 1)|(isempty(node1(head).x) == 1)|(isempty(node1(eye).x) == 1))
    global_matrix = makehgtform;
    return;
end;
T = makehgtform('translate',[node1(body).x node1(body).y node1(body).z]);
AR = makehgtform('axisrotate',[node1(body).rx,node1(body).ry,node1(body).rz],node1(body).w*pi/180);
body_matrix = T * AR;
T = makehgtform('translate',[node1(head).x node1(head).y node1(head).z]);
AR = makehgtform('axisrotate',[node1(head).rx,node1(head).ry,node1(head).rz],node1(head).w*pi/180);
head_matrix = T * AR;
T = makehgtform('translate',[node1(eye).x node1(eye).y node1(eye).z]);
AR = makehgtform('axisrotate',[node1(eye).rx,node1(eye).ry,node1(eye).rz],node1(eye).w*pi/180);
eye_matrix = T * AR;
global_matrix = body_matrix * head_matrix * eye_matrix;
clear T AR body_matrix head_matrix eye_matrix;

%---------------------------------------
function objnode = findnodeid(tempstr)
global cube01_id cube02_id cube03_id cube04_id cube05_id cube06_id cube07_id cube08_id;
global dummy01_id dummy02_id dummy03_id dummy04_id dummy05_id;
switch upper(tempstr)
   case {'VIFS02-FACES','VIFS03-FACES','VIFS04-FACES','VIFS05-FACES','VIFS06-FACES','VIFS07-FACES'}
      objnode = cube01_id;
   case {'VIFS08-FACES','VIFS09-FACES','VIFS10-FACES','VIFS11-FACES','VIFS12-FACES','VIFS13-FACES'}
      objnode = cube02_id;
   case {'VIFS14-FACES','VIFS15-FACES','VIFS16-FACES','VIFS17-FACES','VIFS18-FACES','VIFS19-FACES'}
      objnode = cube03_id;
   case {'VIFS20-FACES','VIFS21-FACES','VIFS22-FACES','VIFS23-FACES','VIFS24-FACES','VIFS25-FACES'}
      objnode = cube04_id;
   case {'VIFS26-FACES','VIFS27-FACES','VIFS28-FACES','VIFS29-FACES','VIFS30-FACES','VIFS31-FACES'}
      objnode = cube05_id;
   case {'VIFS32-FACES','VIFS33-FACES','VIFS34-FACES','VIFS35-FACES','VIFS36-FACES','VIFS37-FACES'}
      objnode = cube06_id;
   case {'VIFS38-FACES','VIFS39-FACES','VIFS40-FACES','VIFS41-FACES','VIFS42-FACES','VIFS43-FACES'}
      objnode = cube07_id;
   case {'VIFS44-FACES','VIFS45-FACES','VIFS46-FACES','VIFS47-FACES','VIFS48-FACES','VIFS49-FACES'}
      objnode = cube08_id;
   case {'DUMMY_VIFS02-FACES','DUMMY_VIFS03-FACES','DUMMY_VIFS04-FACES','DUMMY_VIFS05-FACES','DUMMY_VIFS06-FACES','DUMMY_VIFS07-FACES'}
      objnode = dummy01_id;
   case {'DUMMY_VIFS08-FACES','DUMMY_VIFS09-FACES','DUMMY_VIFS10-FACES','DUMMY_VIFS11-FACES','DUMMY_VIFS12-FACES','DUMMY_VIFS13-FACES'}
      objnode = dummy02_id;
   case {'DUMMY_VIFS14-FACES','DUMMY_VIFS15-FACES','DUMMY_VIFS16-FACES','DUMMY_VIFS17-FACES','DUMMY_VIFS18-FACES','DUMMY_VIFS19-FACES'}
      objnode = dummy03_id;
   case {'DUMMY_VIFS20-FACES','DUMMY_VIFS21-FACES','DUMMY_VIFS22-FACES','DUMMY_VIFS23-FACES','DUMMY_VIFS24-FACES','DUMMY_VIFS25-FACES'}
      objnode = dummy04_id;
   case {'DUMMY_VIFS26-FACES','DUMMY_VIFS27-FACES','DUMMY_VIFS28-FACES','DUMMY_VIFS29-FACES','DUMMY_VIFS30-FACES','DUMMY_VIFS31-FACES'}
      objnode = dummy05_id;
   otherwise
      objnode = tempstr;
end

%---------------------------------------
function euler_angles = axis2euler(axis_angle)
x = axis_angle(1);
y = axis_angle(2);
z = axis_angle(3);
angle = axis_angle(4);
s=sin(angle);
c=cos(angle);
t=1-c;
%  normalise axis
magnitude = sqrt(x*x + y*y + z*z);
if (magnitude~=0) 
    x = x/magnitude;
    y = y/magnitude;
    z = z/magnitude;
end;
if ((x*y*t + z*s) > 0.998) % north pole singularity detected
    heading = 2*atan2(x*sin(angle/2),cos(angle/2));
    attitude = pi/2;
    bank = 0;
    euler_angles = [heading attitude bank];
    return;
end;
if ((x*y*t + z*s) < -0.998)  % south pole singularity detected
    heading = -2*atan2(x*sin(angle/2),cos(angle/2));
    attitude = -pi/2;
    bank = 0;
    euler_angles = [heading attitude bank];
    return;
end;
heading = atan2(y * s- x * z * t , 1 - (y*y+ z*z ) * t);
attitude = asin(x * y * t + z * s) ;
bank = atan2(x * s - y * z * t , 1 - (x*x + z*z) * t);
euler_angles = [heading attitude bank];