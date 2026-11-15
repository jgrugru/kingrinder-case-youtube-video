# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "loguru>=0.7.3",
# ]
# ///
from pathlib import Path
from subprocess import run

from loguru import logger

here = Path(__file__).parent
scad_file = here / "kingrinder_k6.scad"
output_dir = here / "output"


def main() -> None:
    output_dir.mkdir(exist_ok=True)
    target = output_dir / "kingrinder_k6.stl"
    command = ["openscad", "-o", str(target), str(scad_file)]
    logger.info(" ".join(command))
    result = run(command, capture_output=True, text=True)
    if result.returncode != 0:
        logger.error(result.stderr)
        raise SystemExit(result.returncode)
    for line in result.stderr.splitlines():
        if "ECHO" in line or "WARNING" in line:
            logger.info(line)
    logger.info(f"done: {target}")


main()
