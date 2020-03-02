# Keywords
Modelname: Xap_System_With_Transcription
Description: Stochastic Simulation Algorithm input file for the dimensionfull Xap System, with transcription (Kathrin Laxhuber, 01.03.2019)

Species_In_Conc: False
#Output_In_Conc: False


# Reactions
R1:
    $pool > mrna 
    rho_m * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R2:
    mrna > $pool
    gamma_m * mrna 

R3:
    mrna > protein + mrna
    r_p * mrna

R4:
    protein > $pool
    gamma_p * protein

R5:
    xanth > $pool
    ka * xanth / (Ka + xanth) * protein

R6:
    $pool > xanth
    kbi * c / (Kbi + c) * protein

R7:
    xanth > $pool
    kbe * xanth / (Kbe + xanth) * protein

R8:
    $pool > xanth
    kn * c

R9:
    xanth > $pool
    kn * chi * xanth

 
# Variable species
mrna = 0
protein = 0
xanth = 0


# Parameters
rho_m = 25 * 1.0e-9 * 1.0e-2 * 1.0e9	# r_m * [P]/(K_P + [P]) in number of molecules molecules (per cell) per second, i.e. nM/s
gamma_m = 5 * 1.0e-3			# in 1/s
r_p = 5.0e-4  * 1.0e2			# in 1/s
gamma_p = 5.0e-4 			# in 1/s
XapR_R = 1				# dimensionless
ka = 5.0e-4 * 1.0e2			# in 1/s
kbi = 5.0e-4 * 8 * 1.0e4		# in 1/s
kbe = 5.0e-4 * 1.0e3			# in 1/s
kn = 5.0e-4 * 1				# in 1/s
c = 5.0e-5 * 5.0e1 * 1.0e9		# in number of molecules (per cell), i.e. nM
chi = 0.8				# dimensionless
Ka = 5.0e-5 * 1.0e9			# value in nM 
Kbi = 5.0e-5 * 10 * 1.0e9		# value in nM 
Kbe = 5.0e-5 * 1.0e3 * 1.0e9		# value in nM
KxA = 5.0e-5 * 1.0e3 * 1.0e9		# value in nM 
KxI = 5.0e-5 * 1.0e5 * 1.0e9		# value in nM 
expEx = 150				# dimensionless
expEc = 150				# dimensionless
