function preference_matrix()
%scenetype,eyetype1,eyetype2,question1-3
allscenes = zeros(3,4,4,3); %1-conversation 2-cubes 3-miltonkeynes (add all for total)
for a=1:228
    file1 = sprintf('emails\\Gaze Model Experiment (%d).eml',a);
	fid = fopen(file1);
	[D] = textread(file1,'%s', 'delimiter','\n');
	fclose(fid);
    [a1 a2] = size(D);
    for b=1:a1
        if (isempty(strfind(char(D(b)),'Question 1:')) == 0)
            b = b + 2;
            overall = D(b);
            b = b + 5;
            eyes = D(b);
            b = b + 5;
            eyelid = D(b);
            b = b + 3;
            for c=b:(b+17)
                %get the answers for this pair
                [overall_answer overall] = strtok(char(overall),',');
                [eyes_answer eyes] = strtok(char(eyes),',');
                [eyelid_answer eyelid] = strtok(char(eyelid),',');
                %then get the pair (eyetype1, eyetype2 and scenetype) to determine appropriate portion of array to increment
                pair = D(c);
                [notneeded pair] = strtok(char(pair),'//_.');% 'animations'
                [scenetype pair] = strtok(char(pair),'//_.');% 'conversation', 'cubes' or 'miltonkeynes'
                [eyetype1 pair] = strtok(char(pair),'//_.');% 'model', 'tracked', 'random' or 'static'
                [notneeded pair] = strtok(char(pair),'//_.');% 'flv vs animations'
                [notneeded pair] = strtok(char(pair),'//_.');% 'conversation', 'cubes' or 'miltonkeynes'
                [eyetype2 pair] = strtok(char(pair),'//_.');% 'model', 'tracked', 'random' or 'static'
                for p=1:3
                    switch (p)
                        case 1
                            tempstr = overall_answer;
                        case 2
                            tempstr = eyes_answer;
                        case 3
                            tempstr = eyelid_answer;
                    end;
                    switch (tempstr)
                        case eyetype1
                            allscenes(getrow(scenetype),getrow(eyetype1),getrow(eyetype2),p) = allscenes(getrow(scenetype),getrow(eyetype1),getrow(eyetype2),p) + 1;
                        case eyetype2
                            allscenes(getrow(scenetype),getrow(eyetype2),getrow(eyetype1),p) = allscenes(getrow(scenetype),getrow(eyetype2),getrow(eyetype1),p) + 1;
                        case 'equal'
                            allscenes(getrow(scenetype),getrow(eyetype1),getrow(eyetype2),p) = allscenes(getrow(scenetype),getrow(eyetype1),getrow(eyetype2),p) + 0.5;
                            allscenes(getrow(scenetype),getrow(eyetype2),getrow(eyetype1),p) = allscenes(getrow(scenetype),getrow(eyetype2),getrow(eyetype1),p) + 0.5;
                        otherwise
                            disp('something is wrong with increment')
                    end;
                end;
            end;
            break;
        end;
    end;
end;
fid = fopen('output.log','w');
fprintf(fid,'conversation\n');
fprintf(fid,'      \tQuestion\ttracked\tmodel\trandom\tstatic\n');
fprintf(fid,'tracked\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,1,1,1),allscenes(1,1,2,1),allscenes(1,1,3,1),allscenes(1,1,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,1,1,2),allscenes(1,1,2,2),allscenes(1,1,3,2),allscenes(1,1,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,1,1,3),allscenes(1,1,2,3),allscenes(1,1,3,3),allscenes(1,1,4,3));
fprintf(fid,'model\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,2,1,1),allscenes(1,2,2,1),allscenes(1,2,3,1),allscenes(1,2,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,2,1,2),allscenes(1,2,2,2),allscenes(1,2,3,2),allscenes(1,2,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,2,1,3),allscenes(1,2,2,3),allscenes(1,2,3,3),allscenes(1,2,4,3));
fprintf(fid,'random\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,3,1,1),allscenes(1,3,2,1),allscenes(1,3,3,1),allscenes(1,3,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,3,1,2),allscenes(1,3,2,2),allscenes(1,3,3,2),allscenes(1,3,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,3,1,3),allscenes(1,3,2,3),allscenes(1,3,3,3),allscenes(1,3,4,3));
fprintf(fid,'static\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,4,1,1),allscenes(1,4,2,1),allscenes(1,4,3,1),allscenes(1,4,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,4,1,2),allscenes(1,4,2,2),allscenes(1,4,3,2),allscenes(1,4,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(1,4,1,3),allscenes(1,4,2,3),allscenes(1,4,3,3),allscenes(1,4,4,3));
fprintf(fid,'\ncubes\n');
fprintf(fid,'      \tQuestion\ttracked\tmodel\trandom\tstatic\n');
fprintf(fid,'tracked\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,1,1,1),allscenes(2,1,2,1),allscenes(2,1,3,1),allscenes(2,1,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,1,1,2),allscenes(2,1,2,2),allscenes(2,1,3,2),allscenes(2,1,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,1,1,3),allscenes(2,1,2,3),allscenes(2,1,3,3),allscenes(2,1,4,3));
fprintf(fid,'model\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,2,1,1),allscenes(2,2,2,1),allscenes(2,2,3,1),allscenes(2,2,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,2,1,2),allscenes(2,2,2,2),allscenes(2,2,3,2),allscenes(2,2,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,2,1,3),allscenes(2,2,2,3),allscenes(2,2,3,3),allscenes(2,2,4,3));
fprintf(fid,'random\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,3,1,1),allscenes(2,3,2,1),allscenes(2,3,3,1),allscenes(2,3,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,3,1,2),allscenes(2,3,2,2),allscenes(2,3,3,2),allscenes(2,3,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,3,1,3),allscenes(2,3,2,3),allscenes(2,3,3,3),allscenes(2,3,4,3));
fprintf(fid,'static\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,4,1,1),allscenes(2,4,2,1),allscenes(2,4,3,1),allscenes(2,4,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,4,1,2),allscenes(2,4,2,2),allscenes(2,4,3,2),allscenes(2,4,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(2,4,1,3),allscenes(2,4,2,3),allscenes(2,4,3,3),allscenes(2,4,4,3));
fprintf(fid,'\nmiltonkeynes\n');
fprintf(fid,'      \tQuestion\ttracked\tmodel\trandom\tstatic\n');
fprintf(fid,'tracked\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,1,1,1),allscenes(3,1,2,1),allscenes(3,1,3,1),allscenes(3,1,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,1,1,2),allscenes(3,1,2,2),allscenes(3,1,3,2),allscenes(3,1,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,1,1,3),allscenes(3,1,2,3),allscenes(3,1,3,3),allscenes(3,1,4,3));
fprintf(fid,'model\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,2,1,1),allscenes(3,2,2,1),allscenes(3,2,3,1),allscenes(3,2,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,2,1,2),allscenes(3,2,2,2),allscenes(3,2,3,2),allscenes(3,2,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,2,1,3),allscenes(3,2,2,3),allscenes(3,2,3,3),allscenes(3,2,4,3));
fprintf(fid,'random\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,3,1,1),allscenes(3,3,2,1),allscenes(3,3,3,1),allscenes(3,3,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,3,1,2),allscenes(3,3,2,2),allscenes(3,3,3,2),allscenes(3,3,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,3,1,3),allscenes(3,3,2,3),allscenes(3,3,3,3),allscenes(3,3,4,3));
fprintf(fid,'static\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,4,1,1),allscenes(3,4,2,1),allscenes(3,4,3,1),allscenes(3,4,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,4,1,2),allscenes(3,4,2,2),allscenes(3,4,3,2),allscenes(3,4,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(3,4,1,3),allscenes(3,4,2,3),allscenes(3,4,3,3),allscenes(3,4,4,3));
allscenes
allscenes(4,:,:,:) = allscenes(1,:,:,:) + allscenes(2,:,:,:) + allscenes(3,:,:,:);
fprintf(fid,'\nTotal (all scenes)\n');
fprintf(fid,'      \tQuestion\ttracked\tmodel\trandom\tstatic\n');
fprintf(fid,'tracked\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,1,1,1),allscenes(4,1,2,1),allscenes(4,1,3,1),allscenes(4,1,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,1,1,2),allscenes(4,1,2,2),allscenes(4,1,3,2),allscenes(4,1,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,1,1,3),allscenes(4,1,2,3),allscenes(4,1,3,3),allscenes(4,1,4,3));
fprintf(fid,'model\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,2,1,1),allscenes(4,2,2,1),allscenes(4,2,3,1),allscenes(4,2,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,2,1,2),allscenes(4,2,2,2),allscenes(4,2,3,2),allscenes(4,2,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,2,1,3),allscenes(4,2,2,3),allscenes(4,2,3,3),allscenes(4,2,4,3));
fprintf(fid,'random\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,3,1,1),allscenes(4,3,2,1),allscenes(4,3,3,1),allscenes(4,3,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,3,1,2),allscenes(4,3,2,2),allscenes(4,3,3,2),allscenes(4,3,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,3,1,3),allscenes(4,3,2,3),allscenes(4,3,3,3),allscenes(4,3,4,3));
fprintf(fid,'static\toverall\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,4,1,1),allscenes(4,4,2,1),allscenes(4,4,3,1),allscenes(4,4,4,1));
fprintf(fid,'      \teyes\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,4,1,2),allscenes(4,4,2,2),allscenes(4,4,3,2),allscenes(4,4,4,2));
fprintf(fid,'      \teyelid\t%.1f\t%.1f\t%.1f\t%.1f\n',allscenes(4,4,1,3),allscenes(4,4,2,3),allscenes(4,4,3,3),allscenes(4,4,4,3));
fclose(fid);

function index = getrow(type)
	switch lower(type)
       case {'tracked','conversation'}
          index = 1;
       case {'model','cubes'}
          index = 2;
       case {'random','miltonkeynes'}
          index = 3;
      case 'static'
          index = 4;
      otherwise
          disp('something is wrong with getrow')
	end;
end;

