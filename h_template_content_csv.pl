#!/usr/bin/perl -w 
        
        # set local lib path where PDF combine resides           
        BEGIN{ use lib 'lib/'; }
        
        use CGI::Carp qw/fatalsToBrowser/;          
        use Data::Dumper;
        
        # include lib
        use PDF::Combine;      
        
        # PDF::combine object instance                              
        my $d = new PDF::Combine();
               
        # set template    
        $d->setTemplate("content/template/certificate.pdf");
        
        # set content from csv         
        $d->setTemplateContentFromCSV("content/csv/student.csv");
        
        # set template style
        # 1 st col
        $d->addTemplateStyle({  'color'     => '#242424',                        
                                'font'      => 'Arial-bold',
                                'font_size' => 32,
                                'x'         => 180,
                                'y'         => 450});
        
        #2nd col
        $d->addTemplateStyle({  'is_img'        => 1,
                                'default'       => 'content/template/sign.jpg',
                                'x'             => 200,
                                'y'             => 690,
                                'scale'         => 75});                            
                     
        # set output file name
        $d->setFileOut("pdf_out/template_csv.pdf");          
        
        print "Content-type:text/html\n\n";
                
        # file process
        print (($d->process())?"File created with base pdf template & content from csv file &raquo; "."<a href=".$d->getFileOut()." target='_blank'>Open File</a><br>":"Error");
              