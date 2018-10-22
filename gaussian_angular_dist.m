function gaussian_angular_dist(x2,mean_y2_static_and_tracked)
%GAUSSIAN_ANGULAR_DIST    Create plot of datasets and fits
%   GAUSSIAN_ANGULAR_DIST(X2,MEAN_Y2_STATIC_AND_TRACKED)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

 
% Data from dataset "angular distance":
%    X = x2:
%    Y = mean_y2_static_and_tracked:
%    Unweighted
%
% This function was automatically generated on 25-Nov-2008 15:21:50

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = subplot(1,1,1);
set(ax_,'Box','on');
axes(ax_); hold on;

 
% --- Plot data originally in dataset "angular distance"
x2 = x2(:);
mean_y2_static_and_tracked = mean_y2_static_and_tracked(:);
h_ = line(x2,mean_y2_static_and_tracked,'Parent',ax_,'Color',[0.333333 0 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x2));
xlim_(2) = max(xlim_(2),max(x2));
legh_(end+1) = h_;
legt_{end+1} = 'angular distance';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end


% --- Create fit "fit 1"
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[-Inf  -Inf 0  -Inf  -Inf 0 ]);
st_ = [0.8783792582073 10 5.252236368184 0.3675697833706 15 7.296049745309 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('gauss2' );

% Fit this model using new data
cf_ = fit(x2,mean_y2_static_and_tracked,ft_ ,fo_);

% Or use coefficients from the original fit:
if 0
   cv_ = {0.361758208046, 8.175597356612, 12.63730477136, 0.9148231058368, 12.35224384522, 3.152927917434};
   cf_ = cfit(ft_,cv_{:});
end

% Plot this fit
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[1 0 0],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'fit 1';

hold off;
legend(ax_,legh_, legt_);
