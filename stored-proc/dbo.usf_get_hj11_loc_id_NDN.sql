USE [AAD]
GO
/****** Object:  UserDefinedFunction [dbo].[usf_get_hj11_loc_id_NDN]    Script Date: 8/3/2022 8:43:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- SAI
-- User Defined Function

-- =============================================
-- Author:		Amit Joshi
-- Create date: 06/28/2013
-- Description:	Returns HJ 11 location created for initial accuterm inventory conversion for HJ 11
-- Modify Date:9/18/2013
-- Description: Added VAS01 & VAS02
-- =============================================
CREATE FUNCTION [dbo].[usf_get_hj11_loc_id_NDN]
(
	-- Add the parameters for the function here
	@accuterm_location AS NVARCHAR(30)
)
RETURNS NVARCHAR(10)
AS
BEGIN
	-- Declare the return variable here
		DECLARE @aisle NVARCHAR(10),
				@slot  NVARCHAR(10),
				@level NVARCHAR(10),
				@first_character NCHAR(1),
				@separator_position INT,
				@hj11_loc_exists INT,
				@hj11_location_id NVARCHAR(10)

	-- Add the T-SQL statements to compute the return value here
				IF  ISNUMERIC(LEFT(@accuterm_location,1)) = 1
				BEGIN
					SELECT @separator_position = CHARINDEX('-',@accuterm_location)
					SELECT @level = SUBSTRING(@accuterm_location,LEN(@accuterm_location),LEN(@accuterm_location))
					SELECT @aisle = SUBSTRING(@accuterm_location,0,@separator_position)

					IF ISNUMERIC(@level) = 0
					SELECT @slot = SUBSTRING(@accuterm_location,@separator_position+1,LEN(@accuterm_location)-1-@separator_position)
					ELSE
					SELECT @slot = SUBSTRING(@accuterm_location,@separator_position+1,LEN(@accuterm_location))

				IF LEN(@aisle) = 2
				SET @aisle = '0'+@aisle

				IF LEN(@aisle) = 1
				SET @aisle = '00'+@aisle	

				IF LEN(@slot) = 2
				SET @slot = '0'+@slot

				IF LEN(@slot) = 1
				SET @slot = '00'+@slot

				IF ISNUMERIC(@level) = 0
					SET @hj11_location_id = @aisle+@slot+@level
				ELSE
					SET @hj11_location_id =@aisle+@slot

				END
				ELSE IF RTRIM(LTRIM(@accuterm_location)) = 'RE-PACK'
				SET @hj11_location_id = 'VAS01'
				ELSE IF RTRIM(LTRIM(@accuterm_location)) = 'REPAC2'
				SET @hj11_location_id = 'VAS02'
				ELSE IF RTRIM(LTRIM(@accuterm_location)) = 'RB'
				SET @hj11_location_id = 'CRL001'
				ELSE IF RTRIM(LTRIM(@accuterm_location)) = 'PC'
				SET @hj11_location_id = 'LRL001'
				ELSE IF RTRIM(LTRIM(@accuterm_location)) = 'IC-EXP'
				SET @hj11_location_id = 'IC-EXP'
				--ELSE IF @accuterm_location = 'A01'	SET @hj11_location_id = 'A001'
				--ELSE IF @accuterm_location = 'A02'	SET @hj11_location_id = 'A002'
				--ELSE IF @accuterm_location = 'A03'	SET @hj11_location_id = 'A003'
				--ELSE IF @accuterm_location = 'A04'	SET @hj11_location_id = 'A004'
				--ELSE IF @accuterm_location = 'A05'	SET @hj11_location_id = 'A005'
				--ELSE IF @accuterm_location = 'A06'	SET @hj11_location_id = 'A006'
				--ELSE IF @accuterm_location = 'A07'	SET @hj11_location_id = 'A007'
				--ELSE IF @accuterm_location = 'A08'	SET @hj11_location_id = 'A008'
				--ELSE IF @accuterm_location = 'A09'	SET @hj11_location_id = 'A009'
				--ELSE IF @accuterm_location = 'A10'	SET @hj11_location_id = 'A010'
				--ELSE IF @accuterm_location = 'A11'	SET @hj11_location_id = 'A011'
				--ELSE IF @accuterm_location = 'A12'	SET @hj11_location_id = 'A012'
				--ELSE IF @accuterm_location = 'A13'	SET @hj11_location_id = 'A013'
				--ELSE IF @accuterm_location = 'A14'	SET @hj11_location_id = 'A014'
				--ELSE IF @accuterm_location = 'A15'	SET @hj11_location_id = 'A015'
				--ELSE IF @accuterm_location = 'A16'	SET @hj11_location_id = 'A016'
				--ELSE IF @accuterm_location = 'A17'	SET @hj11_location_id = 'A017'
				--ELSE IF @accuterm_location = 'A18'	SET @hj11_location_id = 'A018'
				--ELSE IF @accuterm_location = 'A19'	SET @hj11_location_id = 'A019'
				--ELSE IF @accuterm_location = 'A20'	SET @hj11_location_id = 'A020'
				--ELSE IF @accuterm_location = 'A21'	SET @hj11_location_id = 'A021'
				--ELSE IF @accuterm_location = 'A22'	SET @hj11_location_id = 'A022'
				--ELSE IF @accuterm_location = 'A23'	SET @hj11_location_id = 'A023'
				--ELSE IF @accuterm_location = 'A24'	SET @hj11_location_id = 'A024'
				--ELSE IF @accuterm_location = 'A25'	SET @hj11_location_id = 'A025'
				--ELSE IF @accuterm_location = 'A26'	SET @hj11_location_id = 'A026'
				--ELSE IF @accuterm_location = 'A27'	SET @hj11_location_id = 'A027'
				--ELSE IF @accuterm_location = 'A28'	SET @hj11_location_id = 'A028'
				--ELSE IF @accuterm_location = 'A29'	SET @hj11_location_id = 'A029'
				--ELSE IF @accuterm_location = 'A30'	SET @hj11_location_id = 'A030'
				--ELSE IF @accuterm_location = 'A31'	SET @hj11_location_id = 'A031'
				--ELSE IF @accuterm_location = 'A32'	SET @hj11_location_id = 'A032'
				--ELSE IF @accuterm_location = 'A33'	SET @hj11_location_id = 'A033'
				--ELSE IF @accuterm_location = 'A34'	SET @hj11_location_id = 'A034'
				--ELSE IF @accuterm_location = 'A35'	SET @hj11_location_id = 'A035'
				--ELSE IF @accuterm_location = 'A36'	SET @hj11_location_id = 'A036'
				--ELSE IF @accuterm_location = 'A37'	SET @hj11_location_id = 'A037'
				--ELSE IF @accuterm_location = 'A38'	SET @hj11_location_id = 'A038'
				--ELSE IF @accuterm_location = 'A39'	SET @hj11_location_id = 'A039'
				--ELSE IF @accuterm_location = 'A40'	SET @hj11_location_id = 'A040'
				--ELSE IF @accuterm_location = 'A41'	SET @hj11_location_id = 'A041'
				--ELSE IF @accuterm_location = 'A42'	SET @hj11_location_id = 'A042'
				--ELSE IF @accuterm_location = 'A43'	SET @hj11_location_id = 'A043'
				--ELSE IF @accuterm_location = 'A44'	SET @hj11_location_id = 'A044'
				--ELSE IF @accuterm_location = 'A45'	SET @hj11_location_id = 'A045'
				--ELSE IF @accuterm_location = 'A46'	SET @hj11_location_id = 'A046'
				--ELSE IF @accuterm_location = 'A47'	SET @hj11_location_id = 'A047'
				--ELSE IF @accuterm_location = 'A48'	SET @hj11_location_id = 'A048'
				--ELSE IF @accuterm_location = 'A49'	SET @hj11_location_id = 'A049'
				--ELSE IF @accuterm_location = 'A50'	SET @hj11_location_id = 'A050'
				--ELSE IF @accuterm_location = 'A51'	SET @hj11_location_id = 'A051'
				--ELSE IF @accuterm_location = 'A52'	SET @hj11_location_id = 'A052'
				--ELSE IF @accuterm_location = 'A53'	SET @hj11_location_id = 'A053'
				--ELSE IF @accuterm_location = 'A54'	SET @hj11_location_id = 'A054'
				--ELSE IF @accuterm_location = 'A55'	SET @hj11_location_id = 'A055'
				--ELSE IF @accuterm_location = 'A56'	SET @hj11_location_id = 'A056'
				--ELSE IF @accuterm_location = 'A57'	SET @hj11_location_id = 'A057'
				--ELSE IF @accuterm_location = 'A58'	SET @hj11_location_id = 'A058'
				--ELSE IF @accuterm_location = 'A59'	SET @hj11_location_id = 'A059'
				--ELSE IF @accuterm_location = 'A60'	SET @hj11_location_id = 'A060'
				--ELSE IF @accuterm_location = 'A61'	SET @hj11_location_id = 'A061'
				--ELSE IF @accuterm_location = 'A62'	SET @hj11_location_id = 'A062'
				--ELSE IF @accuterm_location = 'A63'	SET @hj11_location_id = 'A063'
				--ELSE IF @accuterm_location = 'A64'	SET @hj11_location_id = 'A064'
				--ELSE IF @accuterm_location = 'A65'	SET @hj11_location_id = 'A065'
				--ELSE IF @accuterm_location = 'A66'	SET @hj11_location_id = 'A066'
				--ELSE IF @accuterm_location = 'A67'	SET @hj11_location_id = 'A067'
				--ELSE IF @accuterm_location = 'A68'	SET @hj11_location_id = 'A068'
				--ELSE IF @accuterm_location = 'A69'	SET @hj11_location_id = 'A069'
				--ELSE IF @accuterm_location = 'A70'	SET @hj11_location_id = 'A070'
				--ELSE IF @accuterm_location = 'A71'	SET @hj11_location_id = 'A071'
				--ELSE IF @accuterm_location = 'A72'	SET @hj11_location_id = 'A072'
				--ELSE IF @accuterm_location = 'A73'	SET @hj11_location_id = 'A073'
				--ELSE IF @accuterm_location = 'A74'	SET @hj11_location_id = 'A074'
				--ELSE IF @accuterm_location = 'A75'	SET @hj11_location_id = 'A075'
				--ELSE IF @accuterm_location = 'A76'	SET @hj11_location_id = 'A076'
				--ELSE IF @accuterm_location = 'A77'	SET @hj11_location_id = 'A077'
				--ELSE IF @accuterm_location = 'A78'	SET @hj11_location_id = 'A078'
				--ELSE IF @accuterm_location = 'A79'	SET @hj11_location_id = 'A079'
				--ELSE IF @accuterm_location = 'A80'	SET @hj11_location_id = 'A080'
				--ELSE IF @accuterm_location = 'A81'	SET @hj11_location_id = 'A081'
				--ELSE IF @accuterm_location = 'A82'	SET @hj11_location_id = 'A082'
				--ELSE IF @accuterm_location = 'A83'	SET @hj11_location_id = 'A083'
				--ELSE IF @accuterm_location = 'A84'	SET @hj11_location_id = 'A084'
				--ELSE IF @accuterm_location = 'A85'	SET @hj11_location_id = 'A085'
				--ELSE IF @accuterm_location = 'A86'	SET @hj11_location_id = 'A086'
				--ELSE IF @accuterm_location = 'A87'	SET @hj11_location_id = 'A087'
				--ELSE IF @accuterm_location = 'A88'	SET @hj11_location_id = 'A088'
				--ELSE IF @accuterm_location = 'A89'	SET @hj11_location_id = 'A089'
				--ELSE IF @accuterm_location = 'A90'	SET @hj11_location_id = 'A090'
				--ELSE IF @accuterm_location = 'A91'	SET @hj11_location_id = 'A091'
				--ELSE IF @accuterm_location = 'A92'	SET @hj11_location_id = 'A092'
				--ELSE IF @accuterm_location = 'A93'	SET @hj11_location_id = 'A093'
				--ELSE IF @accuterm_location = 'A94'	SET @hj11_location_id = 'A094'
				--ELSE IF @accuterm_location = 'A95'	SET @hj11_location_id = 'A095'
				--ELSE IF @accuterm_location = 'A96'	SET @hj11_location_id = 'A096'
				--ELSE IF @accuterm_location = 'A97'	SET @hj11_location_id = 'A097'
				--ELSE IF @accuterm_location = 'A98'	SET @hj11_location_id = 'A098'
				--ELSE IF @accuterm_location = 'A99'	SET @hj11_location_id = 'A099'
				ELSE 
				SET @hj11_location_id =  RTRIM(LTRIM(@accuterm_location))

	-- Return the result of the function
	RETURN @hj11_location_id

END










GO
