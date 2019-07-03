"""\
Manual image builder for local use. "Official" images are built and
pushed by Travis.
"""

import argparse
import io
import os
import subprocess
import sys
import yaml

THIS_DIR = os.path.dirname(os.path.abspath(__file__))
TRAVIS_FN = os.path.join(THIS_DIR, ".travis.yml")
CHOICES = ["all", "base", "client"]
DEFAULT_CHOICE = "all"


def get_env_settings():
    rval = []
    with io.open(TRAVIS_FN, "rt") as f:
        data = yaml.safe_load(f)
    for d in data["matrix"]["include"]:
        env = dict(_.split("=") for _ in d["env"].split())
        env["TRAVIS_PYTHON_VERSION"] = d["python"]
        rval.append(env)
    return rval


def build_images(subd, env_list):
    script = os.path.join(THIS_DIR, subd, "build.sh")
    for env in env_list:
        print(f"* calling {script} with env: {env}")
        subprocess.check_call(f"bash {script}", env=env, shell=True)


def main(args):
    env_list = get_env_settings()
    if args.what != "all":
        build_images(args.what, env_list)
    else:
        for c in CHOICES:
            if c != "all":
                build_images(c, env_list)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("what", metavar="|".join(CHOICES), choices=CHOICES,
                        default=DEFAULT_CHOICE, help="what to build")
    main(parser.parse_args(sys.argv[1:]))
