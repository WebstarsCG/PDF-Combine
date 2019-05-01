#!/usr/bin/perl -w 
        
        # lib path            
        BEGIN{            
            use lib 'lib/';            
        }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Composite;
        
        use Data::Dumper;
        
        # object instance with configuration                             
        my $d = new PDF::Composite();
               
        # set frame        
        $d->setFrame("screens/template/certificate.pdf");
        
        # set content from csv         
        $d->setTemplateContentFromCSV("csv/student_ii.csv");
        
        # set template style
        # 1 st col
        $d->addTemplateStyle({            
                        'color'     => '#242424',                        
                        'font'      => 'Arial-bold',
                        'font_size' => 32,                                                
                        'pos'       => {'x'  =>180,
                                        'y'  =>450}
                    });
        
        #2nd col
        $d->addTemplateStyle({       
                    'is_img'        => 1,
                    'default'       => 'screens/template/sign_raj.jpg',
                    'x'             => 180,
                    'y'             => 690,
                    'scale'         => 75
                });
                     
        # set output file name
        $d->setFileOut("pdfs/perl_template_csv.pdf");          
        
        print "Content-type:text/html\n\n";
                
        # file process
        if($d->process()){                    
            print "File Created for Simple Template with CSV &raquo; ".
                  "<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>";        
        }else{
            print "Error";    
        }
              