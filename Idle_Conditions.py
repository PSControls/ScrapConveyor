from pycomm3 import LogixDriver



def read_p03():
 try:
    with LogixDriver('128.121.13.1') as plc:
        value = plc.read('P03_Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = '{ "P03": "True", '
   

        else:
            json_str = '{ "P03": "False", '
    
 except:return ' {"P03": "True", '
 else: return json_str
 


def read_p04():
 try:
    with LogixDriver('128.121.14.1') as plc:
        value = plc.read('P04_Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P04": "True", '
   

        else:
            json_str = ' "P04": "False", '
    
 except:return ' "P04": "True", '
 else: return json_str
 




def read_p05():
 try:
    with LogixDriver('128.121.15.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P05": "True", '
   

        else:
            json_str = ' "P05": "False", '
    
 except:return ' "P05": "True", '
 else: return json_str
 
def read_p12():
 try:
    with LogixDriver('128.121.22.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P12": "True", '
   

        else:
            json_str = ' "P12": "False", '
    
 except:return ' "P12": "True", '
 else: return json_str
 


def read_p13():
 try:
    with LogixDriver('128.121.23.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P13": "True", '
   

        else:
            json_str = ' "P13": "False", '
    
 except:return ' "P13": "True", '
 else: return json_str
 

def read_p14():
 try:
    with LogixDriver('128.121.24.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P14": "True", '
   

        else:
            json_str = ' "P14": "False", '
    
 except:return ' "P14": "True", '
 else: return json_str
 

def read_p15():
 try:
    with LogixDriver('128.121.25.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P15": "True", '
   

        else:
            json_str = ' "P15": "False", '
    
 except:return ' "P15": "True", '
 else: return json_str
 

def read_p16():
 try:
    with LogixDriver('128.121.26.1') as plc:
        value = plc.read('Continuous_Mode')

        # Ensure value is a string
        value_str = str(value)
        

        if "True" in value_str:
            json_str = ' "P16": "True"} '
   

        else:
            json_str = ' "P16": "False"} '
    
 except:return ' "P16": "True"} '
 else: return json_str

 
 



if __name__ == '__main__':




    output = read_p03() + read_p04() + read_p05() + read_p12()  + read_p13() + read_p14()  + read_p15() + read_p16()
    print(output)