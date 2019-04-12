-- ==========================================================================================  
-- Create date: 20190411
-- Description: Locate rows  in Simpler_rpt not found in Springbrook
--
-- Assumptions:
--		sprbk.ub_meter_hist_id = simplr.UB_Meter_Hist_ID
--		sprbk.ub_meter_hist_id is null
--
-- ==========================================================================================


select 
	top 5000
	--sprbk.ub_meter_hist_id,
	--mtr.Read_Dt,
	--mtr.Read_Period,
	--mtr.Consumption,
	simplr.*
FROM [simpler_rpt].Springbrook.UB_Meter_Hist simplr
left join
	Springbrook0.dbo.ub_meter_hist sprbk
	on sprbk.ub_meter_hist_id = simplr.UB_Meter_Hist_ID
inner join
	simpler_rpt.dbo.UB_MeterConsumption mtr
	on simplr.cust_no = mtr.Cust_No
	and mtr.AccountNumber = MCWD.dbo.AccountNoConcat(simplr.Cust_No,simplr.Cust_Sequence)
	and simplr.Read_Dt = mtr.Read_Dt
	and simplr.Consumption = mtr.Consumption
where
	simplr.Reading_Period in (1,2,3)
	and simplr.Reading_Year = 2019
	--and simplr.Consumption > 5000
	and sprbk.ub_meter_hist_id is null
	--and mtr.AccountNumber = '018023-000'
order by
	mtr.Consumption desc
