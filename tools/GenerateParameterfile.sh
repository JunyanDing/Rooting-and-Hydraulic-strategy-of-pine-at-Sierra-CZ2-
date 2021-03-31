#! /bin/bash
module load intel openmpi
module load mkl
module load intel ncview
module load python/2.7
module load netcdf
module load nco

GenerateNewPar=YES
TuneDynamic="No"

### where are all the things?
scriptdir=/global/scratch/junyan_ding/CTSM_May12/CTSM_JDgs/src/fates/tools/
# the parameter file where the pft to be copied
#finnm=/global/scratch/junyan_ding/CTSM_May12/CTSM_JDgs/src/fates/parameter_files/fates_params_default.nc
finnm=/global/scratch/junyan_ding/PlantParameters/Pine_cedar/JDgs_2pft_pine_cedarV7eRcSLA10.nc

# the new parameter file to be generated from the default file for pine
# set2 will have different d2h parameters to make the trees shorter than the original one
mod_fname=/global/scratch/junyan_ding/PlantParameters/Pine_cedar/JDgs_2pft_pine_cedarV7eRcSLA12_Case1T12
#mod_fname_pine=/global/scratch/junyan_ding/PlantParameters/Pine_cedar/JDgs_1pft_pineV7eRcSLA12_Case1.nc
#mod_fname_cedar=/global/scratch/junyan_ding/PlantParameters/Pine_cedar/JDgs_1pft_cedarV7eRcSLA12_Case1.nc

### 


### record the hash of the fates version of the original cdl file
cd $scriptdir




### generate netcdf file from selected parameter file JDgs_2pft_pine_cedarV7eRcSLA10
#ncgen -o /global/scratch/junyan_ding/CTSM_May12/CTSM_JDgs/src/fates/parameter_files/fates_params_default.nc /global/scratch/junyan_ding/CTSM_May12/CTSM_JDgs/src/fates/parameter_files/fates_params_default.cdl 
$scriptdir/FatesPFTIndexSwapper.py --pft-indices=2 --fin=$finnm --fout=$mod_fname.nc

pftid=1
### modify parameter values  
### version e growth too fast, modify growth respiration factor to slow down DDBH
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_grperc --val 0.15

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_alloc_storage_cushion --val 1.5
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_scalar_cstarvation --val 0.3

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_amode --val 2 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_agb1 --val 0.21 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_agb2 --val 2.3 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_agb3 --val 2 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_agb4 --val -999.9 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_lmode --val 2
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2bl1 --val 0.12 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2bl2 --val 1.5 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2bl3 --val 1 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2ca_coefficient_max --val 0.2 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2ca_coefficient_min --val 0.15
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_hmode --val 3 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2h1 --val 1 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2h2 --val 0.95 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_d2h3 --val -999.9 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_la_per_sa_int --val 0.2 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_fire_bark_scaler --val 0.079 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_BB_slope --val 8 # v7 10, V8 12  v10 11

#$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_fmode --val 1
#$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_allom_l2fr --val 4
#$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_hydr_srl --val 60

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --var fates_hydr_kmax_rsurf1 --val 220
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --var fates_bbopt_c3 --val 10000
  
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_diameter --val 0.004

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_roota_par --val 0.6
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_rootb_par --val 0.6
  
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_slamax --val 0.014 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_slatop --val 0.014 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_stor_priority --val 0.7 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_freezetol --val -15 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_bmort --val 0.002
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --var fates_mort_understorey_death --val 0

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_seed_dbh_repro_threshold --val 10
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_seed_alloc_mature --val 0.1
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_seed_alloc --val 0

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_recruit_hgt_min --val 2
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_recruit_initd --val 0.15
 

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_wood_density --val 0.42745 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_z0mr --val 0.025

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_vcmax25top --val 40 # v7: 65, V8 55
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_prt_nitr_stoich_p1 --val 0.0175,0.0175,1e-08,1e-08,0,0.0047 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_leaf_long --val 5  

 
## modify hydraulic parameters common for pine and cedar
## define wood density and related hydraulic parameters that depend on wood density
wood_density=0.42745
# 0.64935 = 1/1.54
hydr_thetas_node="$(echo "1-$wood_density*0.64935" | bc)"   #$(expr $ID + 1) expr only work with integer, for decimal using bc e.g. "$(echo "$LAT + $D" | bc)"
hydr_resid_node="0.02,0.12,0.12,0.12"

hydr_pinot_node="$(echo "0.52-4.16*$wood_density" | bc)"
#echo $wood_density
#echo $hydr_thetas_node
#echo $hydr_pinot_node  

#$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --var fates_wood_density --val ${wood_density} 
#echo "replace thetas_node" and resid_node

$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_hydr_thetas_node --val "$hydr_thetas_node,$hydr_thetas_node,$hydr_thetas_node,$hydr_thetas_node"
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var  fates_hydr_resid_node --val ${hydr_resid_node} # "$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node"

#echo "replacing pinot"
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_hydr_pinot_node --val "$hydr_pinot_node" # "$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node"
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_hydr_avuln_gs --val 1.5 # "$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node"
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_hydr_k_lwp --val 0 # "$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node,$hydr_pinot_node"


# tune the leaf carbon balance by turning off the mortality and recuitment
if [ "${TuneDynamic}" == "YES" ]; then
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_seed_alloc_mature --val 0
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_seed_alloc --val 0
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_freezetol --val -50 
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_bmort --val 0.0002
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_hf_flc_threshold --val 0.999
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_mort_scalar_cstarvation --val 0.0001
$scriptdir/modify_fates_paramfile.py --O --fin $mod_fname.nc --fout $mod_fname.nc --pft ${pftid} --var fates_fire_bark_scaler --val 0.2 


fi




## setup sensitivity analysis
#assign range of values for each parameter

# root
#ra=[0.1 0.3 0.6 0.8 2]
#rb= [0.1 0.3 0.6 1.8 5]
roota=(0.1 0.3 0.6 0.8 2)   # roota rootb  
rootb=(0.1 0.3 0.6 1.8 5)
rtnum=$(echo ${#roota[@]})   
rtid=$(echo "$rtnum-1" | bc)
echo ${rtid}

# change new parameters for van Gen, the following parameter sets must be paired to represent two strategies
#  safe/inefficient xylem and unsafe/efficient xylem
#hydroid=(1 2)
m_vg=(0.8 0.8)
n_vg=(1.25 1.5)
alpha_vg=(0.11855 0.0880)  # alpha value is computed for P50=-2.5 and -4.8 with corresponding m and n 
kmaxnode=("1.64"  "1.28") # need to be paired with p50x  "0.88"  "0.64"

# set parameters for full sensitivity: p50gs, 
k_lwp=(1 4 7 10)
p50gs1=("-3.0" "-2.2" "-1.506" "-0.896")  # corresponding to set 1
p50gs2=("-4.8" "-3.672" "-2.70" "-1.8")  # p50gs must be calculated based on vulnarability curve to 
pgsnum=$(echo ${#p50gs1[@]})   
pgsid=$(echo "$pgsnum-1" | bc)


avulgs=("2.0"  "3.0")
# fates_hydr_avuln_node is calculated from p50x
## loop through all combinitions and generate corresponding parameter files

## change following parameter if using TFS plant hydraulic model
#p50node=("-2.80,-2.80,-2.80,-2.80" "-4.87,-4.87,-4.87,-4.87") #P50node fates_hydr_p50_node 
#p50node=("-2.50" "-4.80") #P50node fates_hydr_p50_node "-4.87"
#avuln=("2.5,2.5,2.5,2.5" "2.5,2.5,2.5,2.5")

ID=0
#   echo vgid, P50gs, roota, rootb, $pgs, $expstr
for vg in `seq 0 1 1`; do  
  The_mvg=${m_vg[vg]}
  The_nvg=${n_vg[vg]}
  The_alphavg=${alpha_vg[vg]}
  The_kmax=${kmaxnode[vg]}
  if [ "${vg}" == "0" ]; then
    Thepgs=("-3.0" "-2.2" "-1.506" "-0.896") 
    echo ${Thepgs}
  elif [ "${vg}" == "1" ]; then
    Thepgs=("-4.8" "-3.672" "-2.70" "-1.8")
  fi
  for rt in `seq 0 1 ${rtid}`; do
     TheRoota=${roota[rt]}
     TheRootb=${rootb[rt]}
 
     for pgs in `seq 0 1 ${pgsid}` ; do

#        TheP50gs="$(echo "(-1/${The_alphavg})*((1-${pgs}^0.5)^(1/${The_mvg})/(1-(1-${pgs}^0.5)^(1/${The_mvg})))^(1/${The_nvg})" | bc)" 
        TheP50gs=${Thepgs[pgs]}
        echo ${TheP50gs}
        ID=$(expr $ID + 1)
        expstr=$(printf %04d $ID)
        
#        echo $vg, $Thepgs, $TheRoota, $TheRootb, $expstr
#      ./modify_fates_paramfile.py --var fates_roota_par --allPFT --val ${a} --fin fates_params_2pft_CZ2_AlloParDefault_1PFT-PINE-MultiRun.nc --fout fates_params_2pft_CZ2_AlloParDefault_1PFT-PINE-MultiRun${expstr}.nc --O

       ./modify_fates_paramfile.py --var fates_roota_par --val ${TheRoota} --PFT 1 --fin $mod_fname.nc --fout $mod_fname${expstr}.nc --O

       ./modify_fates_paramfile.py --var fates_rootb_par --val ${TheRootb} --PFT 1 --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --O

       ./modify_fates_paramfile.py --var fates_hydr_p50_gs --val ${TheP50gs} --PFT 1 --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --O
 
       ./modify_fates_paramfile.py --O --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --PFT 1 --var fates_hydr_kmax_node --val ${The_kmax}
 
       ./modify_fates_paramfile.py --O --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --PFT 1 --var fates_hydr_alpha_vg --val ${The_alphavg}
       ./modify_fates_paramfile.py --O --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --PFT 1 --var fates_hydr_m_vg --val ${The_mvg}
       ./modify_fates_paramfile.py --O --fin $mod_fname${expstr}.nc --fout $mod_fname${expstr}.nc --PFT 1 --var fates_hydr_n_vg --val ${The_nvg}

       done
    done
done




