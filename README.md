# PDF_Composite
Create PDF document from bulk of images or PDF documents. 

# Purpose & Usage
The module helps to create PDF documents from multiple images or documents resides in a directory. Very first, it created for creation of software demo documentation. Where we had a manual word based document and finally producing it a PDF. Due to the lengthy manual procedure, we always distanced it from doing it. One fine day, we had a requirement to show a software screen shot document with a minimal time. The existing method need more hands to finish it in time. 

We worked out a small pdf document creations script based on PDF::Reuse. We put the screen shots in a directory with sequential content based naming like ( 1_Login.pdf,2.Project_Desk.pdf). The script concated all the pdfs in the name order and kept the file name as a title of the page. It's worked that day, we will be able to reduce time on every time. It's continiously improved based on supporting images, multiple text content & more. 

We hope it may helpful in smilar needs. The module available with basic usage method & we are improving documentation. 
We are welcoming usage feedbacks & suggestions.


## How to
- Make sure the availability of modules PDF::Reuse & Image::Info
- Check the samples simple_image_bulk.pl & simple_pdf_bulk.pl
- The Object Instance will take inputs from both Bulk AoH input and propoerty level set & get methods


