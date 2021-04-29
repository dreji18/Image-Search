# Setting working directory
setwd("C:/Users/rejid4996/Desktop/My Projects/Project Theia/Theia Images")  

img_train<-list.files()

list_data<-list()

library(magick)

for(i in 1:length(img_train)){
  input <- image_read(img_train[i])
  input <- image_scale(input, "800")
  input <- image_enhance(input)
  text <- input %>%
    image_resize("3000x") %>%
    image_convert(type = 'Grayscale') %>%
    image_trim(fuzz = 30) %>%
    image_write(format = 'png', density = '300x300') %>%
    tesseract::ocr() 
  
  text_01 <- strsplit(text, "\n")
  
  list_data[i]<-c(text_01)
}
 
# The Extracted text is saved as Text file (optional)
setwd("C:/Users/rejid4996/Desktop/My Projects/Project Theia/Theia Output")  
capture.output(print(list_data), file = "Extracted Text File.txt")
  

  