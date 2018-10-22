function gaussian_velocity(x3,mean_y3_static_and_tracked)
%GAUSSIAN_VELOCITY    Create plot of datasets and fits
%   GAUSSIAN_VELOCITY(X3,MEAN_Y3_STATIC_AND_TRACKED)
%   Creates a plot, similar to the plot in the main curve fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with cftool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1

 
% Data from dataset "velocity":
%    X = x3:
%    Y = mean_y3_static_and_tracked:
%    Unweighted
%
% This function was automatically generated on 25-Nov-2008 15:44:07

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
legh_ = []; legt_ = {};   % handles and text for legend
xlim_ = [Inf -Inf];       % limits of x axis
ax_ = subplot(1,1,1);
set(ax_,'Box','on');
axes(ax_); hold on;

 
% --- Plot data originally in dataset "velocity"
x3 = x3(:);
mean_y3_static_and_tracked = mean_y3_static_and_tracked(:);
h_ = line(x3,mean_y3_static_and_tracked,'Parent',ax_,'Color',[0.333333 0 0.666667],...
     'LineStyle','none', 'LineWidth',1,...
     'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x3));
xlim_(2) = max(xlim_(2),max(x3));
legh_(end+1) = h_;
legt_{end+1} = 'velocity';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end


% --- Create fit "gaussian"
fo_ = fitoptions('method','NonlinearLeastSquares','Lower',[-Inf  -Inf 0  -Inf  -Inf 0  -Inf  -Inf 0 ]);
st_ = [0.8826053532936 10 7.092899446487 0.6320031772944 25 7.221070273367 0.4268012777669 40 8.626476068178 ];
set(fo_,'Startpoint',st_);
ft_ = fittype('gauss3' );

% Fit this model using new data
cf_ = fit(x3,mean_y3_static_and_tracked,ft_ ,fo_);

% Or use coefficients from the original fit:
if 0
   cv_ = {0.4732461949659, 9.039164045265, 12.45374724225, 0.3553877238378, 23.11513706692, 26.25104434387, 0.2133996059438, 59.75201499931, 66.54164220025};
   cf_ = cfit(ft_,cv_{:});
end

% Plot this fit
h_ = plot(cf_,'fit',0.95);
legend off;  % turn off legend from plot method call
set(h_(1),'Color',[1 0 0],...
     'LineStyle','-', 'LineWidth',2,...
     'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_(1);
legt_{end+1} = 'gaussian';

hold off;
legend(ax_,legh_, legt_);
