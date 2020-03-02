# Keywords
Modelname: Xap_System_With_Transcription
Description: Stochastic Simulation Algorithm input file for the dimensionfull Xap System, with transcription (Kathrin Laxhuber, 01.03.2019)

Species_In_Conc: False
#Output_In_Conc: False


# Reactions
R1:
    $pool > mrna 
    1/4 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R2:
    $pool > {2} mrna
    1/4 * (1-1/4) * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R3:
    $pool > {3} mrna
    1/4 * (1-1/4)**2 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R4:
    $pool > {4} mrna
    1/4 * (1-1/4)**3 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R5:
    $pool > {5} mrna
    1/4 * (1-1/4)**4 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R6:
    $pool > {6} mrna
    1/4 * (1-1/4)**5 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R7:
    $pool > {7} mrna
    1/4 * (1-1/4)**6 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R8:
    $pool > {8} mrna
    1/4 * (1-1/4)**7 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R9:
    $pool > {9} mrna
    1/4 * (1-1/4)**8 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R10:
    $pool > {10} mrna
    1/4 * (1-1/4)**9 * rho_m_burst * (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc / (1 + 2*(XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))+ (XapR_R * (1+xanth/KxA)**2 / ((1+xanth/KxA)**2 + expEx * (1+xanth/KxI)**2))**2 * expEc)

R11:
    mrna > $pool
    gamma_m * mrna 

R12:
    mrna > protein + mrna
    r_p * mrna

R13:
    protein > $pool
    gamma_p * protein

R14:
    xanth > $pool
    ka * xanth / (Ka + xanth) * protein

R15:
    $pool > xanth
    kbi * c / (Kbi + c) * protein

R16:
    xanth > $pool
    kbe * xanth / (Kbe + xanth) * protein

R17:
    $pool > xanth
    kn * c

R18:
    xanth > $pool
    kn * chi * xanth

 
# Variable species
mrna = 0
protein = 0
xanth = 0


# Parameters
rho_m_burst = 25 * 1.0e-9 * 1.0e-2 * 1.0e9 / 15	# r_m * [P]/(K_P + [P]) in number of molecules molecules (per cell) per second, i.e. nM/s
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
