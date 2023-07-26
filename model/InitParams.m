%%
%%
%%
function init_params = InitParams(SVRtarg);

	SVRbase = 30;
	SVR = SVRtarg/SVRbase;


	% alpha	= 100;
	beta1	= 1.600000e-03;
	beta2	= 1.040000e-01;
	gamma	= 2.870000e-02;


	%%
	%% 230719HU
	%%

	kof_TC = 2600			;
	kof_TN = 160000			;
	kof_RC = 6.500000e+00	;
	kof_RN = 22000			;

	kon_TC = 84			;
	kon_TN = 770		;
	kon_RC = 25			;
	kon_RN = 32000		;

	Kd_TN = kof_TN / kon_TN;
	Kd_RN = kof_RN / kon_RN;
	Kd_TC = kof_TC / kon_TC;
	Kd_RC = kof_RC / kon_RC;

	%% "Klee 1994, Biochem 33, 6589"
	Kd_CN_TN    = 0.3;
	Kd_CN_RN    = 0.08;
	Kd_CN_TC    = 0.1;
	Kd_CN_RC    = 0.06;
	
	kon_CN_TN   = kon_TN;
	kof_CN_TN   = kon_CN_TN * Kd_CN_TN;
	kon_CN_RN   = kon_RN;
	kof_CN_RN   = kon_CN_RN * Kd_CN_RN;
	kon_CN_TC   = kon_TC;
	kof_CN_TC   = kon_CN_TC * Kd_CN_TC;
	kon_CN_RC   = kon_RC;
	kof_CN_RC   = kon_CN_RC * Kd_CN_RC;
	
	r_TN    = Kd_TN / Kd_CN_TN;
	r_RN    = Kd_RN / Kd_CN_RN;
	r_TC    = Kd_TC / Kd_CN_TC;
	r_RC    = Kd_RC / Kd_CN_RC;
	
	Kd_CN_N2C2 = 0.0001; % 0.0018 uM for EC50 for Ca = 0.35 uM, 0.0001 uM, or 0.00003 uM
	Kd_CN_N1C2 = Kd_CN_N2C2 * r_RN;
	Kd_CN_N0C2 = Kd_CN_N2C2 * r_RN * r_TN;
	Kd_CN_N2C1 = Kd_CN_N2C2 * r_RC;
	Kd_CN_N1C1 = Kd_CN_N2C2 * r_RC * r_RN;
	Kd_CN_N0C1 = Kd_CN_N2C2 * r_RC * r_RN * r_TN;
	Kd_CN_N2C0 = Kd_CN_N2C2 * r_TC * r_RC;
	Kd_CN_N1C0 = Kd_CN_N2C2 * r_TC * r_RC * r_RN;
	Kd_CN_N0C0 = Kd_CN_N2C2 * r_TC * r_RC * r_RN * r_TN;

	% CaM-CaN binding reactions
	kof_CN_CaM   = 0.36;
	kof_CN_CaCaM = 0.01; % 0.001
	kof_CN_N0C0   = kof_CN_CaM;
	kof_CN_N1C0   = kof_CN_CaM;
	kof_CN_N2C0   = kof_CN_CaM;
	kof_CN_N0C1   = kof_CN_CaM;
	kof_CN_N1C1   = kof_CN_CaCaM;
	kof_CN_N2C1   = kof_CN_CaCaM;
	kof_CN_N0C2   = (kof_CN_CaCaM + kof_CN_CaM) / 2;
	kof_CN_N1C2   = kof_CN_CaCaM;
	kof_CN_N2C2   = kof_CN_CaCaM;
	        
	kon_CN_N0C0   = kof_CN_N0C0 / Kd_CN_N0C0;
	kon_CN_N1C0   = kof_CN_N1C0 / Kd_CN_N1C0;
	kon_CN_N2C0   = kof_CN_N2C0 / Kd_CN_N2C0;
	kon_CN_N0C1   = kof_CN_N0C1 / Kd_CN_N0C1;
	kon_CN_N1C1   = kof_CN_N1C1 / Kd_CN_N1C1;
	kon_CN_N2C1   = kof_CN_N2C1 / Kd_CN_N2C1;
	kon_CN_N0C2   = kof_CN_N0C2 / Kd_CN_N0C2;
	kon_CN_N1C2   = kof_CN_N1C2 / Kd_CN_N1C2;
	kon_CN_N2C2   = kof_CN_N2C2 / Kd_CN_N2C2;

	%%
	%% 230719HU end
	%%


	spec  = {
	%%
	%% 230719HU
	%%
		'Km_ArhGEF2' 			,50.0; % サチらせない（ActiveCK < Km）。DA-VGCCのタイミング依存活性がつぶれてしまう。
		'kcat_ArchGEF2_phospho'	,0.02;
		'kcat_ArhGEF2_dephospho',0.01;
		'Km_RhoA_ArhGEF2'		,10.0; % サチらせない（ArchGEF2p < Km）。DA-VGCCのタイミング依存活性がつぶれてしまう。
		'kcat_RhoA_exch' 		,0.2;
		'Km_RhoA_RhoGAP' 		,0.2; % サチらせる（RhoGAP > Km）。タイミング依存活性が大きくなる。
		'kcat_RhoA_hydro'		,0.01;
		'kon_RhoA_ROCK'			,1.0;
		'koff_RhoA_ROCK'		,0.1;
		'Km_LIMK_ROCK'			,1;
		'kcat_LIMK_phospho'		,0.01;
		'kcat_LIMK_dephospho'	,0.01;
		'Km_Cofilin_LIMK'		,1;
		'kcat_Cofilin_phospho'	,0.1;
		'Km_Cofilin_CN'  		,4;
		'kcat_Cofilin_dephospho',0.01;
	%%
	%% 230719HU end
	%%
		'Zero'				, 0			;
		'DApulse'			, 10		;
%%
%% DA-D1R,D2R production
%%

		'kdec_DA'			, 50		; %%
		'kinc_DA'			, 50		; %%

		'kon_DA_BuffDA'		, 0			; %%
		'koff_DA_BuffDA'	, 0			; %%
		'kf_DA_D1R'			, 24		; %%
		'kb_DA_D1R'			, 50		; %%
		'kf_DA_D2R'			, 10		; %%
		'kb_DA_D2R'			, 100		; %%


%%%
%%% Golf ===> Changed!!!
%%%
		'Km_exch_Golf'			, 2			* SVR; %
		'kcat_exch_Golf'		, 66.667	/ SVR; %
		'kcat_exch_Golf_A2AR'	, 80		/ SVR; %
		'kcat_hyd_Golf'			, 50				; % %%%%%%%% Remove it!
%
		'kon_AC_GolfGTP'		, 40		/ SVR; %
		'koff_AC_GolfGTP'		, 4				 ;
		'kon_AC_GolfGDP'		, 40		/ SVR; %
		'koff_AC_GolfGDP'		, 40			 ;
%%
		'kon_AC5_GolfGTP'		, 10		/ SVR; %
		'koff_AC5_GolfGTP'		, 1				 ;	
		'kon_AC5_GolfGDP'		, 10		/ SVR; %
		'koff_AC5_GolfGDP'		, 10			 ;	
%%
		'kon_Gbc_Golf'			, 10		/ SVR; % 
%%%
%%% Gi
%%%
		'Km_exch_Gi'		, 0.2			* SVR; %
		'kcat_exch_Gi'		, 800			/ SVR; %
%
		'Km_hyd_Gi'			, 12			* SVR; %
		'kcat_hyd_Gi'		, 72			/ SVR; %
%
		'kon_AC_GiGTP'		, 40			/ SVR; %%%
		'koff_AC_GiGTP'		, 2					 ; %%%
		'kon_AC_GiGDP'		, 8				/ SVR; %%%
		'koff_AC_GiGDP'		, 20				 ; %%%
%
		'kon_AC5_GiGTP'		, 20			/ SVR; %%%
		'koff_AC5_GiGTP'	, 1					 ; %%%
		'kon_AC5_GiGDP'		, 2				/ SVR; %%%
		'koff_AC5_GiGDP'	, 5					 ; %%%
%
		'kon_Gbc_Gi'		, 10			/ SVR; %%%
%%
%% AC1 cAMP production PDE degradation
%%
		'Km_PDE'			, 0.05			;% 
		'kcat_PDE'			, 0.3			;%
%%
%% cAMP - PKA reaction
%%
		'kon_A'				, 2 			; %
		'koff_A'			, 10			; %
%
		'kon_C'				, 10			;
		'koff_C'			, 40			;
%
%%%		'BasalAC'			, 0.01			; % unknown. ??? 230720HU

%%
%% DARPP32 phosphorylation & PP1 binding
%%
		'kcat_T34P'			, 5.0	;
		'Km_T34P'			, 2.4	;
		'kcat_T34DP'		, 0.5	;
		'Km_T34DP'			, 1.6	;
%
		'kon_D32p_PP1'		, 2;	;
		'koff_D32p_PP1'		, 0.01	;
		'koff_D32_PP1'		, 0.5	;
%%
%% CaMKII
%%

	% CaM binding

		'kon_CK_CaM'		, 50		;
		'koff_CK_CaM'		, 10		;
		'kon_CKp_CaM'		, 50		;
		'koff_CKp_CaM'		, 0.001		;

	% Autophosphorylation

		'tmpCK_Rate'		, 20		; %%20
		'tmpCK'				, 0			;
		'leakCKp'			, 0			;
%
		'kcat_PP1'			, 10		;
		'Km_PP1'			, 10		;
%
		'CtSd'				, 1				;
%
		'kpump_Ca'			, 1600		; %%%%%% ?????
		'kon_CB'			, 75		;
		'koff_CB'			, 29.5		;
		'kdeact_VGCC'		, 33.35		;
		'kinflux_Ca'		, 2500		;
%%
%% cAMP generation
%%

		'kcat_decomp'		, 0.33			;
		'Km_decomp'			, 0.05			;
		'kcat_synth'		, 100			;
		'Km_synth'			, 1				;

%%
%% Ca-CaM binding (230719HU)
%%

		'kon_T_C'			, kon_TC			;
		'kon_T_N'			, kon_TN			;
		'kon_R_C'			, kon_RC			;
		'kon_R_N'			, kon_RN			;
%
		'koff_T_C'			, kof_TC			;
		'koff_T_N'			, kof_TN			;
		'koff_R_C'			, kof_RC			;
		'koff_R_N'			, kof_RN			;

%%
%% AC-CaM binding
%%

		'Km_AC'				, 0.1		;% 
		'kcat_AC'			, 100		;% 
%
		'kon_AC_CaM'		, 50	; %% temp = *5
		'koff_AC_CaM'		, 20	; %% temp = *5
%
		'kup_AC'			, 4.0		;
		'kdown_AC'			, 4.0		;
%
		'kon_AC_CaM_g'		, 1.435000e-01		;
		'kon_AC_CaM_g_b2'	, 1.492400e-02		;
		'kon_AC_CaM_g_b2_b1', 2.387840e-05		;
		'kon_AC_CaM_b2_b1'	, 8.320000e-04		;
		'kon_AC_CaM_b2'		, 5.200000e-01		;
%
		'koff_R_N_g'		, kof_RN * gamma	;
		'koff_T_C_b1'		, kof_TC * beta1	;
		'koff_R_C_b2'		, kof_RC * beta2	;
%%
%% CN-CaM binding (230719HU)
%%
		'kon_CN_T_C'			, kon_CN_TC			;
		'kon_CN_T_N'			, kon_CN_TN			;
		'kon_CN_R_C'			, kon_CN_RC			;
		'kon_CN_R_N'			, kon_CN_RN			;
%
		'koff_CN_T_C'			, kof_CN_TC			;
		'koff_CN_T_N'			, kof_CN_TN			;
		'koff_CN_R_C'			, kof_CN_RC			;
		'koff_CN_R_N'			, kof_CN_RN			;
%
		'kon_CN_N0C0'			, kon_CN_N0C0		;
		'kon_CN_N1C0'			, kon_CN_N1C0		;
		'kon_CN_N2C0'			, kon_CN_N2C0		;
		'kon_CN_N0C1'			, kon_CN_N0C1		;
		'kon_CN_N1C1'			, kon_CN_N1C1		;
		'kon_CN_N2C1'			, kon_CN_N2C1		;
		'kon_CN_N0C2'			, kon_CN_N0C2		;
		'kon_CN_N1C2'			, kon_CN_N1C2		;
		'kon_CN_N2C2'			, kon_CN_N2C2		;
%
		'koff_CN_N0C0'			, kof_CN_N0C0		;
		'koff_CN_N1C0'			, kof_CN_N1C0		;
		'koff_CN_N2C0'			, kof_CN_N2C0		;
		'koff_CN_N0C1'			, kof_CN_N0C1		;
		'koff_CN_N1C1'			, kof_CN_N1C1		;
		'koff_CN_N2C1'			, kof_CN_N2C1		;
		'koff_CN_N0C2'			, kof_CN_N0C2		;
		'koff_CN_N1C2'			, kof_CN_N1C2		;
		'koff_CN_N2C2'			, kof_CN_N2C2		;
%%
%% end (230719HU)
%%


%%
%% cAMP-Epac binding
%%
		'kon_Epac_cAMP'		, 0.022; %
		'koff_Epac_cAMP'	, 10.0
		};

%%
%%
	spec_res  = {
		'kon_T_C'	;
		'koff_T_C'	;
		'kon_T_N'	;
		'koff_T_N'	;
		'kon_R_C'	;
		'koff_R_C'	;
		'kon_R_N'	;
		'koff_R_N'	;
		'koff_R_N_g' 	;
		'koff_T_C_b1' 	;
		'koff_R_C_b2' 	;
	%
		'kon_CN_T_C'	;
		'kon_CN_T_N'	;
		'kon_CN_R_C'	;
		'kon_CN_R_N'	;
		'koff_CN_T_C'	;
		'koff_CN_T_N'	;
		'koff_CN_R_C'	;
		'koff_CN_R_N'	;
	%
		'kon_C'		;
		'koff_C'	;
		'kon_A'		;
		'koff_A'
	};
%%
%%
	spec2 = cell(numel(spec_res),2);
	for i = 1:numel(spec_res);
		spec2{i,1} = sprintf('_2%s', spec_res{i});
		id = find(strcmp(spec_res{i}, spec(:,1)));
		spec2{i,2} = 2 * spec{id,2};
	end;
%%
%%
	spec_res  = {
		'kon_A'		;
		'koff_A'
	};

	spec4 = cell(numel(spec_res),2);
	for i = 1:numel(spec_res);
		spec4{i,1} = sprintf('_4%s', spec_res{i});
		id = find(strcmp(spec_res{i}, spec(:,1)));
		spec4{i,2} = 4 * spec{id,2};
	end;

	spec10 = cell(numel(spec_res),2);
	for i = 1:numel(spec_res);
		spec10{i,1} = sprintf('_10%s', spec_res{i});
		id = find(strcmp(spec_res{i}, spec(:,1)));
		spec10{i,2} = 10 * spec{id,2};
	end;

	spec16 = cell(numel(spec_res),2);
	for i = 1:numel(spec_res);
		spec16{i,1} = sprintf('_16%s', spec_res{i});
		id = find(strcmp(spec_res{i}, spec(:,1)));
		spec16{i,2} = 16 * spec{id,2};
	end;

	init_params = [spec;spec2;spec4;spec10;spec16];
%%
%%
