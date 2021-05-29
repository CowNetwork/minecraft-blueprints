import os
import urllib.request
import base64

# Note: The working directory of this script will be always the minecraft servers root folder.
#       This simplifies many filesystem operations this script has to handle.

def download_and_move_jar(url, user, passwd):
  auth = base64.b64encode('{}:{}'.format(user, passwd).encode('utf-8')).decode('ascii')
  opener = urllib.request.build_opener()
  opener.addheaders = [('Authorization', 'Basic {}'.format(auth))]
  urllib.request.install_opener(opener)
  filename, _ = urllib.request.urlretrieve(url)
  os.rename(filename, 'plugins/{}'.format(filename))



# TODO: read config
# TODO: download all plugins
# TODO: download all maps (concurrently because of size)
# 
