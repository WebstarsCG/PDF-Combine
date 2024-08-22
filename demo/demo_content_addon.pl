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
        
        $d->setFrame("../content/frame/frame_1399w_868h.pdf");
                
        $d->addContent({'color'     => '#121212',         # text color  
                        'font'      => 'Arial-bold',      # font
                        'font_size' => 14,                # text size       
                        'text'      => {'key'=>'title'},  # default key for get page name information 
                        'x'         => 35,
                        'y'         => 55});
          
            # content to show current page no
        $d->addContent({'color'     => '#454545',
                        'font_size' => 18,                                               
                        'text'      => {'key'=>'page_no'},
                        'x'         => 1330,
                        'y'         => 55});
       
        # set output file name
        $d->setFileOut("../pdf_out/demo_content_addon.pdf");
        
        $d->setImagePadding({'top'=>100});
                
        # file process
        print (($d->process())?"Demo created with images &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              
        __END__
              