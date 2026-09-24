{smcl}
{* *! version 0.0.4 **Jun2020}{...}
{cmd:help stnet}{right: ({browse "https://doi.org/10.1177/1536867X20953579":SJ20-3: st0375_3})}
{hline}

{title:Title}

{p2colset 5 14 16 2}{...}
{p2col :{hi:stnet} {hline 2}}Estimating net survival{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 11 2}
{cmd:stnet}
{cmd:using} {it:filename} 
{ifin}
{help stnet##weight:{it:weight}}{cmd:,}
{cmdab:m:ergeby}{cmd:(}{it:varlist}{cmd:)}
{cmdab:diag:date}{cmd:(}{it:varname}{cmd:)}
{cmdab:birth:date}{cmd:(}{it:varname}{cmd:)}
[{cmdab:br:eaks}{cmd:(}{it:range}{cmd:)} 
{cmd:unique}
{cmd:by}{cmd:(}{it:varlist}{cmd:)}
{cmd:attage}{cmd:(}{it:newvar}{cmd:)}
{cmd:attyear}{cmd:(}{it:newvar}{cmd:)}
{cmdab:surv:prob}{cmd:(}{it:varname}{cmd:)}
{cmd:maxage}{cmd:(}{it:#}{cmd:)}
{cmdab:ed:erer2}
{cmdab:stand:strata}{cmd:(}{it:varname}{cmd:)}
{cmd:brenner}
{cmdab:indwe:ight}{cmd:(}{it:varname}{cmd:)}
{cmdab:li:st}{cmd:(}{it:varlist}{cmd:)}
{cmd:at(}{it:#}|{it:{help numlist}}{cmd:)}
{cmd:listyearly}
{cmdab:f:ormat:(%}{it:fmt}{cmd:)}
{cmdab:notab:les}
{cmdab:l:evel}{cmd:(}{it:#}{cmd:)}
{cmd:saving(}{it:filename}[{cmd:, replace}]{cmd:)} 
{cmdab:savst:and(}{it:filename}[{cmd:, replace}]{cmd:)}] 

{pstd}{cmd:stnet} is for use with survival-time ({helpb st}) data.  You must
{helpb stset} your data with time since entry in years as the timescale before
using {cmd:stnet}.{p_end}

{marker weight}{...}
{pstd}{cmd:iweight}s are allowed; see {help weights} and see example using weights below.  Weights must be specified as 
{cmd:[iweight=}{it:varname}{cmd:]}.{p_end}


{title:Description}

{pstd}{cmd:stnet} estimates net survival (NS) as proposed by Pohar Perme,
Stare, and Est{c e'g}ve (2012) by using a life-table estimation approach.  The
command displays the results in life tables stratified by the variables
specified in the {cmd:by()} option.  Optionally, relative survival using the
Ederer II method can be calculated.  The {cmd:stnet} command may also be used
for period or hybrid analysis and to compute adjusted (weighted)
estimates.{p_end}

{pstd}{cmd:using} {it:filename} specifies a file containing general-population
survival probabilities (conditional probabilities of surviving one year),
typically stratified by age, sex, and calendar year.  Age must be specified in
one-year increments (typically from 0 to 99), and calendar year must be
specified in one-year intervals.  The file must be sorted by the variables
specified in {cmd:mergeby()}.  Default names for variables in this file are
{cmd:prob} for the survival probabilities (see the {cmd:survprob()} option),
{cmd:_age} for age (see the {cmd:attage()} option), and {cmd:_year} for
calendar year (see the {cmd:attyear()} option).  The maximum age is specified
using the {cmd:maxage()} option.{p_end}


{title:Options}

{phang}{cmd:mergeby}{cmd:(}{it:varlist}{cmd:)} specifies the variables that
uniquely determine the records in the file of general-population survival
probabilities (the {cmd:using} file, also known as the {cmd:popmort.dta}
file).  The {cmd:using} file must also be sorted by these variables.
{cmd:mergeby()} is required.

{phang}{cmd:diagdate}{cmd:(}{it:varname}{cmd:)} specifies the variable
containing the date of diagnosis.  {cmd:diagdate()} is required. 

{phang}{cmd:birthdate}{cmd:(}{it:varname}{cmd:)} specifies the variable
containing the date of birth.  {cmd:birthdate()} is required.

{phang}{cmd:breaks}{cmd:(}{it:range}{cmd:)} specifies the cutpoints for the
life-table intervals as {it:range} in the {helpb forvalues} command.  The
units must be years; for example, use {cmd:breaks}{cmd:(0(0.08333)5)} for
monthly intervals up to five years.

{phang}{cmd:unique} specifies that cutpoints for the life-table intervals
must correspond to each observed survival time.

{phang}{cmd:by}{cmd:(}{it:varlist}{cmd:)} specifies the life-table
stratification variables.  One life table is estimated for each combination of
these variables.

{phang}{cmd:attage}{cmd:(}{it:newvar}{cmd:)} specifies the variable containing
attained age (that is, age at the time of follow-up).  This variable cannot
exist in the patient data file (it is created as the integer part of age at
diagnosis plus follow-up time) but must exist in the {cmd:using} file.  The
default is {cmd:attage(_age)}.

{phang}{cmd:attyear}{cmd:(}{it:newvar}{cmd:)} specifies the variable
containing attained calendar year (that is, calendar year at the time of
follow-up).  This variable cannot exist in the patient data file (it is
created as the integer part of year of diagnosis plus follow-up time)
but must exist in the {cmd:using} file.  The default is
{cmd:attyear(_year)}.

{phang}{cmd:survprob}{cmd:(}{it:varname}{cmd:)} specifies the variable
in the {cmd:using} file that contains the general-population survival
probabilities.  The default is {cmd:survprob(prob)}.

{phang}{cmd:maxage}{cmd:(}{it:#}{cmd:)} specifies the maximum age for
which general-population survival probabilities are provided in the
{cmd:using} file.  Probabilities for individuals older than this value
are assumed to be the same as for the maximum age.  The default is
{cmd:maxage(99)}.

{phang}{cmd:ederer2} specifies that Ederer II relative-survival
estimates be calculated.  Note that {cmd:stnet} calculates the observed
survival by transforming the interval-specific cumulative hazard;
therefore, the results are not exactly equal to those obtained by using
{helpb ltable} (Dickman 2010).

{phang}{cmd:standstrata}{cmd:(}{it:varname}{cmd:)} specifies a variable
defining strata across which to average the cumulative survival
estimate.  With this option, a {it:weight} must also be specified as
follows:  {cmd:[iweight=}{it:varname}{cmd:]}.

{phang}{cmd:brenner} specifies that the age adjustment be performed using the
approach proposed by Brenner et al. (2004).  This option requires that
{cmd:[iweight]} and {cmd:standstrata()} also be specified.

{phang}{opt indweight(varname)} specifies a variable defining individual
weights.  This option allows the specification of any kind of weights and
cannot be combined with {cmd:standstrata()} and {cmd:brenner}.

{phang}{cmd:list}{cmd:(}{it:varlist}{cmd:)} specifies the variables to
be listed in the life table.  The variables {cmd:start} and {cmd:end}
are included by default; however, if only one of these is specified in the
{cmd:list()} option, then the other is suppressed.

{phang}{cmd:at(}{it:#}|{it:{help numlist}}{cmd:)} reports estimated net
survival at specified times.

{phang}{cmd:listyearly} displays life-table survival estimates only at the end
of each year of follow-up.

{phang}{cmd:format(%}{it:fmt}{cmd:)} specifies the {help format} for variables
containing survival estimates.  The default is {cmd:format(%6.4f)}.

{phang}{cmd:notables} suppresses display of the life tables.

{phang}{cmd:level}{cmd:(}{it:#}{cmd:)} sets the confidence level based on the
value of global macro {cmd:S_level}.  The default is {cmd:level(95)}.

{phang}{cmd:saving(}{it:filename}[{cmd:, replace}]{cmd:)} specifies to save in
{it:filename} a dataset containing one observation for each life-table
interval.

{phang}{cmd:savstand(}{it:filename}[{cmd:, replace}]{cmd:)} specifies to save
standardized estimates in {it:filename}. 


{title:Examples}

{pstd}Pohar Perme NS by sex using one month as
    length of interval in the life table{p_end}
{p 4 8 2}{cmd:. stnet using lifetab, breaks(0(0.08333)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex)}

{pstd}Pohar Perme NS by sex where cutpoints of
interval in the life table correspond to each observed survival time{p_end}
{p 4 8 2}{cmd:. stnet using lifetab, unique mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) at(1(1)10)}

{pstd}
When using {cmd:unique}, results shown may be very long. Therefore, we also
specifies {cmd:at(}{it:{help numlist}}{cmd:)} to show results only at
specified {cmd:(}{it:{help numlist}}{cmd:)}

{pstd}
Note that when {cmd:unique} is specified, the time-scale is still split into
several intervals and our life-table approach is applied for the
estimation of net survival.  This is a different implementation to {cmd:stpp}
and {cmd:stns}.  In our experience, results of both approaches are close.

{pstd}Ederer II estimates by sex{p_end}
{p 4 8 2}{cmd:. stnet using lifetab, breaks(0(0.08333)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) ederer2}

    {title:Estimation using a period approach}

{pstd}The approach is to first {helpb stset} the data with calendar time
as the timescale.  For example, we might be interested in the time at
risk between 1 January 2005 and 31 December 2007.{p_end}

{p 4 8 2}{cmd:. stset datafu, fail(status==1 2) origin(dx) enter(time mdy(1,1,2005)) exit(time mdy(12,31,2007)) scale(365.24)} 

{pstd}We then can use {cmd:stnet} in the usual manner to get NS and Ederer II estimates.{p_end}

{p 4 8 2}{cmd:. stnet using lifetab, breaks(0(0.08333)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) ederer2}

    {title:Age-standardized estimates of NS}

{pstd}To age-standardize using traditional direct standardization, we could specify the following command:{p_end}

{p 4 8 2}{cmd:. stnet using lifetab [iw=standwei], breaks(0(.08333)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) standstrata(agegroup)}
 
{pstd}{cmd:stnet} first constructs life tables for each level of {cmd:sex} and
{cmd:agegroup}, and then calculates age-standardized estimates for each sex by
weighting the age-specific estimates using the weights specified in the
variable {cmd:standwei}.  The strata across which to average are defined using
the {cmdab:standstrata()} option; a variable containing the weights (which
must be less than 1) must exist in the dataset and be specified using
{cmd:[iweight=}{it:varname}{cmd:]}.

{pstd}Standard errors are estimated using the approach described by Corazziari, Quinn, and Capocaccia (2004).{p_end}

    {title:Age-adjusted estimates of net survival according to Brenner et al. (2004) approach}

{pstd}When data are sparse, the traditional age standardization can fail to
produce age-adjusted net survival estimates.  Rather than weighting based on
the age distribution at the start, Brenner et al. (2004) propose using
weights that change throughout follow-up time.  This approach produces
comparable net survival estimates even when data are sparse by assigning
individual weights to each patient and constructing a weighted life table. 

{p 4 8 2}{cmd:. stnet using lifetab [iw=standwei], br(0(.083333334)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) standstrata(agegroup) brenner}{p_end}
 
{pstd}We can assign other user-defined individual weights by specifying
{opt indweight()}.  For example, we can reproduce the above age-adjusted 
net survival estimates by typing the following commands:{p_end}

{p 4 8 2}{cmd:. local total = _N}{p_end}
{p 4 8 2}{cmd:. bysort agegroup: generate a_age = _N/`total'}{p_end}
{p 4 8 2}{cmd:. generate wt = (standwei/a_age)}{p_end}
{p 4 8 2}{cmd:. stnet using lifetab, breaks(0(.083333334)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) indweight(wt)}{p_end}

{pstd}Because {cmd:indweight(wt)} is specified, we no longer need to specify
{cmd:[iw=standwei]} and {cmd:standstrata(agegroup)}.{p_end}

    {title:Saving estimates}

{pstd}Saved estimates are needed to graph NS estimates.{p_end}

{p 4 8 2}{cmd:. stnet using lifetab, br(0(.08333)10) mergeby(_year sex _age) diagdate(dx) birthdate(bdate) by(sex) saving(colonnetsurv,replace)}


{title:Remarks}

{pstd}NS is the function of interest for cancer registries because it is the
survival that we can measure if cancer is the only cause of death.  Therefore,
it is suitable to compare cancer survival among different populations and to
analyze survival trends. Pohar Perme, Stare, and Est{c e'g}ve (2012) show that
the correlation between cancer survival and other-causes survival must be
taken into account to properly estimate NS. They propose a method based on
the inverse probability weights.  For each individual, weights are given by
the inverse of his or her expected survival probability computed from the
survival probabilities of the general population supplied in the {cmd:using}
file.  Danieli et al. (2012) prove that the Pohar Perme method actually
estimates the NS.{p_end}

{pstd} In {cmd:stnet}, we apply a life-table approach for the estimation of
the NS.  First, we compute for each interval the cumulative weighted excess
hazard given by {p_end}

{center: Hw = k x (dw - d_hatw) / pyw}

{pstd} where k is the length of the interval, dw is the weighted number of
deaths, d_hatw is the weighted number of the expected deaths, and pyw is the
weighted person-years at risk.  We then transform it in the interval-specific
NS with{p_end}

{center:NS = exp(-Hw)} 

{pstd}Finally, the cumulative NS is obtained by the product of the
interval-specific estimates.{p_end} 

{pstd}Because this approach assumes that hazard and weights are constant
within the interval, {cmd:stnet} is sensitive to the choice of interval
length.  In our experience using an interval of one month, the NS
computed by {cmd:stnet} is usually very close to the results obtained by
using the {cmd:rs.surv} function, available in the {cmd:relsurv}
package of R software, which calculates NS each time deaths and
censorings happen in the dataset.  Longer intervals usually cause
{cmd:stnet} to underestimate NS computed by {cmd:rs.surv}.{p_end}


{title:References}

{phang}
Brenner, H., V. Arndt, O. Gefeller, and T. Hakulinen. 2004. An alternative
approach to age adjustment of cancer survival rates.
{it:European Journal of Cancer} 40: 2317-2322.

{phang} Corazziari, I., M. Quinn, and R. Capocaccia.  2004.  Standard cancer
patient population for age standardising survival ratios {it:European Journal of Cancer} 40: 2307-2316.{p_end}

{phang} Danieli, C., L. Remontet, N. Bossard,  L. Roche, and A. Belot.  2012. 
Estimating net survival: The importance of allowing for informative censoring.
{it:Statistics in Medicine} 31: 775-786.{p_end}

{phang} Dickman P. W.  2010.  Standard errors of observed and relative
survival in strs.
http://www.pauldickman.com/rsmodel/stata_colon/standard_errors.pdf.{p_end}

{phang} Pohar Perme, M., J. Stare, and J. Est{c e'g}ve.  2012.  On estimation
in relative survival.  {it:Biometrics} 68: 113-120.{p_end}


{title:Acknowledgment}

{pstd}We thank Mark Rutherford for making available the code for the
simulations of relative survival data and for other tests of the
command.{p_end}


{title:Authors}

{pstd}Enzo Coviello{p_end}
{pstd}Statistics and Epidemiology Unit{p_end}
{pstd}ASL BT{p_end}
{pstd}Barletta, Italy{p_end}
{pstd}{browse "mailto:enzo.coviello@tin.it":enzo.coviello@tin.it}{p_end}

{pstd}Paul W. Dickman{p_end}
{pstd}Karolinska Institutet{p_end}
{pstd}Stockholm, Sweden{p_end}
{pstd}{browse "mailto:paul.dickman@ki.se":paul.dickman@ki.se}{p_end}

{pstd}Karri Sepp{c a:}{p_end}
{pstd}Finnish Cancer Registry{p_end}
{pstd}Helsinki, Finland{p_end}
{pstd}{browse "mailto:karri.seppa@cancer.fi":karri.seppa@cancer.fi}{p_end}

{pstd}Arun Pokhrel{p_end}
{pstd}University of Alberta{p_end}
{pstd}Edmonton, Canada{p_end}
{pstd}{browse "mailto:apokhrel@ualberta.ca":apokhrel@ualberta.ca}{p_end}


{marker also_see}{...}
{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 20, number 3: {browse "https://doi.org/10.1177/1536867X20953579":SJ20-3: st0375_3},{break}
                    {it:Stata Journal}, volume 19, number 2: {browse "https://doi.org/10.1177/1536867X19854022":SJ19-2: st0375_2},{break}
                    {it:Stata Journal}, volume 18, number 3: {browse "http://www.stata-journal.com/article.html?article=up0060":st0375_1},{break}
                    {it:Stata Journal}, volume 15, number 1: {browse "http://www.stata-journal.com/article.html?article=st0375":st0375}


{p 7 14 2}Help: {helpb stset}, {helpb strs}, (if installed),{break}
{manhelp ltable ST}{p_end}
