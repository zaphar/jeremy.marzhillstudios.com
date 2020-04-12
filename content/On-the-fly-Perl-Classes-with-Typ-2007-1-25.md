+++
title = "On the fly Perl Classes with Type restricted attributes"
date = 2007-01-25T19:34:17
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"Perl",
	"Software-Development",
]
+++
There is a CPAN module <a href="http://search.cpan.org/~nwclark/perl-5.8.8/lib/Class/Struct.pm">Class::Struct</a> that can give you this same functionality. But fool that I am I like to do things the hard way. Now the differences in the useage of this implementation, while it may not do things as automatically as Class Struct does, will allow you to create simple type restricted attributes on the fly in your code with a simple one line class method. You could even bundle this in with an AUTOLOAD function to build the attributes as you need them. Also the class attributes are added at runtime and with a little extra work you can even specify such things as typed arrays or hashes. Ok enough Pro's and Cons lets take a look at the code. First we take a look at our base class that does most of the work. <code syntax=perl>
package Class::Builder;
sub new {
  my $class = ref($_[0]) || $_[0];
  my $self = {};
  return bless($self, $class);
}
sub attribute {
  my $self = $_[0];
  my $type = $_[1];
  my $attribute = $_[2];
  my $value = $_[3];
  if ($value) {
    #handle INT case
    if ($type eq "INT") {
      if ($value =~ /^[0-9]+$/) {
        $_[0]->{$attribute} = $_[3];
        return $_[0]->{$attribute};
      } else {
        $_[0]->err("Not a $type value for $attribute");
        return undef;
      }
    } elsif ($type eq "SCALAR") {
      #handle simple SCALAR case $_[0]->{$attribute} = $_[3];
      return $_[0]->{$attribute};
    } elsif (ref($value) eq $type) {
      #handle other types
      $_[0]->{$attribute} = $_[3];
      return $_[0]->{$attribute};
    } else {
      $_[0]->err("Not a $type value for $attribute");
      return undef;
    }
  } else {
    $_[0]->err("No value passed for $attribute in ".ref($_[0]));
  }
  return $_[0]->{$attribute};
}
sub err {
  $_[0]->{err} = $_[1] if $_[1];
  return $_[0]->{err};
}
return 1;
</code> Now lets see how we can use it. <code syntax=perl>
package Document;
use Class::Builder;
use Document::Section;
use base qw(Class::Builder);
#Attribute Methods
# example of a SCALAR Typed Attribute implementation
sub Name {
  return $_[0]->attribute('SCALAR', 'Name', $_[1]);
}
#Example of a ARRAY Typed Attribute with a further simple check
#that the array elements are of type = "Document::Section"
sub Sections {
  my $arraytype = 'Document::Section';
  my $sections_old = $_[0]->Sections();
  my $sections = $_[0]->attribute('ARRAY', 'Sections', $_[1]);
  foreach (@$_[0]) {
    if (ref($_) ne $arraytype) { #throw an error here
      $_[0]->err("Invalid Array Element $arraytype");
      $_[0]->attribute('ARRAY', 'Sections', $sections_old);
      # reset the Sections array return undef;
    }
  }
  # die "sections is a ".ref($sections);
  return $sections;
}
# example of a HASH typed Attribute
sub Meta {
  return $_[0]->attribute('HASH', 'Meta', $_[1]);
}
# example of an INT typed Attribute;
sub Cursor {
  return $_[0]->attribute('INT', 'Cursor', $_[1]);
}
</code> I'm not finished modifying this concept so I may post some additional enhancments later. But you can get the idea now. 
