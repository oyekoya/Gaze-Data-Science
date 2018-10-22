%Euclidean Distance 
a1 = 19.11;  %(7.912, 30.32)
b1 = 1.834;  %(1.729, 1.938)
c1 = 0.8704;  %(0.586, 1.155)
a2 = 6.68;  %(2.328, 11.03)
b2 = 3.271;  %(1.405, 5.136)
c2 = 1.7;  %(0.305, 3.095)
x=0.5;
dist =  a1*exp(-((x-b1)/c1)^2) + a2*exp(-((x-b2)/c2)^2)

% Eccentricity
% Angular distance from the centre of gaze (head centric view).
a1 = 40.13; %(39.28, 40.97)
b1 = 14.39; %(14.31, 14.47)
c1 = 4.175; %(4.07, 4.28)
a2 = 8.089; %(5.318, 10.86)
b2 =-14.05; %(-36.16, 8.05)
c2 = 40.5; %(26.8, 54.2)
x=5;
eccentricity = a1*exp(-((x-b1)/c1)^2) + a2*exp(-((x-b2)/c2)^2)

% Saccade Magnitude
% Angle through which the eyeball rotates as it changes position from one target to another in the scene.
a = 128.3; %(121.8, 134.8)
b = -0.1729; %(-0.1806, -0.1652)
x=5;
sac_magnitude = a*exp(b*x)

% Fixation Duration
% Defined by the measure of the fixation duration on each target.
a = 38.74; %(-32.09, 109.6)
b = -0.001432; %(-0.004394, 0.00153)
c = 19.73; %(-69.63, 109.1)
d =-0.0005126; %(-0.001535, 0.0005099)
x=1500;
fix_dur = a*exp(b*x) + c*exp(d*x)

