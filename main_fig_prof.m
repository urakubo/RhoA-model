%%%

	clear;
	addpath('./funcs');
	addpath('./model');
	data_dir ='data/';

%%% Build model

	Tstop		       = 2000.0 + 1800.0;
	[model, dict] = setup_msn(Tstop);
	
	Ca_stim       = dict('Ca_stim');
	Ca_basal      = dict('Ca_basal');
	DA_stim       = dict('DA_stim');
	DA_basal      = dict('DA_basal');
	Toffset_DA    = dict('Toffset_DA');
	
	default_Ca_stim_Value = Ca_stim.Value;
	Tprerun   = dict('prerun').Value; % 2000.0
	DA_delay  = [-1.0, 0.0, 0.3, 0.6, 1.0, 2.0];

%%% Simulation

	sd   = cell(numel(DA_delay),1);
	for i = 1:numel(DA_delay);
		Toffset_DA.Value = DA_delay(i);
		sd{i} = sbiosimulate(model);
	end;
	
	%{ DA only
	Ca_stim.Value         = Ca_basal.Value;
	Toffset_DA.Value      = 0;
	sd_DA_only            = sbiosimulate(model);
	Ca_stim.Value = default_Ca_stim_Value;
	%}

	% Ca only
	DA_stim.Value = DA_basal.Value;
	sd_Ca_only    = sbiosimulate(model);

%%% Plot

	Ymin  = 0;
	Tmax  = 1800;
	Tmin  = -300;
	Ttic  = Tmax/3;
%		name		,ymax	,xlim		,xtic		;
	tmp = {...
		'Ca'		,1.0	,[-1.5,5.5]	,[-1:1:5]	;
		'DA'		,1.5	,[-1.5,5.5]	,[-1:1:5]	;
		'ActiveCK'	,100	,[-15, 45]	,[-15:15:45]	;
		'ActiveCN'	,15	,[-15, 45]	,[-15:15:45]	;
		'ActiveCK'	,100	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'ActiveCN'	,15	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'ArhGEF2p'	,1.5	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'RhoA_GTP'	,1.5	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'RhoA_ROCK'	,1.5	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'LIMKp'		,1.5	,[Tmin, Tmax]	,[0:Ttic:Tmax]	;
		'Cofilin_p'	,20	,[Tmin, Tmax]	,[0:Ttic:Tmax]
		}
	targ = struct('name', tmp(:,1),'ymax', tmp(:,2),'xlim', tmp(:,3),'xtic', tmp(:,4));

	col = jet(numel(sd));
	fig = figure('pos',[200 200 1000 800]);
	for i = 1:numel(targ);
		subplot(4,3,i)
		plot_profs_prep(targ(i).xlim, [Ymin targ(i).ymax], targ(i).xtic);
		title(targ(i).name,'Interpreter', 'none');
		
		plot_prof(targ(i).name, sd_Ca_only, Tprerun, 'k');
		for j = 1:numel(sd);
			plot_prof(targ(i).name, sd{j}, Tprerun, col(j,:));
		end
		
		legend( ["Ca only", compose("%1.1f s",DA_delay)] );
		legend('boxoff');
	end;

%%%
%%%
%%%

function id = plot_prof(tname, sd, Toffset, col)

	tid = find( strcmp( sd.DataNames, tname ) );
	% fprintf('%s, %d\n', tname, tid)
	T = sd.Time - Toffset;
	DATA = sd.Data(:,tid);
	id = plot( T, DATA, '-', 'LineWidth', 0.75, 'Color', col);

end

function fig = plot_profs_prep(XLIM, YLIM, XTIC)
	xlabel('Time (s)');
	ylabel('(uM)');
	xlim(XLIM);
	ylim(YLIM);
	set(gca,'XTick',XTIC);
	box off;
	set(gca,'TickDir','out');
	hold on;
end
