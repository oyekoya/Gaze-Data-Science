load data0;
ans1 = reshape(plotvalues(:,:,1),2250,1);
ans2 = reshape(plotvalues(:,:,2),2250,1);
ans3 = reshape(plotvalues(:,:,3),2250,1);
[R,P]=corrcoef(ans1,ans2)
[R,P]=corrcoef(ans1,ans3)
[R,P]=corrcoef(ans2,ans3)
clear all;

load data3;
ans1 = reshape(plotvalues(:,:,1),2250,1);
ans2 = reshape(plotvalues(:,:,2),2250,1);
ans3 = reshape(plotvalues(:,:,3),2250,1);
[R,P]=corrcoef(ans1,ans2)
[R,P]=corrcoef(ans1,ans3)
[R,P]=corrcoef(ans2,ans3)
clear all;

load data6;
ans1 = reshape(plotvalues(:,:,1),2250,1);
ans2 = reshape(plotvalues(:,:,2),2250,1);
ans3 = reshape(plotvalues(:,:,3),2250,1);
[R,P]=corrcoef(ans1,ans2)
[R,P]=corrcoef(ans1,ans3)
[R,P]=corrcoef(ans2,ans3)
clear all;

load data9;
ans1 = reshape(plotvalues(:,:,1),2250,1);
ans2 = reshape(plotvalues(:,:,2),2250,1);
ans3 = reshape(plotvalues(:,:,3),2250,1);
[R,P]=corrcoef(ans1,ans2)
[R,P]=corrcoef(ans1,ans3)
[R,P]=corrcoef(ans2,ans3)
