# Take-Home-Coding
Take Home coding is a project that takes information from Microsoft and populates the date into a DW

There is a small diagram that shows how the DW was created to show how the tables are built

![image](https://user-images.githubusercontent.com/25781936/231888795-2e81370d-fbc2-4555-b92f-c877bd22c26c.png)

### To start with the exercise you need to follow the next steps:

Before, you continue we assume that you have installed Jupyter notebook, SQL Server and python in your machine

### To Connect python with SQL Server we could use pyodbc package, To install the pyodbc module, you can use the following steps :

   1. Open a command prompt or terminal window on your computer.
   2. Make sure you have Python installed on your computer. You can check this by running the command python --version in your command prompt or terminal window. If you don't have Python installed, you can download it from the official website: https://www.python.org/downloads/.
   3. Run the following command to install pyodbc using pip, which is a package manager for Python:
     
      **pip install pyodbc**
      
   4. To make sure is ready and well installed run the following command on the terminal window on your computer.
      
      **import pyodbc**
      **print(pyodbc.version)**
 
### Python Code & Jupyter Notebook

Later go to jupyter notebook and instance a new notebook run following command:

     **jupyter notebook**

This code will upload the data into SQL Server Database in a stage table called [ST_MultiDays]

This image


![image](https://user-images.githubusercontent.com/25781936/231886473-839ca006-03ec-42e2-969d-c0035688f83a.png)

this code will divide the information provide from the datasource into a dimension into SQL Server Database.

the example below shows how to do it with DimAccount and DimCampaign

![image](https://user-images.githubusercontent.com/25781936/231887538-daed6fd9-ff40-431e-a269-57a3f6de84ba.png)

and

![image](https://user-images.githubusercontent.com/25781936/231887658-4460a3fe-7af3-4761-948e-96fbd4534acd.png)

### SQL Server 

You need to create a database called Test in SQL Server : CREATE DATABASE Test

Then go to script and run all the objects, Follow the instructions in Test.sql script please.

***The logic will continue in the same way, there few gaps identified in the current model. Those are not well identified due to a lack of definition***

Steps :

   1. Upload the information into the Fact Table called [dbo].[FactTracking].
   2. Validate information is distributed in the correct way and start with possible queries to get specific date.
   3. We can create views to show specific information.
   4. Connect a BI tool to show information.

