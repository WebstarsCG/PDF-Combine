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
                                            'color'     => '0',
                                            'font'      => 'Helvetica',
                                            'font_size' => 16,  
                                            
                                            'pos' => {'x' =>27,
                                                      'y' =>652},                                                                                 
                                            
                                            'text'       => {'key'=>'title'},
                                        }
                                    ],
                                    
                                });
        
        ###################################################################################################################################
          
        print "Content-type:text/html\n\n";
        
        # file process
        if($d->process()){
            
            print "File Created "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>"   
        
        }else{
            
            print "Error";    
        }
              