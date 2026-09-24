*! version 1.3.9 06nov2013
*! by Michael Hills, Paul Dickman, and Enzo Coviello
*! Updated August 2013 to correct a bug that gave incorrect 
*! results when interval widths were other than 1.
program define esteve
version 7
args lnf theta
qui replace `lnf'=-exp(`theta')*y if $ML_y1==0
* qui replace `lnf'=ln(-ln(p_star)+exp(`theta'))-exp(`theta')*y if $ML_y1==1
qui replace `lnf'=ln(-ln(p_star^(1/(end-start)))+exp(`theta'))-exp(`theta')*y if $ML_y1==1
end
