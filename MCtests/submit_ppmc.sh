#!/bin/bash
#PBS -N ppmc
#PBS -l nodes=10:ppn=4
#PBS -M pennucci@virginia.edu
#PBS -m ae
#PBS -V

SCRATCHDIR=/scratch/ppmc

NITERPERNODE=5
NCHAN=512
NBIN=512
NU0=2000.0
BW=800.0
DM_INJ=0.0025
NOISE_STD=0.1

MODELFILE=model
EPHEMFILE=ephemeris

pbsdsh ${PBS_O_WORKDIR}/setupMC.sh

pbsdsh python ${SCRATCHDIR}/ppmc.py ${NITERPERNODE} ${NCHAN} ${NBIN} ${NU0} ${BW} ${DM_INJ} ${NOISE_STD} ${SCRATCHDIR}

pbsdsh ${PBS_O_WORKDIR}/postMC.sh

python ${PBS_O_WORKDIR}/ppmc_results.py ${NITERPERNODE} ${DM_INJ} ${PBS_O_WORKDIR} ${EPHEMFILE}