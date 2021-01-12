#Use python to generate bp parameters from a sequence file
#Outputs bp_step.par
#Sequence File Format
#<number of base pairs> 
#<sense sequence (5’->3’)>
python make_bp_params.py sequence

#Use X3DNA rebuild to generate pdb for the DNA in BDNA shape
x3dna_utils cp_std BDNA rebuild -atomic bp_step.par atomistic.pdb

#map atomistic model to CG model
python pdb2cg_dna.py atomistic.pdb

#Generate Curved B DNA 
##icnf.exe sequence 1 1 . 0
##replace_atoms.sh conf_lammps.in dna_conf.in bdna_curv_conf.in python make_list_files.py bdna_curv_conf.in
