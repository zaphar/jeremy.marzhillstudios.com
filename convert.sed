1 {
    i +++

    /^\[\s\]+:/ {
        s/\(.*\): \(.*\)/\1 = \"\2\"/
    }
}

/^time: / {
    s|.*: \(\[^ \] \(.*\)\)|date = \1T\2Z|

}

/^tags/ s/tags/taxonomies/
/^content-type:/ d

/^content:/ {
    i in_search_index = true
    i +++
    d
    q
}

/^\[^:\]+:/ {
    s/\(.*\): \(.*\)/\1 = \"\2\"/
}
s/^\s+- \(.+\)/\t\"\1\"\,/