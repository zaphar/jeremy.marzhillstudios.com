+++
title = "Data::Annotated and Class::Data::Annotated"
date = 2007-08-27T16:43:45Z
in_search_index = true
[taxonomies]
tags = [
"Site-News",
]
+++
So I've added two new modules to my CPAN repertoire. Data::Annotated and Class::Data::Annotated. Data::Annotated is a module intended to hold an annotation about a piece of a data structure independently of the Data::Structure itself. The annotation can be anything a hash an array or a scalar value. The piece of the data structure is referenced by a Data::Path. Class::Data::Annotated wraps a perl data structure and an associated set of annotations together in one place. I've also added to Data::Path's functionality so that it can annotate object methods and coderefs stored in a data structure. Once I've ironed out details with the original author I'll hopefully be uploading that. Anyway feel free to check them out = "<a href="http://search.cpan.org/~zaphar/">My CPAN Libraries</a>"
