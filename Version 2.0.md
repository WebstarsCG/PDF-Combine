# Version 2.0
We updated a Version 2.0 with some key improvements in feature & communination

## 2.0 Improvements
#### Text Position Update
PDF::Reuse module by default handled _y position_ relative to bottom. It has no issues with same size screens. In varied screen size usages, it will be difficult to handle. **V2.0** updated with y position realtive to generic method of relative to top.
#### Text colors in Hexadecimal
As like y position, PDF::Reuse follwed a text specification like _'0 0 0' to '1 1 1' for RGB color specificaion_. **V2.0** now updated with color representation in Hexadecimal.
#### Image Area Padding
Padding can be set now in PDF creation with images case.
```perl
# set padding to image area
$d->setImagePadding({
                   'left'   => 40,
                   'top'    => 100,
                   'right'  => 20,
                   'bottom' => 20,
                   });
```
#### Default Background Frame
Exporting screens with default header & footer designs worked fine. When there is a minor change in style format, presently we have to recreate all screen images. It's a time killer if we have more screens. **V2.0** updated with a document frame option, where the images added top of that. Combining with image padding we can quickly create documents with different header & footer styles.
```perl
# set frame        
$d->setFrame("screens/jpg/frame.pdf");
```
#### Custom Page Content
In some use cases, we come across specific screen based additional content requirements addon to all page general content. **V2.0** updated with set page level contents in a bulk HoA way.

```perl
# custom page content
$d->setPageContent({
                        # file name of the screen without extension as a key
                        '3_metacpan' => [                                                                           
                                            {
                                                'color'     => '#818181',
                                                'font'      => 'Helvetica',
                                                'font_size' => 16,                                                          
                                                'pos'       => {'x' =>520,'y' =>415},                                                                                                                                         
                                                # custom text
                                                'text'       =>'Give your search here...',
                                            }
                                        ]   
                  });                  
```
