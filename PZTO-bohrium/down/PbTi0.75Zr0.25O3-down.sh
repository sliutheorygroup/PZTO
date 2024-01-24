CURRENT=`pwd`
for i in 300 400 500 550 575 600 625 650 675 700 800
do
  cd ../structure/PbTi0.75Zr0.25O3
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
  python avg-dump-PZTO.py traj-last.lammpstrj traj-last$i.xsf
  rm traj-last.lammpstrj
  latt=$(tail -1 lat.dat)
  echo $i $latt >> ../Tvslat.dat
  cd $CURRENT
done

  cd ../structure/PbTi0.75Zr0.25O3
  python sort.py
  mv latt_sort.txt PbTi0.75Zr0.25O3.dat
  cp PbTi0.75Zr0.25O3.dat ../../graph

