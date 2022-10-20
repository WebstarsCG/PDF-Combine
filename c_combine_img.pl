#!/usr/bin/perl -w 
        
        # set local lib path where PDF combine resides          
        BEGIN{ use lib './lib/'; }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Combine;
        
        print "Content-type:text/html\n\n";
        
        # PDF::combine object instance                            
        my $d = new PDF::Combine();
        
        # set content dir
        $d->setContentDir("content/jpg/web");
                
        # set output file
        $d->setFileOut("pdf_out/combine_img.pdf");          
                   

        # do the combine process
        print (($d->process())?"File created with combining of images in a pdf frame with page title &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              