# Take-Home-Coding
Take Home coding is a project that takes information from Microsoft and populates the date into a DW

Before, you continue we assume that you have installed Jupyter notebook and python in your machine

To Connect python with SQL Server we could use pyodbc package, To install the pyodbc module, you can use the following steps :

   1. Open a command prompt or terminal window on your computer.
   2. Make sure you have Python installed on your computer. You can check this by running the command python --version in your command prompt or terminal window. If you   
      don't have Python installed, you can download it from the official website: https://www.python.org/downloads/.
   3. Run the following command to install pyodbc using pip, which is a package manager for Python:
     
      pip install pyodbc
      
   4. To make sure is ready and well installed run the following command on the terminal window on your computer.
      
      import pyodbc
      print(pyodbc.version)



Python Code 

this code will upload the datasource into SQL Server Database in a table called [ST_MultiDays]

There is a small diagram that shows how the DW was created

![image](https://user-images.githubusercontent.com/25781936/231888795-2e81370d-fbc2-4555-b92f-c877bd22c26c.png)


This image

![image](https://user-images.githubusercontent.com/25781936/231886473-839ca006-03ec-42e2-969d-c0035688f83a.png)


this code will divide the information provide from the datasource into a dimension into SQL Server Database.

the example below shows how to do it with DimAccount and DimCampaign

![image](https://user-images.githubusercontent.com/25781936/231887538-daed6fd9-ff40-431e-a269-57a3f6de84ba.png)

and

![image](https://user-images.githubusercontent.com/25781936/231887658-4460a3fe-7af3-4761-948e-96fbd4534acd.png)





