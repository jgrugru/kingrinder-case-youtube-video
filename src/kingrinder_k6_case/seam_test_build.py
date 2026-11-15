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
scad_file = here / "seam_test.scad"
output_dir = here / "output" / "seam_test"


def main() -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    target = output_dir / "seam_plate.stl"
    command = ["openscad", "-o", str(target), "-D", 'part="seam_plate"', str(scad_file)]
    logger.info(" ".join(command))
    result = run(command, capture_output=True, text=True)
    if result.returncode != 0:
        logger.error(result.stderr)
        raise SystemExit(result.returncode)
    for line in result.stderr.splitlines():
        if "WARNING" in line or "ERROR" in line:
            logger.warning(line)
    logger.info(f"done: {target}")


main()
