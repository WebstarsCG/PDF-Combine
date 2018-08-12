#!/usr/bin/perl -w 
        
        # lib path            
        BEGIN{            
            use lib 'lib/';            
        }
        
        # include lib
        use PDF::Composite;        
        
        # object instance with configuration                             
        my $d = new PDF::Composite();
        
        # set content dir
        $d->setContentDir("screens/jpg");
        
        # set output file name
        $d->setFileOut("pdfs/perl_website_jpg_screens_bulk.pdf");          
        
        # content to show default document page title
        $d->addContent({
                        'font'     =>'Arial-bold', 
                        
                        'pos' => {'x'  =>20,
                                  'y'  =>650},
                        'text'=> {'key'=>'title'}});
                        
        
        # content to show current page no
        $d->addContent({
                        
                        'color' => 0.5,
                        
                        'font_size'=>12,
                        
                        'pos' => {'x'  =>1200,
                                  'y'  =>650},                        
                        'text'=> {'key'=>'page_no'}}); 
                        
        # custom text
        $d->addContent({
                        
                        'font_size'=>13,
                        
                        'font'     =>'Helvetica-bold', 
                        
                        'pos' => {'x'  =>1210,
                                  'y'  =>650},                        
                        'text'=> '| PDF::Composite',
                        
                        });
        
        # set extra space to image area
        $d->setImageExtra({
                           'height'=>40,
                           'width'=>40
                           
                           });

        print "Content-type:text/html\n\n";
        
        # file process
        if($d->process()){            
            print "File Created "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>"           
        }else{            
            print "Error";    
        }
              