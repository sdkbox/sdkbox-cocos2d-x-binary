import os
import sys
import subprocess
import traceback

def _run_cmd(command,cwd):
    print ''
    print ('# Run Command:"' + command + '" in folder ['+ cwd +']')
    print ''

    ret = subprocess.call(command, shell=True,cwd=cwd)
    if ret != 0:
        print('==> Command failed: {0}, cwd: {1} '.format(command, cwd))
        print "==> Stopping build."
        sys.exit(ret)

def get_curr_path():
    return os.path.dirname(os.path.realpath(__file__))

def get_sample_path(plugin):
    return os.path.join(get_curr_path(), '..', 'sdkbox-sample-'+plugin)

def main(argv):
    plugin = argv[0]
    platforms = ['ios', 'android']
    langs = ['cpp', 'js', 'lua']

    sample_path = get_sample_path(plugin)
    # clean
    _run_cmd('git checkout -f && git clean -dxf', sample_path)

    for lang in langs:
        project_path = os.path.join(sample_path, lang)
        # update
        _run_cmd('sdkbox update --staging --nohelp', project_path)

        # compile
        if plugin != 'playphone':
            _run_cmd('cocos compile -p ios', project_path)
        _run_cmd('cocos compile -p android', project_path)


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except Exception as e:
        traceback.print_exc()
        sys.exit(1)
