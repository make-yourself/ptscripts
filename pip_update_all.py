import pip
import pip3
from subprocess import call

for dist in pip.get_installed_distributions():
    call("pip install --upgrade " + dist.project_name, shell=True)

for dist in pip3.get_installed_distributions():
    call("pip3 install --upgrade " + dist.project_name, shell=True)
