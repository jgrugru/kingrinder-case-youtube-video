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
scad_file = here / "kingrinder_k6_case.scad"
output_dir = here / "output"
printed_parts = {"print_lower": "lower_case_body", "print_upper": "upper_case_body"}


def render(target: Path, *extra: str) -> None:
    command = ["openscad", "-o", str(target), *extra, str(scad_file)]
    logger.info(" ".join(command))
    result = run(command, capture_output=True, text=True)
    if result.returncode != 0:
        logger.error(result.stderr)
        raise SystemExit(result.returncode)
    for line in result.stderr.splitlines():
        if "WARNING" in line or "ERROR" in line:
            logger.warning(line)


def main() -> None:
    output_dir.mkdir(parents=True, exist_ok=True)
    for part, file_name in printed_parts.items():
        render(output_dir / f"{file_name}.stl", "-D", f'part="{part}"')
    logger.info(f"done: {output_dir}")


main()
