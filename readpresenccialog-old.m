function readpresenccialog
figure
analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant02.log',0);
%analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant03.log');
%analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant04.log');
analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant05.log',3);
analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant06.log',6);
analyselog('F:/presenccia/ubitrack/branches/dtg_demo/participant07.log',9);
set(gcf, 'PaperPositionMode', 'auto');
print(gcf, '-r0', 'position_frequency.pdf', '-dpdf');
saveas(gcf,'position_frequency.png');
print_pdf('position_freq2.pdf',gcf);

function analyselog(file1,ind)
fid = fopen(file1);
%[C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22] = textread(file1,'%s%s%s%s%s%s%s%s%s%s%s%s%s%s%f%f%f%s%f%f%f%f', 'delimiter',':{}, []');
str = textread(file1,'%s', 'delimiter','\n');
file1
fclose(fid);

timestamp = 0;
count = 0;
plotvalues = zeros(30,75);
obj = struct('ior',{},'timestamp',{},'index',{});
x_val = 0; z_val = 0;

for x=1:size(str,1)
    [col1 D1] = strtok(str{x,1},' ');
    if ((isempty(strfind(char(str{x,1}),'Starting')) == 0) || (isempty(strfind(char(str{x,1}),'Stopping')) == 0))
        %start and end of file
        continue; %moves to next record
    end;
    [col2 D1] = strtok(D1,' ');
    [col3 D1] = strtok(D1,' ');
    [col4 D1] = strtok(D1,' ');
    [col5 D1] = strtok(D1,' ');
    [col6 D1] = strtok(D1,' ');
    [col7 D1] = strtok(D1,' ');
    [col8 D1] = strtok(D1,' ');
    [col9 D1] = strtok(D1,' ');
    [col10 D1] = strtok(D1,' ');
    if (isempty(strfind(char(str{x,1}),'adding')) == 0) 
        %if new object is added, extend array to accomodate
        count = count + 1;
        plotvalues(:,:,count) = 0;
        [col11 D1] = strtok(D1,' ');
        obj(count).ior = char(col11);
        obj(count).ior
        obj(count).timestamp = str2double(char(col3));
        continue; %moves to next record
    end;
    for r=1:count 
        if (strcmp(obj(r).ior,char(col10)) == 1)
            [col11 D1] = strtok(D1,'[');
            [col12 D1] = strtok(D1,'[,'); %x position
            [col13 D1] = strtok(D1,' ,'); %y position
            [col14 D1] = strtok(D1,' ],'); %z position
            duration = str2double(char(col3)) - obj(r).timestamp;
            obj(r).timestamp = str2double(char(col3));
            if ((str2double(char(col12)) > -1.5) && (str2double(char(col12)) < 1.5) && ...
              (str2double(char(col14)) > -5) && (str2double(char(col14)) < 2.5))
                x_val = ceil((str2double(char(col12))+1.5)*10);
                z_val = ceil((str2double(char(col14))+5)*10);
                plotvalues(x_val,z_val,r) = plotvalues(x_val,z_val,r) + duration;
            end;
            break;
        end;
    end;
end;
for y=1:count
    subplot(4,count,y+ind);
    bar3(plotvalues(:,:,y),0.2,'detached')
    view(-217.5,30);
    set(gca,'FontSize',6.5);
    set(gca,'YTickLabel',[-1.5;0;1.5]);
    set(gca,'XTickLabel',[0.5;-1.3;-3.1])
    if ((y+ind==1)||(y+ind==4)||(y+ind==7)||(y+ind==10))
        zlabel('frequency(secs)');
    end;
    if ((y+ind>=10)&&(y+ind<=12))
        ylabel('entrance');
        xlabel('towards posters');
    end;
end;
clear all;
