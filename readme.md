# V-Core 3 Template Extractor SCAD

## What this is

An OpenSCAD file allowing to extract areas of the panels of the V-Core 3 enclosure, to be for example 3d printed as router templates.

The result is provided in the output dir for convenience.

Some of the templates are redundant or almost-redundant, it is up to you to decide which ones you actually need by comparing them.

## Template locations

![locations](template-locations.png)

## How to use the script

  - Drop inside the directory of the DXF files
  - Verify that with the default .scad file provided the extractions shown in openscad are in the correct locations
  - Comment the last line (call to "select")
  - Execute the extraction with make_stl.py v-core-3-500-panel-templates.scad

## Features

  - Allows always matching the latest DXFs
  - Prevents human error by automating the act of transposing DXF measurements to the 3d models
  - Uses a (slightly clunky) quadrant system to indicate the overall location of each extraction
  - Auto-rotates text when on a side quadrant
  
## Possible improvements

  - Add an automatic ridge on the panel edges to allow for a thicker template without using too much material, as well as easy positionning
  - Visually indicate the quadrant
  - Check that this is compatible with the 300 and 400 version

