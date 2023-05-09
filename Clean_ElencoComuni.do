*********************************************************************************
*																				*
* LAST MODIFIED ON:			1/13/2022											*
* BY:						Ludovica Mosillo									*
*																				*
* INPUT DATA:																	*
*																				*
* OUTPUT DATA: 																	*
*																				*
* BRIEF DESCRIPTION:		Clean and prepare list of municipalities 			*
*																				*
********************************************************************************

clear all
set more off
set maxvar 6000
	if "`c(username)'"== "ludom" {
    global path   "C:\Users\ludom\Dropbox\Northwestern\PhD\Third Year\Projects\WomenandMigrantsReception"
}     

*import dataset
import excel "$path\Data\Input\Istat_elenco_comuni\Codici-statistici-e-denominazioni-al-01_01_2014.xls", sheet("CODICI al 01_01_2014") firstrow

drop if CodiceIstatdelComunenumeri == .

rename CodiceRegione id_region
rename CodiceProvincia id_province
rename Progressivodelcomune id_municipality
rename Denominazioneinitaliano municipality
rename CodiceIstatdelComunenumeri istat_code
rename CodiceComunenumericocon107p istat_code107
rename DenominazioneRegione region
rename DenominazioneProvincia province

keep id_* municipality region province istat_code istat_code107
order istat_code id_region region id_province province id_municipality municipality istat_code107

*create a panel for the years of the tenders
expand 11
sort istat_code
by istat_code: egen year = seq()
replace year = year + 2001
recode year (2009 = 2010) (2010 = 2013) (2011 = 2015) (2012 = 2016)

rename year tender_year 
save "$path/Data/Output/ElencoComuni.dta", replace
