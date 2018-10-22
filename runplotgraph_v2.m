%cubes puzzle
[x1,y1(1,:),x2,y2(1,:),x3,y3(1,:),x4,y4(1,:)] = plot_graph('tracked_cubes1_params.log','12b.jpg');
[x1,y1(2,:),x2,y2(2,:),x3,y3(2,:),x4,y4(2,:)] = plot_graph('random_cubes_params.log','12b.jpg');
[x1,y1(3,:),x2,y2(3,:),x3,y3(3,:),x4,y4(3,:)] = plot_graph('model_cubes1_params.log','12b.jpg');
%[x1,y1(4,:),x2,y2(4,:),x3,y3(4,:),x4,y4(4,:)] = plot_graph('static_cubes_params.log','12b.jpg');
[x8,y8(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes2.log','12b.png');
[x8,y8(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes2_r.log','12b.png');
[x8,y8(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes2_m.log','12b.png');
%[x8,y8(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes2_s.log','12b.png');

scrsz = get(0,'ScreenSize');
%set(0,'DefaultAxesColorOrder',[0 0 0.05;0 0.95 0;0.8 0 0]);
set(0,'DefaultAxesColorOrder',[1 0 0;0 0.95 0],...
      'DefaultAxesLineStyleOrder','-|:')
figure('Position',[1 scrsz(4)/2.2 scrsz(3)*0.7 scrsz(4)/2.2],'Color','white'),
subplot(3,5,5); set(gca,'FontSize',6.5); h = plot(x1,y1);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('view proximity (feet)');
%ylabel('Percentage of Occurrence (%)');
%title('Proximity');


subplot(3,5,1); set(gca,'FontSize',6.5); h = plot(x2,y2);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('eccentricity (degrees)');
ylabel('Percentage of Occurrence (%)'); 
%title('Eccentricity');
title('Scene: Puzzle','FontWeight','bold');

subplot(3,5,2); set(gca,'FontSize',6.5); h = plot(x3,y3);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('saccade velocity (degrees/sec)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Velocity');

subplot(3,5,3); set(gca,'FontSize',6.5); h = plot(x4,y4); 
set(h,'LineWidth',0.85);
legend('tracked','random','saliency','Orientation','horizontal','Location','NorthOutside');
%xlabel('saccade magnitude (degrees)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Magnitude');

subplot(3,5,4); set(gca,'FontSize',6.5); h = plot(x8,y8);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('fixation duration (milliseconds)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Fixation Duration (cubes - same log)');

%set(gcf, 'PaperPositionMode', 'auto');
%print(gcf, '-r0', 'cubes_plots.pdf', '-dpdf');
%saveas(gcf,'cubes_plots.pdf');
%saveas(gcf,'cubes_plots.eps');
clear tmp scrsz;
save('cubes.mat');
clear all;

%conversation
[x1,y1(1,:),x2,y2(1,:),x3,y3(1,:),x4,y4(1,:)] = plot_graph('tracked_meetingroom_params.log','12b.jpg');
[x1,y1(2,:),x2,y2(2,:),x3,y3(2,:),x4,y4(2,:)] = plot_graph('random_meetingroom_params.log','12b.jpg');
[x1,y1(3,:),x2,y2(3,:),x3,y3(3,:),x4,y4(3,:)] = plot_graph('model_conversation1_params.log','12b.jpg');
%[x1,y1(4,:),x2,y2(4,:),x3,y3(4,:),x4,y4(4,:)] = plot_graph('static_meetingroom_params.log','12b.jpg');
[x7,y7(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_conversation.log','12b.png');
[x7,y7(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_conversation_r.log','12b.png');
[x7,y7(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_conversation_m.log','12b.png');
%[x7,y7(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_conversation_s.log','12b.png');

%scrsz = get(0,'ScreenSize');
%figure('Position',[1 scrsz(4)/6.5 scrsz(3)*0.65 scrsz(4)/6.5],'Color','white'),
subplot(3,5,10); set(gca,'FontSize',6.5); h = plot(x1,y1);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('view proximity (feet)');
%ylabel('Percentage of Occurrence (%)');
%title('Proximity');

subplot(3,5,6); set(gca,'FontSize',6.5); h = plot(x2,y2);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('eccentricity (degrees)');
ylabel('Percentage of Occurrence (%)'); 
%title('Eccentricity');
title('Scene: Conversation','FontWeight','bold');

subplot(3,5,7); set(gca,'FontSize',6.5); h = plot(x3,y3);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('saccade velocity (degrees/sec)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Velocity');

subplot(3,5,8); set(gca,'FontSize',6.5); h = plot(x4,y4);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('saccade magnitude (degrees)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Magnitude');

subplot(3,5,9); set(gca,'FontSize',6.5); h = plot(x7,y7);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
%xlabel('fixation duration (milliseconds)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Fixation Duration (conversation - same log)');

%set(gcf, 'PaperPositionMode', 'auto');
%print(gcf, '-r0', 'conversation_plots.pdf', '-dpdf');
%saveas(gcf,'conversation_plots.pdf');
%saveas(gcf,'conversation_plots.eps');
clear tmp;
save('conversation.mat');
clear all;


%navigation through milton_keynes
[x1,y1(1,:),x2,y2(1,:),x3,y3(1,:),x4,y4(1,:)] = plot_graph('tracked_milton_keynes_params.log','12b.jpg');
[x1,y1(2,:),x2,y2(2,:),x3,y3(2,:),x4,y4(2,:)] = plot_graph('random_milton_keynes_params.log','12b.jpg');
[x1,y1(3,:),x2,y2(3,:),x3,y3(3,:),x4,y4(3,:)] = plot_graph('model_miltonkeynes2_params.log','12b.jpg');
%[x1,y1(4,:),x2,y2(4,:),x3,y3(4,:),x4,y4(4,:)] = plot_graph('static_milton_keynes_params.log','12b.jpg');
[x6,y6(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes.log','12b.png');
[x6,y6(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes_r.log','12b.png');
[x6,y6(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes_m.log','12b.png');
%[x6,y6(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes_s.log','12b.png');

%scrsz = get(0,'ScreenSize');
%figure('Position',[1 scrsz(4)/6.5 scrsz(3)*0.65 scrsz(4)/6.5],'Color','white'),
subplot(3,5,15); set(gca,'FontSize',6.5); h = plot(x1,y1);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
xlabel('View Proximity (feet)');
%ylabel('Percentage of Occurrence (%)');
%title('Proximity');

subplot(3,5,11); set(gca,'FontSize',6.5); h = plot(x2,y2);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
xlabel('Eccentricity (degrees)');
ylabel('Percentage of Occurrence (%)'); 
%title('Eccentricity');
title('Scene: Navigation','FontWeight','bold');

subplot(3,5,12); set(gca,'FontSize',6.5); h = plot(x3,y3);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
xlabel('Saccade Velocity (degrees/sec)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Velocity');

subplot(3,5,13); set(gca,'FontSize',6.5); h = plot(x4,y4);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
xlabel('Saccade Magnitude (degrees)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Saccade Magnitude');

subplot(3,5,14); set(gca,'FontSize',6.5); h = plot(x6,y6);
set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
xlabel('Fixation Duration (milliseconds)');
%ylabel('Percentage of Occurrence (%)'); 
%title('Fixation Duration (street - same log)');

set(gcf, 'PaperPositionMode', 'auto');
%print(gcf, '-r300', 'plots_scenes.pdf', '-dpdf');
print_pdf('plots_scenes.pdf',gcf);
%saveas(gcf,'miltonkeyenes_plots.pdf');
%saveas(gcf,'miltonkeyenes_plots.eps');
clear tmp;
save('town.mat');
clear all;

% [x5,y5(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('randomtarget_meetingroom.log','12b.png');
% [x5,y5(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('modeltarget_meetingroom.log','12b.png');
% [x5,y5(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('statictarget_meetingroom.log','12b.png');
% [x5,y5(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_meetingroom.log','12b.png');
% 
% [x6,y6(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_meetingroom_r.log','12b.png');
% [x6,y6(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_meetingroom_m.log','12b.png');
% [x6,y6(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_meetingroom_s.log','12b.png');
% [x6,y6(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_meetingroom.log','12b.png');
% 
% [x7,y7(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('randomtarget_cubes.log','12b.png');
% [x7,y7(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('modeltarget_cubes.log','12b.png');
% [x7,y7(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('statictarget_cubes.log','12b.png');
% [x7,y7(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes.log','12b.png');
% 
% [x8,y8(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes_r.log','12b.png');
% [x8,y8(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes_m.log','12b.png');
% [x8,y8(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes_s.log','12b.png');
% [x8,y8(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_cubes.log','12b.png');
% 
% figure, subplot(1,5,1); set(gca,'FontSize',6.5); h = plot(x5,y5)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)');
% %title('Fixation Duration (conversation)');
% 
% subplot(1,5,2); set(gca,'FontSize',6.5);plot(x6,y6)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)'); 
% %title('Fixation Duration (conversation - same log)');
% 
% subplot(1,5,3); set(gca,'FontSize',6.5); h = plot(x7,y7)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)'); 
% %title('Fixation Duration (cubes)');
% 
% subplot(1,5,4); set(gca,'FontSize',6.5); h = plot(x8,y8)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)'); 
% %title('Fixation Duration (cubes - same log)');
% 
% saveas(gcf,'fix_dur_data1_plots.png');
% %saveas(gcf,'fix_dur_data1_plots.eps');
% clear x5 y5 x6 y6 x7 y7 x8 y8;
% 
% [x5,y5(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('randomtarget_milton_keynes.log','12b.png');
% [x5,y5(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('modeltarget_milton_keynes.log','12b.png');
% [x5,y5(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('statictarget_milton_keynes.log','12b.png');
% [x5,y5(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes.log','12b.png');
% 
% 
% figure, subplot(1,5,1); set(gca,'FontSize',6.5); h = plot(x5,y5)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)');
% %title('Fixation Duration (street)');
% 
% saveas(gcf,'fix_dur_data1and2_plots.png');
% %saveas(gcf,'fix_dur_data1and2_plots.eps');
% clear x5 y5 x6 y6 x7 y7 x8 y8;
% 
% [x5,y5(1,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes2_r.log','12b.png');
% [x5,y5(2,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes2_m.log','12b.png');
% [x5,y5(3,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes2_s.log','12b.png');
% [x5,y5(4,:),tmp,tmp,tmp,tmp] = plot_fixation_graph('trackedtarget_milton_keynes2.log','12b.png');
% 
% figure,subplot(1,5,1); set(gca,'FontSize',6.5); h = plot(x5,y5)
% set(h,'LineWidth',0.85); %legend('random','model','static','tracked');
% xlabel('fixation duration (milliseconds)');
% %ylabel('Percentage of Occurrence (%)'); 
% %title('Fixation Duration (milton keynes - same log)');
% 
% saveas(gcf,'fix_dur_data2_plots.png');
% %saveas(gcf,'fix_dur_data2_plots.eps');
% clear x5 y5;
