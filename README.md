<h1 align="center">
    </br>
    <img src="https://raw.githubusercontent.com/1N0Name/WinPlugins/master/assets/WinPlugins.ico" alt="WinPlugins">
    </br>
    WinPlugins
    </br>
</h1>


<p align="center">
    <a href="https://github.com/1N0Name/WinPlugins/releases/latest">
        <img src="https://img.shields.io/github/v/release/1N0Name/WinPlugins?label=version&color=blue" alt="Version"></a>
    &nbsp    
    <a href="https://github.com/1N0Name/WinPlugins/issues">
        <img src="https://img.shields.io/github/issues/1N0Name/WinPlugins.svg?style=flat&logo=github&logoColor=white&color=yellow" alt ="GitHub Issues"></a>
    &nbsp
    <a href="https://github.com/1N0Name/WinPlugins/pulls">
        <img src="https://img.shields.io/github/issues-pr/1N0Name/ReFolder.svg?style=flat&logo=github&logoColor=white&color=red" alt="GitHub Pull Request"></a>
    &nbsp    
    <a href="https://github.com/1N0Name/WinPlugins/releases">
        <img src="https://img.shields.io/badge/downloads-34-brightgreen" alt="Downloads"></a>
</p>

WinPlugins is an open-source project, maintained by a group of enthusiastic students, that aims to provide a robust platform to concentrate diverse plugins for customizing Windows 11 and above. We provide a wide range of solutions to customize your Windows experience, bringing various functionalities under one roof. If you are passionate about enhancing user experiences and have a knack for creativity, we welcome you to contribute to our project. We are also open to suggestions and advice on improving the product or adjusting the architecture for the better.

## Contributing

Refer to the [Contribution Guidelines](https://github.com/1N0Name/WinPlugins/master/CONTRIBUTING.md) section for detailed instructions on how to contribute to this project.

## Development

The project is built under `CMake` and `Qt 6.5.0`. We highly recommend using **MSVC 2019** as the compiler. If you're planning to add a new plugin, you should follow this algorithm:

1. **Create a new folder** in the Plugins directory, like `Plugins\IconChanger`.
2. **Add a CMakeLists.txt** in the created directory.
<details><summary>Here's a sample:</summary>

```cmake
# This is a sample CMakeLists.txt for the IconChanger plugin.
# Start by defining the static library
qt_add_library(IconChangerLib STATIC)

# Enable AUTOMOC and link the necessary Qt modules
set_target_properties(IconChangerLib PROPERTIES AUTOMOC ON)
target_link_libraries(IconChangerLib PRIVATE Qt6::Gui PRIVATE Qt6::Quick)

# Add your QML, Header (HPP) and Source (CPP) files here
list(APPEND MODULE_QML_FILES IconChanger.qml)
list(APPEND HPP_SOURCES iconmodel.h)
list(APPEND CPP_SOURCES iconmodel.cpp)

# Add your resource files here
list(APPEND ICON_RESOURCES assets/iconChangerLogo.png assets/folder.svg assets/delete.svg
    assets/icon.svg IconRepository/API.ico IconRepository/billy-herrington.ico
    IconRepository/docs.ico IconRepository/music.ico)

# Configure the QML module
qt_add_qml_module(IconChangerLib
    URI IconChanger
    VERSION 0.1
    RESOURCE_PREFIX /
    QML_FILES ${MODULE_QML_FILES}
    RESOURCES ${ICON_RESOURCES}
    SOURCES iconmodel.h iconmodel.cpp
)
```
</details>
<br>

3. **Write a `.plg` file** in JSON format (it is used to load plugin into collection):
```json
{
    "plugin": {
        "name": "IconChanger", // The file name of the plugin
        "description": "Easily change icons of your folders", // A detailed description of the plugin
        "version": "1.0", // The current version of the plugin
        "imgPath": "qrc://Plugins/IconChanger/assets/iconChangerLogo.png", // Path to the plugin's preview picture
        "storePath": "tempstr", // The path to the QML page which will be displayed in the plugin list before loading it when viewing the details
        "price": 0, // The price of the plugin (currently inactive)
        "category": "icons" // Category of the plugin. Standardized categories will be introduced later
    }
}
```
4. **Link your plugin** to the main application in the primary `CMakeLists.txt` file.
## To-Do
The smallest current tasks are accounted for by Kanban board, but among the larger and higher priority tasks are the following:
- [ ] Implement the user's personal account
- [ ] Create a way to modularly load only necessary plugins from the server and remove unnecessary plugins when they are no longer needed
- [ ] Figure out how to make an MSIX package to inherit from the Windows interfaces and interact with and modify system components, such as the context menu.

## License
This project is licensed under the terms of the [Apache License 2.0](https://github.com/1N0Name/WinPlugins/master/LICENSE).