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
        $d->setFileOut("pdfs/perl_website_jpg_screens_bulk.pdf");          
        
        #content to show default document page title
        $d->addContent({
            
                        'color'     => '#121212',
                        'font_size' =>14,                        
                        'font'      => 'Arial-bold',                         
                        'pos'       => {'x'  =>35,
                                        'y'  =>45},
                        'text'      => {'key'=>'title'}}
                    );
                              
        # content to show current page no
        $d->addContent({'color'     => '#ffefb2',
                        'font_size' => 11,
                        'pos'       => {'x'  =>1150,
                                       'y'  =>45},                        
                        'text'      => {'key'=>'page_no'}}); 
                        
        # custom text
        $d->addContent({
                        'color'     => '#b28e00',
                        'font_size' =>11,                        
                        'font'      =>'Helvetica-bold',                         
                        'pos'       => {'x'  =>1160,
                                        'y'  =>45},                        
                        'text'      => ' | PDF::Composite'});
                
        
        # custom page content
        $d->setPageContent({
                                '3_metacpan' => [
                                                                           
                                                    {
                                                        
                                                        'color'     => '#818181',
                                                        'font'      => 'Helvetica',
                                                        'font_size' => 11,  
                                                        
                                                        'pos'       => {'x' =>500,
                                                                        'y' =>403},                                                                                 
                                                        
                                                        # custom text
                                                        'text'       =>'Give your search here...',
                                                    }
                                                
                                                ]   
                        
                        });
        
        # set extra space to image area
        $d->setImagePadding({
                           'left'   => 10,
                           'top'    => 90,
                           'right'  => 10,
                           'bottom' => 30,
                           });

        
        
        # file process
        if($d->process()){            
            print "File Created "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>"           
        }else{            
            print "Error";    
        }
              