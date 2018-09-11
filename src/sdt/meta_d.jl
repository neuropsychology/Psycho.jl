# function [ret]=metadprimepm(h,f,Hp,Fp,Hm,Fm,sigma)
#
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %  Code for computing meta-dprime-balance
# %
# %  Adam Barrett August 2012
# %
# % INPUTS:       h: type I HR
# %               f: type I FAR
# %               Hp: type II HR for positive type I responses
# %               Fp: type II FAR for positive type I responses
# %               Hm: type II HR for negative type I responses
# %               Fm: type II FAR for negative type I responses
# %               sigma: assumed ratio of signal standard deviations for stimulus B versus stimulus A (default value 1)
# %
# % OUTPUTS:      ret.dprime
# %               ret.metadprimebalance
# %               ret.stable: indicates stability according to equation (29),
# %                           taking the value 1 if this stability criterion is satisfied
# %                           and the value 0 if it is not satisfied
# %               ret.htp : meta type I HR arising from the type II data H_+ and F_+
# %               ret.ftp : meta type I FAR arising from the type II data H_+ and F_+
# %               ret.htm : meta type I HR arising from the type II data H_- and F_-
# %               ret.ftm : meta type I FAR arising from the type II data H_- and F_-
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#
# % Compute d' and relative type I threshold
# zf=icdf('Normal',f,0,1);
# zh=icdf('Normal',h,0,1);
# theta=-zf;
# dprime=sigma*zh-zf;
# thetaprime=theta/dprime;
#
# global th hp fp hm fm ssigma
# th=thetaprime;
# hp=Hp;
# fp=Fp;
# hm=Hm;
# fm=Fm;
# ssigma=sigma;
#
# % Solve equations for meta-d'_plus and meta-d'_minus
# x0=[theta;dprime];
# ep=fsolve(@eqformetadplus,x0);
# metadprimeplus=ep(2)
#
# x0=[thetaprime;dprime];
# em=fsolve(@eqformetadminus,x0);
# metadprimeminus=em(2)
#
# % Compute meta type I data
# htp=1-cdf('Normal',th*ep(2),ep(2),sigma);
# ftp=1-cdf('Normal',th*ep(2),0,1);
# htm=1-cdf('Normal',th*em(2),em(2),sigma);
# ftm=1-cdf('Normal',th*em(2),0,1);
#
# % Infer stability of output based on equation (29)
# stable=1;
# if htp>0.95 || ftp>0.95 || htm>0.95 || ftm>0.95 || htp<0.05 || ftp<0.05 || htm<0.05 || ftm<0.05
#     disp('Warning, unstable data');
#     stable=0;
# end
#
# % Compute proportion of positive type I responses for the weighting in
# % formula for meta-d'-balance
# r=(h+f)/2;
#
# ret.dprime=dprime;
# ret.metadprimebalance=r*metadprimeplus+(1-r)*metadprimeminus;
# ret.stable=stable;
# ret.htp=htp;
# ret.ftp=ftp;
# ret.htm=htm;
# ret.ftm=ftm;
