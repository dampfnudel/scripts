import shutil, errno

MACOS_WALLPAPERS_PATH = '/Library/Desktop\ Pictures\'
MACOS_WALLPAPERS_DESTINATION = '/Library/Desktop\ Pictures\'

if not os.path.exists(directory):
    os.makedirs(directory)

def copyanything(src, dst):
    try:
        shutil.copytree(src, dst)
    except OSError as exc: # python >2.5
        if exc.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else: raise

def backup_wallpapers():
