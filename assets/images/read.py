import os
directory = './'
file = open("output.txt","w+")
with os.scandir(directory) as entries:
	for entry in entries:
		print('- images/'+entry.name)
		file.write('  - images/'+entry.name+'\n')