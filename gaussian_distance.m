function gaussian_distance(x1,mean_y1_static_and_tracked)
%GAUSSIAN_DISTANCE    Create plot of datasets and fits
%   GAUSSIAN_DISTANCE(X1,MEAN_Y1_STATIC_AND_TRACKED)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

 
% Data from dataset "Distance":
%    X = x1:
%    Y = mean_y1_static_and_tracked:
%    Unweighted
%
% This function was automatically generated on 25-Nov-2008 15:06:37

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = subplot(1,1,1);
set(ax_,'Box','on');
axes(ax_); hold on;

 
% --- Plot data originally in dataset "Distance"
x1 = x1(:);
mean_y1_static_and_tracked = mean_y1_static_and_tracked(:);
h_ = line(x1,mean_y1_static_and_tracked,'Parent',ax_,'Color',[0.333333 0 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x1));
xlim_(2) = max(xlim_(2),max(x1));
legh_(end+1) = h_;
legt_{end+1} = 'Distance';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end


% --- Create fit "gaussian fit"
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[-Inf  -Inf 0  -Inf  -Inf 0 ]);
st_ = [0.866422831061 1.5 0.4817400980142 0.5059739126825 2.5 0.6151744560207 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('gauss2' );

% Fit this model using new data
cf_ = fit(x1,mean_y1_static_and_tracked,ft_ ,fo_);

% Or use coefficients from the original fit:
if 0
   cv_ = {0.7167410059563, 1.510753542907, 0.8315387062441, 0.3224266214321, 2.789402195354, 1.632377794561};
   cf_ = cfit(ft_,cv_{:});
end

% Plot this fit
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[1 0 0],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'gaussian fit';

hold off;
legend(ax_,legh_, legt_);
