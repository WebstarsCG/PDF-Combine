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
        $d->setContentDir("screens/jpg/demo");
        
        # set frame        
        $d->setFrame("screens/frame/frame_1399w_868h.pdf");
        
        
        #content to show default document page title
        $d->addContent({
            
                        'color'     => '#121212',
                        'font_size' => 16,                        
                        'font'      => 'Arial-bold',                         
                        'pos'       => {'x'  =>35,
                                        'y'  =>45},
                        'text'      => {'key'=>'title'}});
        
        
        # content to show current page no
        $d->addContent({'color'     => '#242424',
                        'font_size' => 18,
                        'font'      => 'Tahoma-bold', 
                        'pos'       => {'x'  =>1330,
                                        'y'  =>42},                        
                        'text'      => {'key'=>'page_no'}}); 
        
        # set extra space to image area
        $d->setImagePadding({
                           'left'   => 0,
                           'top'    => 90, # to get frame bar
                           'right'  => 0,
                           'bottom' => 0,
                           });
        
        # set output file name
        $d->setFileOut("pdfs/demo_pdf_composite.pdf");          
                
        # file process
        if($d->process()){            
            print "File Successfully Created &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open PDF</a><br>"           
        }else{            
            print "Error";    
        }
              