#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

#c_mine1 = [1522.124727877, -5.827535293e-01, 1.719953959e-05, 5.154709794e-10, -8.645663746e-15, 2.615642185e-18]
#c_mine2 = [1522.051834560, -5.827508415e-01, 1.719968131e-05, 5.154696685e-10, -8.658016005e-15, 2.657720366e-18]

c_mine1 = [19346.597799089, -1.912674515e-02, -2.566936376e-05, 1.695483257e-11, 1.133295608e-14, 1.256404330e-19]
c_mine2 = [18755.600077771, -3.167667980e-01, -2.176179671e-05, 2.807764441e-10, 9.221255532e-15, 1.332537475e-18]

#c_calc1 = [1.522124727342147e+03, -5.827535292422271e-01, 1.719954238170236e-05, 5.153838776018316e-10,	-7.709534314103712e-15,	-6.946351787097981e-19]
#c_calc2 = [1.522051834025111e+03, -5.827508414383025e-01, 1.719968410401525e-05, 5.153824970292206e-10,	-7.721325807811085e-15,	-6.542850109439960e-19]

c_calc1 = [1.934659779907150e+04, -1.912674519240529e-02, -2.566936369919113e-05, 1.695244215291882e-11, 1.136036907656462e-14, 2.664914729860746e-20]
c_calc2 = [1.875560007747978e+04, -3.167667980582387e-01, -2.176179511184712e-05, 2.807269139987806e-10, 9.752612811980905e-15, -5.444960754565607e-19]

c_mine1.reverse()
c_mine2.reverse()

c_calc1.reverse()
c_calc2.reverse()

# Create poly1d objects
poly_mine1 = np.poly1d(c_mine1)
poly_mine2 = np.poly1d(c_mine2)

poly_calc1 = np.poly1d(c_calc1)
poly_calc2 = np.poly1d(c_calc2)

baseline_mine = poly_mine1-poly_mine2
baseline_calc = poly_calc1-poly_calc2

t = np.linspace(0, 120, 17)

# Evaluate the polynomials over the time range
mine_values = baseline_mine(t)
calc_values = baseline_calc(t)

# Calculate the difference between the two polynomials
difference = (mine_values - calc_values)*1e6

print("Mine baseline nsec")
print(mine_values*1e3)
print()
print("Calc baseline nsec")
print(calc_values*1e3)
print()
print("Baseline difference pSec")
print(difference)
print()
print("Antenna differences pSec")
print((poly_mine1(t)-poly_calc1(t))*1e6)
print((poly_mine2(t)-poly_calc2(t))*1e6)

## Plot the difference
#plt.plot(t, difference, label="Difference (poly1 - poly2)")
#plt.xlabel("Time (t)")
#plt.ylabel("Difference")
#plt.axhline(0, color='gray', linestyle='--')  # Add a horizontal line at y=0
#plt.legend()
#plt.show()
