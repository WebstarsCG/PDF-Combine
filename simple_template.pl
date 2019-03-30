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
               
        # set frame        
        $d->setFrame("screens/template/certificate.pdf");
                 
        # set template content
        $d->setTemplateContent([['Person A','screens/template/sign_raj.jpg'],
                                ['Person B','screens/template/sign_raj.jpg']
                                ]);
        
        # set template style         
        # 1 st col
        $d->addTemplateStyle({            
                        'color'     => '#242424',                        
                        'font'      => 'Arial-bold',
                        'font_size' => 72,
                        'pos'       => {'x'  =>170,
                                        'y'  =>465}
                    });
        
         $d->addTemplateStyle({            
                        'is_img'    => 1,                      
                        'x'         => 180,
                        'y'         => 690,
                        'scale'     => 75
                    });
        
        # set output file name
        $d->setFileOut("pdfs/perl_template.pdf");          
        
        print "Content-type:text/html\n\n";
        
        # file process
        if($d->process()){                    
            print "File Created for Simple Template  &raquo; ".
                  "<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>";        
        }else{
            print "Error";    
        }
              