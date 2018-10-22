%for index=1000:1000:6000
index=5000;
for count=1:6
    file = sprintf('F:\\gaze_model\\part%dsession2.log',count);
    %miltonkeynes
    [Y1(count,1),Y1(count,2),Y1(count,3)]=match_equalityv2(file,'miltonkeynes.txt','miltonkeynes_bbox_values.txt',index);
    %cubes
    file = sprintf('F:\\gaze_model\\part%dsession1.log',count);
    [Y2(count,1),Y2(count,2),Y2(count,3)]=match_equalityv2(file,'cubes.txt','cubes_bbox_values.txt',index);
end;
index
Y1
Y2
%end;
% %conversation/furniture
% [Y3(1,1),Y3(1,2),Y3(1,3)]=match_equality('../data/tracked_conversation2.log','conversation.txt','conversation_bbox_values.txt');
% Y3
% 
% X = [1 2 3];
% X1 = [0.90 1.90 2.90];
% X2 = [1.00 2.00 3.00];
% X3 = [1.10 2.10 3.10];
% 
% scrsz = get(0,'ScreenSize');
% figure('Position',[1 scrsz(4)/2 scrsz(3)/8 scrsz(4)/2],'Color','white'),
% subplot(3,1,1); 
% plot(X,Y1,'--rs','LineStyle','none',...
%                  'MarkerEdgeColor','k',...
%                  'MarkerFaceColor','g',...
%                  'MarkerSize',8)
% set(gca,'XTickMode','manual','XTick',[1 2 3],'FontSize',6.5); xlim([0 4]);
% xlabel({'Target Conditions:';'1 (head-target = eye-target)';'2 (model-target = eye-target)';'3 (random-target = eye-target)'});
% ylabel('Percentage of Occurrence (%)');
% title('Street');
% %saveas(gca,'street_performance.bmp');
% %saveas(gca,'street_performance.eps');
% 
% subplot(3,1,2); 
% plot(X,Y2,'--rs','LineStyle','none',...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',8)
% set(gca,'XTickMode','manual','XTick',[1 2 3],'FontSize',6.5); xlim([0 4]);
% xlabel({'Target Conditions:';'1 (head-target = eye-target)';'2 (model-target = eye-target)';'3 (random-target = eye-target)'});
% ylabel('Percentage of Occurrence (%)');
% title('Cubes');
% %saveas(gca,'cubes_performance.bmp');
% %saveas(gca,'cubes_performance.eps');
% 
% subplot(3,1,3); 
% plot(X,Y3,'--rs','LineStyle','none',...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','g',...
%                 'MarkerSize',8)
% set(gca,'XTickMode','manual','XTick',[1 2 3],'FontSize',6.5); xlim([0 4]);
% xlabel({'Target Conditions:';'1 (head-target = eye-target)';'2 (model-target = eye-target)';'3 (random-target = eye-target)'});
% ylabel('Percentage of Occurrence (%)');
% title('Conversation');
% saveas(gca,'6subj_performance.png');
% saveas(gca,'6subj_performance.bmp');
% saveas(gca,'6subj_performance.eps');
% 
% % Y_combined = [Y1; Y2; Y3];
% % subplot(2,2,4); set(gca,'FontSize',8); 
% % plot(X,Y_combined,'--rs','LineStyle','none',...
% %                 'MarkerEdgeColor','k',...
% %                 'MarkerFaceColor','g',...
% %                 'MarkerSize',8)
% % xlabel({'Target Conditions:';'1 (head-target = eye-target)';'2 (model-target = eye-target)';'3 (random-target = eye-target)'});
% % ylabel('Percentage of Occurrence (%)');
% % title('Street, Cubes and Conversation');
% % saveas(gca,'performance.bmp');
% % saveas(gca,'performance1.eps');
% % 
% % figure, plot([X1; X2; X3],Y_combined,'--rs','LineStyle','none',...
% %                 'MarkerEdgeColor','k',...
% %                 'MarkerFaceColor','r',...
% %                 'MarkerSize',8)
% % xlabel({'Target Conditions:';'1 (head-target = eye-target)';'2 (model-target = eye-target)';'3 (random-target = eye-target)'});
% % ylabel('Percentage of Occurrence (%)');
% % title('Street, Cubes and Conversation');
% % saveas(gca,'performance_combined.bmp');
% % saveas(gca,'performance_combined.eps');
% 
% %clear Y Y_model Y1 Y2 Y_combined;
clear all;
