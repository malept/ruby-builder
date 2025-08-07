#!/usr/bin/env python3

import json
import os
from pathlib import Path

root_dir = (Path(__file__) / ".." / "..").resolve(strict=True)
with open(os.environ["GITHUB_OUTPUT"], "a") as output:
    output.write("ruby_versions=")
    versions = [
        p.read_text().strip().split()[1]
        for p in sorted((root_dir / "versions").glob("*/.ruby-version"))
    ]
    json.dump(versions, output)
    output.write("\n")
