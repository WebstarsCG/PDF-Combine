#!/usr/bin/perl -w 
        
# set local lib path where PDF combine resides           
BEGIN{ use lib './lib/'; }

# include lib
use PDF::Combine;

use CGI::Carp qw/fatalsToBrowser/;       
			
# PDF::combine object instance with configuration        
my $d = new PDF::Combine({  # set path of directory where pdf's resides
							'contentDir'   => "content/pdf",
							
							# set path for new pdf file creation
							'fileOut'      => "pdf_out/pdf_combine.pdf" });                                

###################################################################################################################################
  
print "Content-type:text/html\n\n";

# do the combine process
print (($d->process())?"File created with combining pdf's &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");


__END__      
        
        