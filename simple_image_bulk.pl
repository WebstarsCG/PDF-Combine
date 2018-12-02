#!/usr/bin/perl -w 
        
        # lib path            
        BEGIN{            
            use lib 'lib/';            
        }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Composite;        
        
        # object instance with configuration                             
        my $d = new PDF::Composite();
        
        # set content dir
        $d->setContentDir("screens/jpg");
        
        # set frame        
        $d->setFrame("screens/jpg/frame.pdf");
        
        # set output file name
        $d->setFileOut("pdfs/perl_website_jpg_screens_bulk.pdf");          
        
        # content to show default document page title
        $d->addContent({
            
                        'color'     => '#626262',
                        
                        'font'      => 'Arial-bold', 
                        
                        'pos'       => {'x'  =>50,
                                        'y'  =>40},
                        'text'      => {'key'=>'title'}}
                    );
                        
        
        # content to show current page no
        $d->addContent({'color' => '#ffefb2',
                        
                        'font_size'=>12,
                        
                        'pos' => {'x'  =>1200,
                                  'y'  =>40},                        
                        'text'=> {'key'=>'page_no'}}); 
                        
        # custom text
        $d->addContent({
                        'color' => '#b28e00',
                        
                        'font_size'=>13,
                        
                        'font'     =>'Helvetica-bold', 
                        
                        'pos' => {'x'  =>1210,
                                  'y'  =>40},                        
                        'text'=> '| PDF::Composite',
                        
                        });
        
        # set extra space to image area
        $d->setImagePadding({
                           'left'   => 40,
                           'top'    => 100,
                           'right'  => 20,
                           'bottom' => 20,
                           });

        print "Content-type:text/html\n\n";
        
        # file process
        if($d->process()){            
            print "File Created "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>"           
        }else{            
            print "Error";    
        }
              