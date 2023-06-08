# WinPlugins Contribution Guidelines

We're delighted that you're considering contributing to the WinPlugins project. Your unique solutions and ideas are eagerly anticipated. To streamline the process and make it smooth for both contributors and project maintainers, we've set the following rules for contribution. Please adhere to these guidelines throughout your involvement in this project.

## 1. Understanding the Project
Before you put forward your contribution, ensure you fully grasp the project's aim. WinPlugins is a platform consolidating various plugins for customizing Windows 11 and later versions. Exploring the existing codebase and plugins will help guarantee that your contribution aligns with the project.

## 2. Issue Creation
Kick off your contribution by **creating an issue in the GitHub repository**. This issue will serve as a platform for discussing your contribution both before and after code submission. It allows maintainers and other contributors to *provide feedback and guidance*.

When creating the issue, please include the following:

- A clear and concise description of the problem and how your contribution solves it.
- Any relevant background information or references.
- A detailed description of the changes you're proposing.

## 3. Tagging
Using appropriate tags for your issue helps maintainers understand the nature of your contribution. It also aids in the organization and tracking of issues.
- `plugin` - tag when you are proposing or adding a new plugin.
- `api` - tag when you want to make enhancements to the API.
- `architecture` - tag when you have suggestions or changes related to the project architecture.
- etc.

## 4. Creating a Fork
Once the issue is created, **fork the repository to your GitHub account**. Implement all changes in this fork. When your contribution is ready, you can create a pull request.

## 5. Commit Messages
Commit messages should be transparent and descriptive. They should summarize the changes made in the commit and, if applicable, include the issue number. This helps maintainers and other contributors understand the purpose of the changes.

## 6. Code Style
In order to maintain readability and maintainability, it is important to adhere to a consistent code style throughout the project. The following guidelines provide a brief overview of the required naming conventions, comment style, and formatting conventions.

### Naming Conventions
- *Classes*: Class names should be written in **UpperCamelCase**. They should be noun phrases that are short and succinct, but explanatory. Example: `EmployeeRecord`.
- *Functions*: Function names should be written in **lowerCamelCase**. They should be verb phrases that clearly describe what the function does. Example: `calculateAverage`.
- *Variables*: Variable names should also be written in **lowerCamelCase**. They should be short yet descriptive. Example: `employeeCount`.

### Comments
All comments should adhere to the ***Javadoc style***. This means that each class and method should have a description in a block comment directly above it. The comment should describe what the class or method does, not how it does it.
- Important information should be highlighted using **!:**. Example: `!: Attention: This method will remove all records from the database`.
- If there are any questions or points for discussion, they should be flagged with **?:**. Example: `?: Consider refactoring this method to make it more efficient`.
- Any tasks that need to be completed should be flagged with **TODO:**. Example: `TODO: Implement error handling`.

### Formatting
This project uses clang-format, which should be used to format all C++ files in the project. The current .clang-format file can be found in the root of the project directory. Ensuring consistency in code formatting improves readability and maintainability of the project.
- The indent is created with Tab.
- Each statement should be on its own line.
- There should be spaces around operators. Example: `x = y + z`;
- There should be spaces after commas. Example: `calculateAverage(x, y, z)`;
- etc.
<details><summary>Here is a simple example:</summary>

```cpp
/**
 * EmployeeRecord represents a single employee's record.
 * 
 * !: EmployeeRecords are immutable once created.
 */
class EmployeeRecord {

private:
    std::string employeeId;
    std::string name;

public:
    /**
     * Constructs a new EmployeeRecord.
     *
     * @param employeeId the ID of the employee
     * @param name the name of the employee
     */
    EmployeeRecord(std::string employeeId, std::string name) 
    : employeeId(employeeId), name(name) {}

    /**
     * Gets the employee's ID.
     *
     * @return the employee's ID
     */
    std::string getEmployeeId() {
        return employeeId;
    }

    /**
     * Gets the employee's name.
     *
     * @return the employee's name
     */
    std::string getName() {
        return name;
    }

    // TODO: Implement the equality operator.
};
```

</details>

## 7. Testing
Before submitting your contribution, thoroughly **test your changes**. Ensure they function as expected and do not disrupt existing functionality. If the project has a test suite, your changes should pass all tests.

## 8. Documentation
Appropriate documentation should accompany all contributions. This includes comments in the code and updates to README or other external documentation where necessary.

## 9. Pull Request
Once you've tested your changes and are ready to contribute them back to the project, create a pull request from your fork to the main repository. The pull request should **detail your changes, reference the issue number, and include any other relevant information**.

## 10. Review Process
After submitting a pull request, your changes will undergo a review process. This may include feedback or requests for changes. Please be patient during this process and be prepared to revise your contribution based on feedback.

By adhering to these contribution guidelines, you contribute to keeping the WinPlugins project of high quality and easy to maintain. We're excited to see your innovative plugins and enhancements to the API. Happy coding!