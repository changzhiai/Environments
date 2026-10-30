#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import math

m = 0
h_p = 6.62606957E-34  # J*S Plank Constant
k_b = 1.38064852E-23  # m2*kg*s-2*K-1 Boltzman Constant J*K-1
l_s = 299792458      # light speed m*s-1
Tem = 300     # Temperature 300K

print "*******************************************************************"
with open('freq.txt','r') as ipt:
  while True:
    fla = True
    data = ipt.readlines()
    if len(data) == 0:
      break
    for line in data:
      nu = line
      if nu == '':
        fla = False
        print "False"
        break
      L = float(nu) * 100  # convert cm-1 to m-1
      beta = 1/(k_b * Tem)

      def get_pf(L): # get partition function
        x_i = h_p * float(L) * l_s * beta
        pf_l = x_i / (math.exp(x_i) - 1) # Left part in the entropy equation
        pf_r = math.log(1 - math.exp(-x_i))
        pf   = pf_l -pf_r
        entropy = k_b * pf
        return entropy

      Entropy = get_pf(L)  # J*K-1*mol-1
      ts      = Entropy * Tem * 6.241506E18 # in eV
      m = m + ts
      print m
 
    if fla == False:
      break
ipt.close()

#T_S = m + Tem * k_b * 6.241506E18
T_S = m

print "T*S:", T_S
