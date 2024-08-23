#!/usr/bin/perl -w 

# set local lib path where PDF combine resides          
BEGIN{ use lib './lib/'; }

# include lib
use PDF::Combine;

use CGI::Carp qw/fatalsToBrowser/;
		
# PDF::combine object instance with configuration

my $d = new PDF::Combine({                                    
							# file output                
							'fileOut'      => "pdf_out/pdf_combine_addon_text.pdf",

							# content dir
							'contentDir'   => "content/pdf",
							
							# set over lay contents in AoH (Array of Hashes)
							'content'=>[
											# page number                
											{   'color'     => '#121212',          # text color                                                        
												'font'      => 'Helvetica-bold',   # font                                                        
												'font_size' => 32,                 # text size                                                         
												'text'       => {'key'=>'page_no'},# default key for get page number from page name information 
												'x'          => 20,       
												'y'          => 575},
											
											# show a text                                                     
											{   'color'     => '#454545',
												'font_size' => 9,                  
												'text'       => 'Perl Sites',      # text to show
												'x'          => 20,       
												'y'          => 600},                                                        
										]
						});

###################################################################################################################################
  
print "Content-type:text/html\n\n";

# do the combine process
print (($d->process())?"File created with combining of pdf's with additional text layer &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
	  
__END__
