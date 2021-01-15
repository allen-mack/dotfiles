# Get the schema from the file.
def schema: path(..) | map(tostring) | join("/");
