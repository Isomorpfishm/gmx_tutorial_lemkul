echo 0 | gmx trjconv -s pull.tpr -f pull.xtc -o conf.gro -sep

for ((i=0;i<501;i++))
do
	gmx distance -s pull.tpr -f conf${i}.gro -n index.ndx -select 'com of group "Chain_A" plus com of group "Chain_B"' -oall dist${i}.xvg
done

touch summary_distances.dat
for ((i=0;i<501;i++))
do
	d=`tail -n 1 dist${i}.xvg | awk '{print $2}'`
	echo "${i} ${d}" >> summary_distances.dat
	rm dist${i}.xvg
done

exit;