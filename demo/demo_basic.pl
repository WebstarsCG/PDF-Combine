#!/usr/bin/perl -w 
        
        # set local lib path where PDF combine resides           
        BEGIN{ use lib '../lib'; }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Combine;
        
        print "Content-type:text/html\n\n";
        
        # object instance with configuration                             
        my $d = new PDF::Combine();
        
        # set content dir where the images resides
        $d->setContentDir("../content/jpg/demo");
       
        # set output file name
        $d->setFileOut("../pdf_out/demo_basic.pdf");          
                
        # file process
        print (($d->process())?"Demo created with images &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              
        __END__