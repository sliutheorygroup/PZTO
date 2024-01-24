CURRENT=`pwd`
for i in 300 400 450 475 500 525 550 600 700
do
  cd ../structure/PbTiO3
  cp ../../script/sort.py .
  cd $i
  a=$(grep -o -E 'JOB ID: [0-9]+' log | awk '{print $NF}')
  lbg job download $a
  cd $a
  mv traj.lammpstrj ../
  cd ..
  rm -rf $a 
  if [ -e lat.dat ]; then
    rm lat.dat
  fi
  nline=$((5009 * 200))
  tail -$nline  traj.lammpstrj >> traj-last.lammpstrj
  python avg-dump-PTO.py traj-last.lammpstrj traj-last$i.xsf
  rm traj-last.lammpstrj
  latt=$(tail -1 lat.dat)
  echo $i $latt >> ../Tvslat.dat
  cd $CURRENT
done

  cd ../structure/PbTiO3
  python sort.py
  mv latt_sort.txt PbTiO3.dat
  cp PbTiO3.dat ../../graph
