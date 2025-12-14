import subprocess, json, os

def run_terraform(framework, git_url):
    os.chdir("../terraform")
    subprocess.run(["terraform", "init"], check=True)
    subprocess.run([
        "terraform", "apply", "-auto-approve",
        f"-var=framework={framework}",
        f"-var=git_url={git_url}"
    ], check=True)
    out = subprocess.check_output(["terraform", "output", "-json"])
    return json.loads(out)["lxc_ip"]["value"]
