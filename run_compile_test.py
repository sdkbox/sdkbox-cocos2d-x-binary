import os
import sys
import subprocess
import traceback

def get_curr_path():
    return os.path.dirname(os.path.realpath(__file__))

def get_sample_path(plugin):
    return os.path.join(get_curr_path(), '..', 'sdkbox-sample-'+plugin)

def build(plugin, lang, platform):
    run_sample_sh = os.path.join(get_curr_path(), 'run_sample.sh');
    cmd = [run_sample_sh, plugin, lang, platform, '--update-staging', '--compile-only']

    print '# Execute: ' + ' '.join(cmd)

    if platform == 'ios':
        # ignore "ios-deploy" error
        try:
            subprocess.call(cmd)
        except Exception as e:
            None

        # "cocos compile" substitutes for 'run_sample.sh', avoiding "ios-deploy"
        ios_proj_path = os.path.join(get_sample_path(plugin), lang, 'frameworks', 'runtime-src', 'proj.ios_mac')
        if lang == 'cpp':
            ios_proj_path = os.path.join(get_sample_path(plugin), lang, 'proj.ios_mac')
        cmd = ['cocos', 'compile', '-s', ios_proj_path, '-p', platform, '-j', '8']

    try:
        subprocess.check_call(cmd)
    except subprocess.CalledProcessError as e:
        print '# build project for ' + platform + ' Failed. plugin: ' + plugin + ' lang: ' + lang + ' command: ' + ' '.join(e.cmd)
        return 1
    except Exception as e:
        print '# build project for ' + platform + ' Failed. plugin: ' + plugin + ' lang: ' + lang + ' error: ' + str(e)
        return 1

    print '# build project for ' + platform + ' SUCCESS. plugin: ' + plugin + ' lang: ' + lang
    return 0

def main(argv):
    plugin = argv[0]
    platforms = ['ios', 'android']
    langs = ['cpp', 'js', 'lua']

    for p in platforms:
        for l in langs:
            if build(plugin, l, p) != 0:
                return 1

if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except Exception as e:
        traceback.print_exc()
        sys.exit(1)
