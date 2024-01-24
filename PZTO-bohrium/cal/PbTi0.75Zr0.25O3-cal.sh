CURRENT=`pwd`
for i in  300 400 500 550 575 600 625 650 675 700 800
do
  cd ../structure/PbTi0.75Zr0.25O3
  mkdir $i
  cp ../script/npt.lammps ../script/avg-dump-PZTO.py ../script/job-npt.json conf.lmp ../model/graph.pb $i
  cd $i
  sed -i "s/variable        TEMP            equal 100.000000/variable        TEMP            equal $i.000000/g" npt.lammps
  lbg job submit -i job-npt.json -p ./ > log 
  cd  "$CURRENT"
done
