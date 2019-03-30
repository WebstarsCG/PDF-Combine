# PDF::Composite
Create PDF document from bulk of images or PDF documents. 

## Purpose & Usage
The module helps to create PDF documents from multiple images or documents resides in a directory. Very first, it created for creation of software demo documentation. Where we had a manual word based document and finally producing it a PDF. Due to the lengthy manual procedure, we always distanced it from doing it. One fine day, we had a requirement to show a software screen shot document with a minimal time. The existing method need more hands to finish it in time. 

We worked out a small pdf document creations script based on Perl module PDF::Reuse. We put the screen shots in a directory with sequential content based naming like ( 1_Login.pdf,2.Project_Desk.pdf). The script concated all the pdfs in the name order and kept the file name as a title of the page. It's worked that day, we will be able to reduce time on every time. It's continiously improved based on supporting images, multiple text content & more. 

We hope it may helpful in smilar needs. The module available with basic usage method & we are improving documentation. 
We are welcoming usage feedbacks & suggestions.


## How to
- Make sure the availability of modules PDF::Reuse & Image::Info
- Check the samples simple_image_bulk.pl & simple_pdf_bulk.pl
- The Object Instance will take inputs from both Bulk AoH input and propoerty level set & get methods

## Files
- lib/PDF has the library module
- screens/pdf has sample pdf's for demo
- screens/jpg has sample jpeg images for demo
- screens/frame has sample frame for demo
- pdfs -> area for storing created pdf documents
- simple_pdf_bulk.pl -> create a PDF from multiple one page pdf's
- simple_image_bulk.pl -> create a PDF from multiple jpeg images from given directory
- simple_template.pl -> create a PDF from template and content from AoA
- simple_template_csv.pl -> create a PDF from template and content from CSV file
## To Do
- Elabrative Documentation
- Step by Step Samples
- Packaging for meta::cpan

## Limitations
- Presently it will take only one page from PDF inputs 

## Copyright and license

Copyright: info@webstarscg.com, 2018 and later.

All source files in this package, including the documentation, are open source software under the terms of [Perl's Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).
