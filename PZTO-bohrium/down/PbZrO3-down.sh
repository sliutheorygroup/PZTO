CURRENT=`pwd`
for i in 200 300 350 400 450 500 550 600 700
do
  cd ../structure/PbZrO3
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
  python avg-dump-PZO.py traj-last.lammpstrj traj-last$i.xsf
  rm traj-last.lammpstrj
  latt=$(tail -1 lat.dat)
  echo $i $latt >> ../Tvslat.dat
  cd $CURRENT
done

  cd ../structure/PbZrO3
  python sort.py
  mv latt_sort.txt PbZrO3.dat
  cp PbZrO3.dat ../../graph

~                                                                                                                                      
~      
