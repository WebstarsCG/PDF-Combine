#!/usr/bin/perl -w 
        
        # set local lib path where PDF combine resides          
        BEGIN{ use lib 'lib/'; }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Combine;
        
        print "Content-type:text/html\n\n";
        
        # PDF::combine object instance                            
        my $d = new PDF::Combine({'fileNameFormat' =>'IN'});
        
        # set content dir
        $d->setContentDir("content/jpg/web_ordered");
        
        # set frame        
        $d->setFrame("./content/frame/frame_1399w_746h.pdf");
        
        # set global padding to the image
        $d->setImagePadding({'top'    => 100
                           });
        
        # set output file
        $d->setFileOut("pdf_out/combine_img_frame_addon_text.pdf");          
        
        # add global content to show page title from the file name
        $d->addContent({'color'     => '#121212',         # text color  
                        'font'      => 'Arial-bold',      # font
                        'font_size' => 14,                # text size       
                        'text'      => {'key'=>'title'},  # default key for get page name information 
                        'x'         => 35,
						'y'         => 55});                    
                              
        # content to show current page no
        $d->addContent({'color'     => '#454545',
                        'font_size' => 11,                                               
                        'text'      => {'key'=>'page_no'},
                        'x'         => 1150,
                        'y'         => 55});
                         
                        
        # custom text
        $d->addContent({
                        'color'     => '#454545',
                        'font_size' => 11,                        
                        'font'      =>'Helvetica-bold',  
                        'text'      => ' | PDF::Composite',
                        'x'         => 1160,
                        'y'         => 55});
                
        
        # custom page content, special content for specific pages.
        # set by page name
        $d->setPageContent({
                               '3_metacpan' => [                                                 
                                                  { 'color'     => '#818181',
                                                    'font'      => 'Helvetica',
                                                    'font_size' => 12,  
                                                    'text'      => 'Give your search here... Custom Text',
                                                    'x'         => 500,
                                                    'y'         => 415}
												]   
                        });
             

        # do the combine process
        print (($d->process())?"File created with combining of images in a pdf frame with page title &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              