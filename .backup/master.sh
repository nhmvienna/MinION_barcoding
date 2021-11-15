## add new test users for the course
#
# Iris Fischer
# Min Chai
# Marcia Sittenthaler
# Tanja Schuster
# Martin Schwentner
# Sandra Kirchner
# Niko Helmer
# Christoph Leeb
# Pedro Frade
# Luise Kruckenhauser
# Andreas Kroh
# Anja Palandacic
# Oliver Macek
# Christian Bräuchler
# Martin Kapun
# Susi Reier
# Hannah Schubert
# Stefan Prost


ifischer   tschuster     pfrade     cbraeuchler   hschubert sprost
sudo -s

for name in mchai cleeb nhelmer skirchner sreier msittenthaler apalandacic mschwentner lkruckenhauser mkapun awanka akroh omacek

do

  #userdel "test_"$name
  sh /media/inter/mkapun/projects/MinION_barcoding/.backup/TestUser.sh ${name}

done
