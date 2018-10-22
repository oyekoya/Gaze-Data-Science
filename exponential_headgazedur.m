function exponential_headgazedur(x5,mean_y5_static_and_tracked)
%EXPONENTIAL_HEADGAZEDUR    Create plot of datasets and fits
%   EXPONENTIAL_HEADGAZEDUR(X5,MEAN_Y5_STATIC_AND_TRACKED)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

 
% Data from dataset "headgaze duration":
%    X = x5:
%    Y = mean_y5_static_and_tracked:
%    Unweighted
%
% This function was automatically generated on 25-Nov-2008 15:51:41

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = subplot(1,1,1);
set(ax_,'Box','on');
axes(ax_); hold on;

 
% --- Plot data originally in dataset "headgaze duration"
x5 = x5(:);
mean_y5_static_and_tracked = mean_y5_static_and_tracked(:);
h_ = line(x5,mean_y5_static_and_tracked,'Parent',ax_,'Color',[0.333333 0 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x5));
xlim_(2) = max(xlim_(2),max(x5));
legh_(end+1) = h_;
legt_{end+1} = 'headgaze duration';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end


% --- Create fit "fit 1"
st_ = [0.9404182284205 -0.001354080022344 ];
ft_ = fittype('exp1' );

% Fit this model using new data
cf_ = fit(x5,mean_y5_static_and_tracked,ft_ ,'Startpoint',st_);

% Or use coefficients from the original fit:
if 0
   cv_ = {0.9846707381108, -0.001516422533096};
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
