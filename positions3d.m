function positions3d
scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3)/5 scrsz(4)/2],'Color','white'),
plot3d('nodevalues_conversation.txt','conversation_3dplot.png','conversation_3dplot.eps',1);
plot3d('nodevalues_cubes.txt','cubes_3dplot.png','cubes_3dplot.eps',2);
plot3d('nodevalues_miltonkeynes.txt','miltonkeynes_3dplot.png','miltonkeynes_3dplot.eps',3);

function plot3d(file1,file2,file3,index)
fid = fopen(file1);%'sfd_client_spec_modified_05c_2.log'
[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20] = textread(file1,'%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter',',');
fclose(fid);

subplot(3,1,index); set(gca,'FontSize',6.5);
[a1 a2] = size(C1);
for b=1:a1
	vertex_data = [C9(b) C10(b) C11(b);C12(b) C10(b) C11(b);C12(b) C13(b) C11(b);C9(b) C13(b) C11(b);C9(b) C10(b) C14(b);C12(b) C10(b) C14(b);C12(b) C13(b) C14(b);C9(b) C13(b) C14(b)];
	%vertex_data2 = [0 0 0;0.5 0 0;0.5 0.5 0;0 0.5 0;0 0 0.5;0.5 0 0.5;0.5 0.5 0.5;0 0.5 0.5];
	face_data = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
	patch('Vertices',vertex_data,'Faces',face_data,'FaceAlpha',0)
	%patch('Vertices',vertex_data2,'Faces',face_data,'FaceAlpha',0.1)
	view([-10 -10]); axis square
end;

% figure, plot3(C2,C4,C3,'--rs','LineStyle','none',...
%                 'MarkerEdgeColor','k',...
%                 'MarkerFaceColor','r',...
%                 'MarkerSize',10)
% if (isempty(strfind(file1,'miltonkeynes'))==0)
%     set(gca,'XLim',[-200 200])
% end;
% grid on
%axis square
saveas(gca,file2);
%saveas(gca,file3);