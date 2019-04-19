# Pydoop client image

## The goal

We need a "production" Pydoop client image with minimal dependencies. Most
notably, it should only have a JRE, not a JDK.

## Current status

This section contains a smaller version of the base image, with no extra
dependencies (such as Maven, which is only needed to test some Avro examples).
This can be used as the basis of a Pydoop client image, albeit not minimal.
