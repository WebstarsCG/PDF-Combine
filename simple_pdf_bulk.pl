#!/usr/bin/perl -w 
        
        # lib path            
        BEGIN{            
            use lib 'lib/';            
        }
        
        # include lib
        use PDF::Composite;
                
        # object instance with configuration                             
        my $d = new PDF::Composite({
                                    
                                    # file output                
                                    'fileOut'      => "pdfs/perl_website_pdf_screens_bulk.pdf",
        
                                    #content Dir
                                    'contentDir'   => "screens/pdf",
                                    
                                    # over lay content
                                    'content'=>[
                                                                    
                                        {
                                            # text color
                                            'color'     => '#121212',
                                            
                                            # font
                                            'font'      => 'Helvetica-bold',
                                            
                                            # text size
                                            'font_size' => 32,  
                                            
                                            # position
                                            'pos'       => {'x' =>20,                                                     
                                                            'y' =>575},                                                                                 
                                            
                                            # text with key for default information
                                            'text'       => {'key'=>'page_no'},
                                        },
                                        
                                        
                                        {
                                            # text color
                                            'color'     => '#454545',
                                            
                                            # font
                                            'font'      => 'Helvetica',
                                            
                                            # text size
                                            'font_size' => 9,  
                                            
                                            # position
                                            'pos'       => {'x' =>20,                                                     
                                                            'y' =>600},                                                                                 
                                            
                                            # text with key for default information
                                            'text'       => 'Perl Sites'
                                        }
                                    ],
                                    
                                    
                                    # page content
                                    'pageContent' => {
                                                        '3_metacpan' => [
                                                                    
                                                                        {
                                                                            'color'     => '#818181',
                                                                            'font'      => 'Helvetica',
                                                                            'font_size' => 16,  
                                                                            
                                                                            'pos'       => {'x' =>490,
                                                                                            'y' =>340},                                                                                 
                                                                            
                                                                            # custom text
                                                                            'text'       =>'Give your search here...',
                                                                        }
                                                                    ]   
                                                    }
                                    
                                });
        
        ###################################################################################################################################
          
        print "Content-type:text/html\n\n";
        
        # file process
        if($d->process()){
            
            print "File Created "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>"   
        
        }else{
            
            print "Error";    
        }
              
