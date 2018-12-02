#!/usr/bin/perl -w

        # Package for Getting masters list

        package PDF::Composite;
       
                
        use Data::Dumper;
        
        use PDF::Reuse;

        use Image::Info qw(image_info dim);
        
        use PDF::Color::Rgb;
       
        #use Image::Info qw(image_info dim);
                           
        # package
        
        sub new(){
            
            my $self    =   $_[0];
            
            my $objref={
                
            
            'content_dir'       => $_[1]->{'contentDir'}    || '',
            'content'           => $_[1]->{'content'}       || '',
            'file_out'          => $_[1]->{'fileOut'}       || '',
            'frame'             => $_[1]->{'frame'}         || '',
            'image_extra'       => $_[1]->{'imageExtra'}    || '',
            'image_padding'     => $_[1]->{'imagePadding'}  || {'left'=>0,'top'=>0,'right'=>0,'bottom'=>0},
            'page_content'      => $_[1]->{'pageContent'}   || '',
            
            
            'file_name_format'  => $_[1]->{'fileNameFormat'} || 'IN'  , # index and name
            
            'data_keys'         => {'title'=>'','page_no'=>''},
            
            '_options'          => {'hide_tool_bar'     => 0,
                                    'hide_menu_bar'     => 0,
                                    'hide_window_ui'    => 0,
                                    'fit_window'        => 0,
                                    'center_window'     => 0                                    
                                    },
            
            '_default'           => {
                                     'font'             => 'Helvetica',
                                     'font_size'        => '16',
                                     'color'            => 0,
                                     'file_name_format' => 'IN'
                                    },
            
             'clr'               => new Color::Rgb()
            
            };
            
            bless $objref,$self;                  
            
            return $objref;
            
        } # end


        sub process(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $lv;
            $lv->{'page_no'} = 0;
                        
            # remove earlier file
            
            unlink($self->{'file_out'}) if(-e $self->{'file_out'});
                    
            # open
            
            prFile({'Name'=>$self->{'file_out'},
                    HideToolbar  => $self->{'_options'}->{'hide_tool_bar'}  || 0, # 1 or 0
                    HideMenubar  => $self->{'_options'}->{'hide_menu_bar'}  || 0,                                           # 1 or 0
                    HideWindowUI => $self->{'_options'}->{'hide_window_ui'} || 0,                                           # 1 or 0
                    FitWindow    => $self->{'_options'}->{'fit_window'}     || 0,                                           # 1 or 0
                    CenterWindow => $self->{'_options'}->{'center_window'}  || 0
                });
            
                                         
            # dir            
            opendir(my $dh,$self->{'content_dir'}) || die "Can't opendir : $!";            
            my @pages = readdir($dh);            
            closedir $dh;
            
            # remove top 2
            shift @pages;
            shift @pages;
            
            # Capture Pattern (Integer & Name), Pattern based index capturing            
            $lv->{'file_capture'}->{'IN'} = { 'pattern'         => qr/(\d+\.*\d*)(\_?)(.*?)(\.(pdf|jpg))/is,
                                              'file_num_idx'    => 0,
                                              'file_spliter_idx'=> 1,
                                              'file_name_idx'   => 2,
                                              'file_format_idx' => 3,
                                            };
            
            $lv->{file_capture_info}      = $lv->{'file_capture'}->{$self->{'file_name_format'}}; 
            
            # file name            
            my $pattern          = $lv->{file_capture_info}->{'pattern'};
            my $file_num_idx     = $lv->{file_capture_info}->{'file_num_idx'};
            my $file_name_idx    = $lv->{file_capture_info}->{'file_name_idx'};
            my $file_format_idx  = $lv->{file_capture_info}->{'file_format_idx'};
            my $file_spliter_idx = $lv->{file_capture_info}->{'file_spliter_idx'};
            
            my $file_in;
            
            # page contet
            $lv->{'page_content'} = $self->{'page_content'};
            
            # each screen            
            for my $page ( sort{ $a <=> $b} @pages){
                
                my @file_info = $page =~m/$pattern/ig;
                
                $file_in->{'name'}    = $file_info[$file_name_idx];
                $file_in->{'format'}  = $file_info[$file_format_idx];
                $file_in->{'idx'}     = $file_info[$file_num_idx];
                $file_in->{'spliter'} = $file_info[$file_spliter_idx];
                $file_in->{'token'}   = lc($file_in->{'idx'}.$file_in->{'spliter'}.$file_in->{'name'});
                
                
                if ($file_in->{'format'}=~m/(pdf|jpg)/){                    
                
                    # page counter
                    $lv->{'page_no'}++;
                
                    if($file_in->{'idx'} || $file_in->{'name'}){
                    
                        $lv->{'title'} = $file_in->{'name'};
                        $lv->{'title'}=~s/\_/ /g;                                
                        $lv->{'title'}=~s/\b([a-z])/uc($1)/ieg;
                        $self->{'data_keys'}->{'title'} = $lv->{'title'};
                        
                    } # end
                                                            
                    # each page additon                    
                    if($file_in->{'format'}=~m/pdf/){
                                               
                        
                        my @vec =  prForm($self->{'content_dir'}."/$page");
                        
                        my ($from, $pos) = prText(0,0,'');
                        
                        $lv->{'img_mbox_height'}=$vec[4];
                                                
                        # add global contents
                        for my $line (@{$self->{'content'}}){
                                                        
                            addTextLayer($self,$line,$lv) || die "error";                            
                        
                        } # end of global conents
                        
                        # page specific content                        
                        if($lv->{'page_content'}->{$file_in->{'token'}}){
                                                        
                            for my $line (@{$lv->{'page_content'}->{$file_in->{'token'}}}){
                                
                                addTextLayer($self,$line,$lv) || die "error";                            
                            } 
                            
                        } # end of check page specific content
                        
            
                        prDoc( { file  => $self->{'content_dir'}."/$page",
                                 first => 1,
                                 last  => 1 });
                    
                    } #
                    
                    if($file_in->{'format'}=~m/jpg/){
                        
                            
                            # frame                        
                            if ($self->{'frame'}) {
                                prForm($self->{'frame'}); 
                            }
                        
                            # get image
                            $lv->{'src_image'} = image_info($self->{'content_dir'}."/$page");
                            
                            ($lv->{'img_width'},$lv->{'img_height'})  = dim($lv->{'src_image'});
                            
                            $lv->{'img_extra'}  = $self->{'image_extra'};
                       
                            $lv->{'img_mbox_width'}  = ($lv->{'img_width'}+$self->{'image_padding'}->{'left'}+$self->{'image_padding'}->{'right'});
                            $lv->{'img_mbox_height'} = ($lv->{'img_height'}+$self->{'image_padding'}->{'top'}+$self->{'image_padding'}->{'bottom'});
                        
                            # page box
                            prMbox (0,0,$lv->{'img_mbox_width'},$lv->{'img_mbox_height'});
                           
                            $lv->{'image_content'}  = prJpeg($self->{'content_dir'}."/$page",$lv->{'img_width'},$lv->{'img_height'});
                           
                            $lv->{'img_str'} = "q\n";
                            
                            # the two parameters after width represents for skew
                            # the two parameters after height left & bottom spaces
                            
                            #$lv->{'img_str'}.= "$lv->{img_width} <skew right> <perspective left> $lv->{img_height} <padding_left> <padding_bottom> cm\n";
                            
                            $lv->{'img_str'}.= "$lv->{img_width} 0 0 $lv->{img_height} $self->{'image_padding'}->{'left'} $self->{'image_padding'}->{'bottom'}  cm\n";
                            $lv->{'img_str'}.= "/$lv->{'image_content'} Do\n";
                            $lv->{'img_str'}.= "Q\n";
                            prAdd($lv->{'img_str'});
                           
                            # each line
                            for my $line (@{$self->{'content'}}){                                            
                            
                                addTextLayer($self,$line,$lv) || die "error";
                            
                            } # end
                             
                            prPage();
                    }
                                        
                } # if
                
            } # end
            
            # close
            
            prEnd() || return 0;
            
            return 1;
            
        } # end
        
        
        # file out
        sub getFileOut(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'file_out'} || 0;            
        
        }
        
        sub setFileOut(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            $self->{'file_out'} = $param;
            
            return 1;        
        }
        
        # get frame
        sub getFrame(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'frame'};
        
        }
        
        # set frame
        sub setFrame(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            $self->{'frame'} = $param;
            
            return 1;        
        }
        
        
        # content dir
        sub getContentDir(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'content_dir'} || 0;            
        
        }
        
        sub setContentDir(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            $self->{'content_dir'} = $param;
            
            return 1;        
        }
        
        # set Default
        sub setDefault(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $current = $self->{'_default'};
            
            # each var
            for my $param_key (keys(%{$param})){                
                $current->{$param_key}=$param->{$param_key} if( (exists $param->{$param_key}) && (exists $current->{$param_key}) );                
            }             
            
            return 1;
        }
        
        
        sub getDefault(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $current = $self->{'_default'};
            
            return $current;
        }
        
        #set options
        
        # set Default
        sub setOptions(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $current = $self->{'_options'};
            
            # each var
            for my $param_key (keys(%{$param})){                
                $current->{$param_key}=$param->{$param_key} if( (exists $param->{$param_key}) && (exists $current->{$param_key}) );                
            }             
            
            return 1;
        }
        
        
        sub getOptions(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $current = $self->{'_options'};
            
            return $current;
        }
        
        # set image extra
        sub setImageExtra(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            $self->{'image_padding'} = $param;             
            
            return 1;
        }
        
        # get content
        sub getImageExtra(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'image_extra'};
        }
        
        
        # set image extra
        sub setImagePadding(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            for my $area(qw/left top right bottom/){
            
                $self->{'image_padding'}->{$area} = $param->{$area}   if($param->{$area})             
            
            }
            
            return 1;
        }
        
        # get content
        sub getImagePadding(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'image_padding'};
        }
        
        # set Content
        sub setContent(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            my $current = $self->{'content'};            
            $self->{'content'} = $param;             
            
            return 1;
        }
        
        # get content
        sub getContent(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            return $self->{'content'};
        }
        
        # add content
        sub addContent(){
            
            my $self    = shift @_;            
            my $param   = shift @_;
            
            push(@{$self->{'content'}},$param);            
            
            return 1;
        }
        
        # text layer
        sub addTextLayer(){
            
            my $self  = shift @_;
            my $line  = shift @_;
            
            my $lv = shift @_;
           
            prAdd($self->hex2pdfrgb($line->{'color'})." rg\n");
           
            prFont($line->{font} || $self->{'_default'}->{'font'});
           
            prFontSize($line->{'font_size'} || $self->{'_default'}->{'font_size'});
                      
            $line->{'pos'}->{'yi'} = ($lv->{'img_mbox_height'}-$line->{'pos'}->{'y'});
           
            prText($line->{'pos'}->{'x'},
                   $line->{'pos'}->{'yi'},
                  (($line->{'text'}->{'key'})?$lv->{$line->{'text'}->{'key'}}:$line->{'text'})
            );
            
            return 1;
                          
        }
        
        
        # hex to rgb 
        sub hex2pdfrgb(){
            
            my $self  = shift @_;
            my $param = shift @_;
            
            my $lv;
            
            $lv->{'default_clr'}= '1 1 1';
            
            
            if($param=~m/(\#*)([0-9a-fA-F]){3,6}/){
                           
               
                
                @{$lv->{'rgb'}}      = $self->{'clr'}->hex2rgb($param);
                
                @{$lv->{'pdf_rgb'}}  = map{ sprintf("%.3f",($_/255)) } @{$lv->{'rgb'}};
                
                $lv->{'pdf_rgb_clr'} = join(' ',@{$lv->{'pdf_rgb'}});
                
                return $lv->{'pdf_rgb_clr'};
            
            }else{
                
                return $lv->{'default_clr'};    
            }

        }
        
    1;

