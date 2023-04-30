import os
import datetime

pathdc = os.getcwd()
# print(pathdc)

# print(os.listdir(pathdc))

mod_time = os.stat('DNAToolkit.py').st_mtime
# print(datetime.fromtimestamp(mod_time))
dir(datetime)
