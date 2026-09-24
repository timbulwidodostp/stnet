program define ht
	version 7
	args todo eta mu return
	if `todo' == -1 {
	         global SGLM_lt "Hakulinen-Tenkanen"
	         global SGLM_lf "log(-log(u/ps))"
                 exit
        }
        if `todo' == 0 {
                 gen double `eta' = ln(-ln(`mu'/($SGLM_m*$SGLM_p)))
                 exit
        }
        if `todo' == 1 {
                 gen double `mu' = $SGLM_m*$SGLM_p*exp(-exp(`eta'))
                 exit
        }
        if `todo' == 2 {
                 gen double `return' = -`mu'*exp(`eta')
                 exit
        }
        if `todo' == 3 {
                 gen double `return' = -`mu'*exp(`eta')*(1+exp(`eta'))
                 exit
        }
        di as error "Unknown call to glm link function"
        exit 198
end
