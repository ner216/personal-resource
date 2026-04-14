# RPM Spec Files

### Overview

RPM uses '.spec' files as instructions on how to build the rpm package.

### Notes

- Commented lines cannot contain macros
    - RPM will process the macros before it processes the comments, leading to errors.
