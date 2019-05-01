#!/usr/bin/perl -w 
        
        # lib path            
        BEGIN{            
            use lib 'lib/';            
        }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Composite;
        
        print "Content-type:text/html\n\n";
        
        # object instance with configuration                             
        my $d = new PDF::Composite();
        
        # set content dir
        $d->setContentDir("screens/jpg");
        
        # set frame        
        $d->setFrame("screens/frame/frame_1399w_768h.pdf");
        
        # set output file name
        $d->setFileOut("pdfs/composite_demo.pdf");          
                
        # file process
        if($d->process()){            
            print "File Successfully Created &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open PDF</a><br>"           
        }else{            
            print "Error";    
        }
              