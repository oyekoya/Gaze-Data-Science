function exponential_fixationduration(x4,mean_y4_static_and_tracked)
%EXPONENTIAL_FIXATIONDURATION    Create plot of datasets and fits
%   EXPONENTIAL_FIXATIONDURATION(X4,MEAN_Y4_STATIC_AND_TRACKED)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

 
% Data from dataset "fixation duration":
%    X = x4:
%    Y = mean_y4_static_and_tracked:
%    Unweighted
%
% This function was automatically generated on 25-Nov-2008 15:47:44

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = subplot(1,1,1);
set(ax_,'Box','on');
axes(ax_); hold on;

 
% --- Plot data originally in dataset "fixation duration"
x4 = x4(:);
mean_y4_static_and_tracked = mean_y4_static_and_tracked(:);
h_ = line(x4,mean_y4_static_and_tracked,'Parent',ax_,'Color',[0.333333 0 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x4));
xlim_(2) = max(xlim_(2),max(x4));
legh_(end+1) = h_;
legt_{end+1} = 'fixation duration';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end


% --- Create fit "exponential fit"
st_ = [0.6817430068586 -0.001809819989791 0.261050687132 -0.0007009885693284 ];
ft_ = fittype('exp2' );

% Fit this model using new data
cf_ = fit(x4,mean_y4_static_and_tracked,ft_ ,'Startpoint',st_);

% Or use coefficients from the original fit:
if 0
   cv_ = {0.6140890612403, -0.003831498617332, 0.3654110073818, -0.0005475026324252};
   cf_ = cfit(ft_,cv_{:});
end

% Plot this fit
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[1 0 0],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'exponential fit';

hold off;
legend(ax_,legh_, legt_);
