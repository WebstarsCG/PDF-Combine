#!/usr/bin/perl -w 
        
        # set local lib path where PDF combine resides           
        BEGIN{ use lib 'lib/'; }
        
        use CGI::Carp qw/fatalsToBrowser/;
        
        # include lib
        use PDF::Combine;        
        
        # PDF::combine object instance                               
        my $d = new PDF::Combine();
               
        # set page template        
        $d->setTemplate("content/template/certificate.pdf");
                 
        # set template content in AoA
        $d->setTemplateContent([['Person A','content/template/sign.jpg'],
                                ['Person B','content/template/sign.jpg'],
                                ['Person C',''] # if it same to previous, it can be left empty
                            ]);
        
        # set template style to match the content        
        # style for 1st colum content
        $d->addTemplateStyle({  'color'     => '#242424',                        
                                'font'      => 'Arial-bold',
                                'font_size' => 72,
                                'x'         => 170,
                                'y'         => 465});
                    
         
        # style for 2nd column content
        $d->addTemplateStyle({ 'is_img'    => 1,                      
                                'x'         => 200,
                                'y'         => 690,
                                'scale'     => 75});
         
        # set output file name
        $d->setFileOut("pdf_out/template_content.pdf");          
        
        print "Content-type:text/html\n\n";
        
        # file process
        print (($d->process())?"File created with base pdf template & content input as AoA &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              