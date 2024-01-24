CURRENT=`pwd`
for i in 200 300 350 400 450 500 550 600 700
do
  cd ../structure/PbTi0.5Zr0.5O3
  mkdir $i
  cp ../script/npt.lammps ../script/avg-dump-PZTO.py ../script/job-npt.json conf.lmp ../model/graph.pb $i
  cd $i
  sed -i "s/variable        TEMP            equal 100.000000/variable        TEMP            equal $i.000000/g" npt.lammps
  lbg job submit -i job-npt.json -p ./ > log 
  cd  "$CURRENT"
done
