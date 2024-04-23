import sys
import os


def createModuleFile(file_name: str, module_name):
    template_file_path = os.path.join("templates", file_name)
    new_file_path = os.path.join(module_name, module_name+file_name)
    with open(template_file_path, 'r') as inFile:
        template_content = inFile.read()
        new_file_content = template_content.replace("{MODULE_NAME}", module_name)

        with open(new_file_path, 'w') as outFile:
            outFile.write(new_file_content)


if __name__ == '__main__':
    moduleName = sys.argv[1]
    if not os.path.exists(moduleName):
        os.mkdir(moduleName)
    for file in ['Interactor.swift', 'Presenter.swift', 'Protocols.swift', 'Router.swift', 'Wireframe.swift']:
        createModuleFile(file, moduleName)



