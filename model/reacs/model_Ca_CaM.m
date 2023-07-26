function model_Ca_CaM(model)
	% Ca-CaM binding
	r21 = [	"N0C0" ,"Ca", "N1C0" , "_2kon_T_N", "koff_T_N";
				"N1C0" ,"Ca", "N2C0" , "kon_R_N"  , "_2koff_R_N";
				"N0C0" ,"Ca", "N0C1" , "_2kon_T_C", "koff_T_C";
				"N0C1" ,"Ca", "N0C2" , "kon_R_C"  , "_2koff_R_C";
				%
				"N1C0" ,"Ca", "N1C1" , "_2kon_T_C", "koff_T_C";
				"N0C1" ,"Ca", "N1C1" , "_2kon_T_N", "koff_T_N";
				"N1C1" ,"Ca", "N2C1" , "kon_R_N"  , "_2koff_R_N";
				"N1C1" ,"Ca", "N1C2" , "kon_R_C"  , "_2koff_R_C";
				%
				"N0C2" ,"Ca", "N1C2" , "_2kon_T_N", "koff_T_N";
				"N2C0" ,"Ca", "N2C1" , "_2kon_T_C", "koff_T_C";
				"N1C2" ,"Ca", "N2C2" , "kon_R_N"  , "_2koff_R_N";
				"N2C1" ,"Ca", "N2C2" , "kon_R_C"  , "_2koff_R_C"
				];
	for i = 1:size(r21,1)
		eid = Reac21(r21(i,1) ,r21(i,2), r21(i,3), r21(i,4), r21(i,5), model);
	end
