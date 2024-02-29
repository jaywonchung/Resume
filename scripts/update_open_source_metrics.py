"""This script in-place updates opensource.tex with the latest OSS metrics.

Assumptions:
- The path to the tex file is "sections/opensource.tex"
- Each repo is ordered in the same order in the about page as in `REPOS`
- "faCodeFork" appear exactly `len(REPOS)` times in the source file, and the entire line that contains "fa-code-branch" will be replaced by the filled in `METRICS_TEMPLATE`
- "Number of stars and forks are as of" appears exactly once in the about page, and the entire line that contains "Number of stars and forks are as of" will be replaced by the filled in `LAST_UPDATED_TEMPLATE`
"""

import requests
from datetime import datetime
from pprint import pprint

REPOS = [
    "jaywonchung/bert4rec-vae-pytorch",
    "jaywonchung/reason",
    "ml-energy/zeus",
    "jaywonchung/pegasus",
]

METRICS_TEMPLATE = """    {\\normalfont(\\faStarOstars \\faCodeFork~forks)}} % Content\n"""
LAST_UPDATED_TEMPLATE = "\\textit{{Number of stars and forks are as of {date}.}}\n"


def today() -> str:
    """Returns today's date in a format like Febraury 13th, 2024."""
    date = datetime.now()

    month = date.strftime("%B")
    
    day = date.day
    if 4 <= day <= 20 or 24 <= day <= 30:
        suffix = "th"
    else:
        suffix = ["st", "nd", "rd"][day % 10 - 1]
    
    year = date.strftime(", %Y")
    
    return f"{month} {day}{suffix}{year}"

def get_github_repo_stars_and_forks(repo):
    url = f"https://api.github.com/repos/{repo}"
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    return data["stargazers_count"], data["forks_count"]

def main():
    stars_and_forks = [get_github_repo_stars_and_forks(repo) for repo in REPOS]
    pprint({repo: f"{stars} stars, {forks} forks" for repo, (stars, forks) in zip(REPOS, stars_and_forks)})

    with open("sections/opensource.tex", "r") as f:
        lines = f.readlines()

    for i, line in enumerate(lines):
        if "faCodeFork" in line:
            stars, forks = stars_and_forks.pop(0)
            lines[i] = METRICS_TEMPLATE.replace("stars", str(stars)).replace("forks", str(forks))
        elif "Number of stars and forks are as of" in line:
            lines[i] = LAST_UPDATED_TEMPLATE.format(date=today())

    with open("sections/opensource.tex", "w") as f:
        f.writelines(lines)


if __name__ == "__main__":
    main()
