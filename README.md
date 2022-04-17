

<p align="left">
  <img 
    src="https://i.postimg.cc/x8N4vFL3/Component-21-1.png"
  >
</p>



# Pocket Calculator - Assembly x86 and Delphi

A desktop application of a decimal computer that allows the user to perform arithmetical 
operations like addition, subtraction, multiplication and division.

<!-- <p align="center">
  <img 
    src="https://i.postimg.cc/SNctvm48/Component-14-1.jpg"
  >
</p> -->


## Installation

- Go to https://github.com/mariusstoica21/calculator_asmx86.
- Click the green **'Code'** button.
- Click **'Download ZIP'**.
- Run the app by double-clicking **'calculator.exe'** in the 'calculator_asmx86_master' 
folder.

## Summary
✅ G.U.I. 

✅ Ease of installation

❌ Additional hardware needed

✅ Video available

❌ Documentation

## Project description

### Folder structure

📁 Delphi_files : contains the Delphi project (it can be imported).

- 📄 [UPrincP.pas](https://github.com/mariusstoica21/calculator_asmx86/blob/master/Delphi_files/UPrincP.pas): main form of the app.

📁 Others : contains files requied for the application flow.
    
📄 [calculator.asm](https://github.com/mariusstoica21/calculator_asmx86/blob/master/calculator.asm)
: assembly_x86 file.

▶️ Calculator.exe : application executable.

### Technologies


| 🔨 Tools/Frameworks |     📘 Language     |              📃 Usage               |     📚 Files     |                                ℹ Details                               |
|:----------------:|:----------------:|:---------------------------------:|:--------------:|:--------------------------------------------------------------------:|
|      Delphi      | Objective Pascal |         Desktop app & GUI         |   UPrincP.pas  |UPrincP.pas is the main form of the desktop application. The user presses the buttons in order to insert the operation. After clicking the '=' button, the operation is saved in Others/filename.txt and Others/calculator.exe is run|
|  Notepad++ MASM  |   Assembly x86   | Read input and perform operations | calculator.asm |Others/calculator.exe is the executable file of calculator.asm. The assembly app reads the string operation from Others/filename.txt, parses it and executes the arithmetical operations. The result is stored in result.txt, and read into the dektop app. |



## Tutorial


<p align="center">
  <img 
    src="https://i.postimg.cc/Mp1XP6zh/Component-25-1.png"
  >
</p>


## Authors

- [@mariusstoica21](https://github.com/mariusstoica21)

