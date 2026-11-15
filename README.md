# Kingrinder K6 Case

OpenSCAD models for a Kingrinder K6 hand grinder and a printable case built around it. Python build scripts render the `.scad` files to STL.

## Requirements

- [uv](https://docs.astral.sh/uv/)
- [OpenSCAD](https://openscad.org/) on your `PATH` (`openscad` command)

Each build script declares its own dependencies in an inline script header, so `uv run` handles the Python environment. No install step needed.

## Build

Run from the repo root.

### Grinder model

```sh
uv run src/kingrinder_k6/build.py
```

Writes `src/kingrinder_k6/output/kingrinder_k6.stl`.

### Case

```sh
uv run src/kingrinder_k6_case/build.py
```

Writes both case halves to `src/kingrinder_k6_case/output/`:

- `lower_case_body.stl` (bottom half)
- `upper_case_body.stl` (top half)

Only these two STLs and the grinder STL are committed. Other build output (G-code, `.3mf`, seam test plate) is gitignored.

The case includes `src/kingrinder_k6/kingrinder_k6.scad`, so changes to the grinder model affect the case.

### Seam test plate

```sh
uv run src/kingrinder_k6_case/seam_test_build.py
```

Writes `src/kingrinder_k6_case/output/seam_test/seam_plate.stl`. `seam_test.scad` is self-contained and does not include the case file.
