function varargout = plot_saliency(varargin)
% PLOT_SALIENCY M-file for plot_saliency.fig
%      PLOT_SALIENCY, by itself, creates a new PLOT_SALIENCY or raises the existing
%      singleton*.
%
%      H = PLOT_SALIENCY returns the handle to a new PLOT_SALIENCY or the handle to
%      the existing singleton*.
%
%      PLOT_SALIENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SALIENCY.M with the given input arguments.
%
%      PLOT_SALIENCY('Property','Value',...) creates a new PLOT_SALIENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_saliency_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_saliency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help plot_saliency

% Last Modified by GUIDE v2.5 17-Feb-2009 14:29:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_saliency_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_saliency_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before plot_saliency is made visible.
function plot_saliency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_saliency (see VARARGIN)

% Choose default command line output for plot_saliency
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

file1 = varargin{1}

% This sets up the initial plot - only do when we are invisible
% so window can get raised using plot_saliency.
if strcmp(get(hObject,'Visible'),'off')
    saliency_log(file1,1,100);
end

% UIWAIT makes plot_saliency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_saliency_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ---plot / update graphs
function plotall(handles,start,view_range)
axes(handles.axes1); matVal1 = get(gca,'UserData'); cla; 
X = matVal1(1,:); Y1_target = matVal1(2,:); Y1 = matVal1(3:end,:);
h1 = plot(X(:,start:start+view_range-1),Y1(:,start:start+view_range-1));
title('Eccentricity'); hold on;
plot(X(:,start:start+view_range-1),Y1_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; set(gca,'UserData',matVal1); 
axes(handles.axes2); matVal2 = get(gca,'UserData'); cla;
X = matVal2(1,:); Y2_target = matVal2(2,:); Y2 = matVal2(3:end,:);
h2 = plot(X(:,start:start+view_range-1),Y2(:,start:start+view_range-1));
title('Magnitude'); hold on;
plot(X(:,start:start+view_range-1),Y2_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; set(gca,'UserData',matVal2);
axes(handles.axes3); matVal3 = get(gca,'UserData'); cla;
X = matVal3(1,:); Y3_target = matVal3(2,:); Y3 = matVal3(3:end,:);
h3 = plot(X(:,start:start+view_range-1),Y3(:,start:start+view_range-1));
title('Distance'); hold on;
plot(X(:,start:start+view_range-1),Y3_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; set(gca,'UserData',matVal3);
axes(handles.axes4); matVal4 = get(gca,'UserData'); cla; 
X = matVal4(1,:); Y4_target = matVal4(2,:); Y4 = matVal4(3:end,:);
h4 = plot(X(:,start:start+view_range-1),Y4(:,start:start+view_range-1));
title('Velocity'); hold on;
plot(X(:,start:start+view_range-1),Y4_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; set(gca,'UserData',matVal4);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start = str2double(get(handles.edit1, 'String'));
size = get(gcf,'UserData');
start = start - 10;
if ((start > 1) && (start < size))
    view_range = str2double(get(handles.edit2, 'String'));
    plotall(handles,start,view_range);
    set(handles.edit1,'String',int2str(start)); 
end;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton4.
function pushbutton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
start = str2double(get(handles.edit1, 'String'));
view_range = str2double(get(handles.edit2, 'String'));
size = get(gcf,'UserData');
if ((start > 1) && (start < size))
    plotall(handles,start,view_range);
else
    set(handles.edit1,'String',int2str(1)); 
end;


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start = str2double(get(handles.edit1, 'String'));
view_range = str2double(get(handles.edit2, 'String'));
size = get(gcf,'UserData');
start = start + 10;
if ((start > 1) && (start < size))
    plotall(handles,start,view_range);
    set(handles.edit1,'String',int2str(start));
end;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton5.
function pushbutton5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
start = str2double(get(handles.edit1, 'String'));
view_range = str2double(get(handles.edit2, 'String'));
size = get(gcf,'UserData');
if ((view_range > 10) && (view_range < size))
    plotall(handles,start,view_range);
else
    set(handles.edit1,'String',int2str(100)); 
end;


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function saliency_log(file1, start, view_range)
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
% X = zeros(1,col);
% Y1 = zeros(row,col);
if (a~=1)
    %fprintf(fid,'%d - %d\n',n,n+1);
    for m=y(1,1):y(a-1,1)
        str = C2(m);
        str2 = C3(m);
        [token, str] = strtok(str, ';'); %skip first token 'NODE_SALIENCY'
        [token2, str2] = strtok(str2, ';'); %skip first token 'GAZE_TARGET'
        [token2, str2] = strtok(str2, ';'); %skip node id of gaze_target
        [token2, str2] = strtok(str2, ';'); %skip node id of gaze_target recorded in Player - may be incorrect
        [targetnodeid, str2] = strtok(str2, ';'); %get node id of gaze_target recorded in EyeCVE
        node_num = findnodeid(char(targetnodeid));
        Y1_target(1,j) = 0;
        Y2_target(1,j) = 0;
        Y3_target(1,j) = 0;
        Y4_target(1,j) = 0;
        while true
            if isempty(char(token))
                i = 1;
                break; 
            end
            [nodeid, str] = strtok(str, ';'); %get node id
            [token, str] = strtok(str, ';'); %get eccentricity
            Y1(i,j) = str2double(char(token));
            [token, str] = strtok(str, ';'); %get magnitude
            magnitude = str2double(char(token));
            Y2(i,j) = magnitude;
            [token, str] = strtok(str, ';'); %get bounding volume (local)
            [token, str] = strtok(str, ';'); %skip bounding volume (world)
            [token, str] = strtok(str, ';'); %get eye distance
            Y3(i,j) = str2double(char(token));
            % calc velocity deg/sec
            Y4(i,j) = magnitude/str2double(char(timestamp_diff(m)))*0.001; 
            %store gaze_target values
            if (node_num == 0) %compare strings if not a cube
                if ( strcmp(nodeid, targetnodeid) == 1) 
                    Y1_target(1,j) = Y1(i,j);
                    Y2_target(1,j) = Y2(i,j);
                    Y3_target(1,j) = Y3(i,j);
                    Y4_target(1,j) = Y4(i,j);
                end;
            else %it's a cube
                if (i == node_num) %get right node id
                    Y1_target(1,j) = Y1(i,j);
                    Y2_target(1,j) = Y2(i,j);
                    Y3_target(1,j) = Y3(i,j);
                    Y4_target(1,j) = Y4(i,j);
                end;
            end;
            i = i + 1;
        end;
        time = time + str2double(char(timestamp_diff(m)));
        X(1,j) = time;
        j = j + 1;
    end;
end;
axes(findobj('Tag','axes1'));
h1 = plot(X(:,start:start+view_range-1),Y1(:,start:start+view_range-1));
title('Eccentricity'); hold on;
plot(X(:,start:start+view_range-1),Y1_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; matVal1 = [X; Y1_target; Y1];
set(gca,'UserData',matVal1);
axes(findobj('Tag','axes2'));
h2 = plot(X(:,start:start+view_range-1),Y2(:,start:start+view_range-1));
title('Magnitude'); hold on;
plot(X(:,start:start+view_range-1),Y2_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; matVal2 = [X; Y2_target; Y2];
set(gca,'UserData',matVal2);
axes(findobj('Tag','axes3'));
h3 = plot(X(:,start:start+view_range-1),Y3(:,start:start+view_range-1));
title('Distance'); hold on;
plot(X(:,start:start+view_range-1),Y3_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; matVal3 = [X; Y3_target; Y3];
set(gca,'UserData',matVal3);
axes(findobj('Tag','axes4'));
h4 = plot(X(:,start:start+view_range-1),Y4(:,start:start+view_range-1));
title('Velocity'); hold on;
plot(X(:,start:start+view_range-1),Y4_target(:,start:start+view_range-1),'LineWidth',2,'Color','k');
hold off; matVal4 = [X; Y4_target; Y4];
set(gca,'UserData',matVal4);
set(h1,'EraseMode','xor');
set(h2,'EraseMode','xor');
set(h3,'EraseMode','xor');
set(h4,'EraseMode','xor');
[d1,d2] = size(X);
set(gcf,'UserData',d2);
% for p=view_range+1:d2
%    drawnow
%    XX = X(:,p-view_range:p-1);
%    YY = Y1(:,p-view_range:p-1);
%    set(h,'XData',XX,'YData',YY)
% end

%---------------------------------------
%assumes that the cube nodes were added to the scene in the order below
function nodenum = findnodeid(tempstr)
switch upper(tempstr)
   case {'VIFS02-FACES','VIFS03-FACES','VIFS04-FACES','VIFS05-FACES','VIFS06-FACES','VIFS07-FACES'}
      nodenum = 1;
   case {'VIFS08-FACES','VIFS09-FACES','VIFS10-FACES','VIFS11-FACES','VIFS12-FACES','VIFS13-FACES'}
      nodenum = 2;
   case {'VIFS14-FACES','VIFS15-FACES','VIFS16-FACES','VIFS17-FACES','VIFS18-FACES','VIFS19-FACES'}
      nodenum = 3;
   case {'VIFS20-FACES','VIFS21-FACES','VIFS22-FACES','VIFS23-FACES','VIFS24-FACES','VIFS25-FACES'}
      nodenum = 4;
   case {'VIFS26-FACES','VIFS27-FACES','VIFS28-FACES','VIFS29-FACES','VIFS30-FACES','VIFS31-FACES'}
      nodenum = 5;
   case {'VIFS32-FACES','VIFS33-FACES','VIFS34-FACES','VIFS35-FACES','VIFS36-FACES','VIFS37-FACES'}
      nodenum = 6;
   case {'VIFS38-FACES','VIFS39-FACES','VIFS40-FACES','VIFS41-FACES','VIFS42-FACES','VIFS43-FACES'}
      nodenum = 7;
   case {'VIFS44-FACES','VIFS45-FACES','VIFS46-FACES','VIFS47-FACES','VIFS48-FACES','VIFS49-FACES'}
      nodenum = 8;
   case {'DUMMY_VIFS02-FACES','DUMMY_VIFS03-FACES','DUMMY_VIFS04-FACES','DUMMY_VIFS05-FACES','DUMMY_VIFS06-FACES','DUMMY_VIFS07-FACES'}
      nodenum = 9;
   case {'DUMMY_VIFS08-FACES','DUMMY_VIFS09-FACES','DUMMY_VIFS10-FACES','DUMMY_VIFS11-FACES','DUMMY_VIFS12-FACES','DUMMY_VIFS13-FACES'}
      nodenum = 10;
   case {'DUMMY_VIFS14-FACES','DUMMY_VIFS15-FACES','DUMMY_VIFS16-FACES','DUMMY_VIFS17-FACES','DUMMY_VIFS18-FACES','DUMMY_VIFS19-FACES'}
      nodenum = 11;
   case {'DUMMY_VIFS20-FACES','DUMMY_VIFS21-FACES','DUMMY_VIFS22-FACES','DUMMY_VIFS23-FACES','DUMMY_VIFS24-FACES','DUMMY_VIFS25-FACES'}
      nodenum = 12;
   case {'DUMMY_VIFS26-FACES','DUMMY_VIFS27-FACES','DUMMY_VIFS28-FACES','DUMMY_VIFS29-FACES','DUMMY_VIFS30-FACES','DUMMY_VIFS31-FACES'}
      nodenum = 13;
   otherwise
      nodenum = 0;
end


