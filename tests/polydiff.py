#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

c1 = [3.231822197836727e+03, -6.652617751645128e-01, 1.265216394542455e-05, 5.894770593153189e-10, -6.602209691161825e-15, 3.061516589510442e-18]
c2 = [3.231822197226197e+03, -6.652617752312826e-01, 1.265217088838681e-05, 5.893082335389149e-10, -4.974033188075584e-15, -2.365457866733383e-18]
c1.reverse()
c2.reverse()

# Create poly1d objects
poly1 = np.poly1d(c1)
poly2 = np.poly1d(c2)

t = np.linspace(0, 120, 10)

# Evaluate the polynomials over the time range
poly1_values = poly1(t)
poly2_values = poly2(t)

# Calculate the difference between the two polynomials
difference = (poly1_values - poly2_values)*1e7

print(difference)

## Plot the difference
#plt.plot(t, difference, label="Difference (poly1 - poly2)")
#plt.xlabel("Time (t)")
#plt.ylabel("Difference")
#plt.axhline(0, color='gray', linestyle='--')  # Add a horizontal line at y=0
#plt.legend()
#plt.show()
