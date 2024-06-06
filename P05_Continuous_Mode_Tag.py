from pycomm3 import LogixDriver

"""
def read_p03():

	with LogixDriver('128.121.13.1') as plc:
		print(plc.read('P03_Continuous_Mode'))
		
def read_p03():

	with LogixDriver('128.121.13.1') as plc:
		print(plc.read('P03_Continuous_Mode'))
"""	
def read_p05():
    with LogixDriver('128.121.15.1') as plc:
        value = plc.read('Continuous_Mode')
     

        # Ensure value is a string
        value_str = str(value)
        

        if "False" in value_str:
            json_str = '{ "P05": "True"}'
            print(json_str)
        else:
            print("Test")

if __name__ == '__main__':
    read_p05()
