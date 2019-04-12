-- ==========================================================================================  
-- Create date: 20190411
-- Description: delete rows  in Simpler_rpt not found in Springbrook
--
-- Assumptions:
--		sprbk.ub_meter_hist_id = simplr.UB_Meter_Hist_ID
--		sprbk.ub_meter_hist_id is null
--
-- ==========================================================================================

use [MCWD]
go
create procedure cleanupSimplerMeterHist

as
begin
	
	-- Delete rows in simpler_rpt.Springbrook.UB_MeterConsumption
	delete simpler_rpt.dbo.UB_MeterConsumption
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
		--simplr.Reading_Period in (1,2,3)
		simplr.Reading_Year = 2019
		and sprbk.ub_meter_hist_id is null


	-- Delete rows in simpler_rpt.Springbrook.UB_Meter_Hist
	delete simpler_rpt.Springbrook.UB_Meter_Hist
	FROM [simpler_rpt].Springbrook.UB_Meter_Hist simplr
	left join
		Springbrook0.dbo.ub_meter_hist sprbk
		on sprbk.ub_meter_hist_id = simplr.UB_Meter_Hist_ID
	where
		-- simplr.Reading_Period in (1,2,3)
		simplr.Reading_Year = 2019
		and sprbk.ub_meter_hist_id is null
end
go