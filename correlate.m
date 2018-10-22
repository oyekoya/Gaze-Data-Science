% correlation values
fid = fopen('correlation.log','w');
load town;
fprintf(fid,'town\n');
fprintf(fid,'proximity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y1(1,:),y1(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y1(1,:),y1(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y1(2,:),y1(3,:)));
fprintf(fid,'eccentricity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y2(1,:),y2(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y2(1,:),y2(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y2(2,:),y2(3,:)));
fprintf(fid,'velocity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y3(1,:),y3(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y3(1,:),y3(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y3(2,:),y3(3,:)));
fprintf(fid,'magnitude\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y4(1,:),y4(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y4(1,:),y4(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y4(2,:),y4(3,:)));
fprintf(fid,'fixation duration\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y6(1,:),y6(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y6(1,:),y6(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y6(2,:),y6(3,:)));
clear x1 x2 x3 x4 x6 y1 y2 y3 y4 y6;
load conversation;
fprintf(fid,'conversation\n');
fprintf(fid,'proximity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y1(1,:),y1(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y1(1,:),y1(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y1(2,:),y1(3,:)));
fprintf(fid,'eccentricity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y2(1,:),y2(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y2(1,:),y2(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y2(2,:),y2(3,:)));
fprintf(fid,'velocity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y3(1,:),y3(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y3(1,:),y3(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y3(2,:),y3(3,:)));
fprintf(fid,'magnitude\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y4(1,:),y4(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y4(1,:),y4(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y4(2,:),y4(3,:)));
fprintf(fid,'fixation duration\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y7(1,:),y7(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y7(1,:),y7(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y7(2,:),y7(3,:)));
clear x1 x2 x3 x4 x7 y1 y2 y3 y4 y7;
load cubes;
fprintf(fid,'cubes\n');
fprintf(fid,'proximity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y1(1,:),y1(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y1(1,:),y1(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y1(2,:),y1(3,:)));
fprintf(fid,'eccentricity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y2(1,:),y2(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y2(1,:),y2(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y2(2,:),y2(3,:)));
fprintf(fid,'velocity\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y3(1,:),y3(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y3(1,:),y3(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y3(2,:),y3(3,:)));
fprintf(fid,'magnitude\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y4(1,:),y4(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y4(1,:),y4(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y4(2,:),y4(3,:)));
fprintf(fid,'fixation duration\n');
fprintf(fid,'tracked vs random %.3f\n',corr2(y8(1,:),y8(2,:)));
fprintf(fid,'tracked vs model %.3f\n',corr2(y8(1,:),y8(3,:)));
fprintf(fid,'random vs model %.3f\n',corr2(y8(2,:),y8(3,:)));
clear x1 x2 x3 x4 x8 y1 y2 y3 y4 y8;
fclose(fid);
