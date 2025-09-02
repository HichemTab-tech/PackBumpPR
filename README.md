# PackBumpPR: Effortless Package Version Updates 🚀

PackBumpPR is a reusable GitHub Action that simplifies package version updates and automates pull request creation. With this action, you can bump your package version directly from GitHub—no IDE required! Perfect for quick updates, even when you're on the go 🌍.

## Features ✨

- **Manual Trigger**: Use GitHub's workflow dispatch to trigger updates anytime.
- **Version Automation**: Increment versions in `package.json` and `package-lock.json` automatically.
- Supports `patch`, `minor`, `major`, or custom version increments.
- Pushes updates to a new branch and opens a pull request for review.
- Fully reusable for your workflows.

## How to Use 💻

### Include PackBumpPR in Your Workflow

Add the following snippet to your workflow file (e.g., `.github/workflows/version_bump.yml`):

```yaml
name: Dispatchable Version Bump

on:
  workflow_dispatch:
    inputs:
      version_increment:
        description: "Version increment type (patch, minor, major, or custom)"
        required: true
        default: "patch"
      custom_version:
        description: "Custom version (only if version_increment is custom)"
        required: false

jobs:
  bump-version:
    runs-on: ubuntu-latest

    steps:
      - name: Use PackBumpPR
        uses: HichemTab-tech/PackBumpPR@v2
        with:
          version_increment: ${{ github.event.inputs.version_increment }}
          custom_version: ${{ github.event.inputs.custom_version }}
          github_token: ${{ secrets.GITHUB_TOKEN }}
          main_branche: "main" # or "master"
```

### Inputs 🛠️

- **`version_increment`**: The type of version bump (`patch`, `minor`, `major`, or `custom`).
- **`custom_version`**: Specify the custom version (only needed if `version_increment` is `custom`).
- **`github_token`**: The GitHub token for authentication. This is required for pushing changes and creating pull requests.
- **`main_branche`**: The name of your main branch (e.g., `main` or `master`). This is required to correctly target the base branch for the pull request.


### Outputs 📤

- **Pull Request URL**: The URL of the created pull request is available in the action output.

## Requirements ✅

To ensure the action works as expected:

1. **Allow GitHub Actions to create pull requests:**
   - Go to **Settings > Actions > General > Workflow permissions**.
   - Select **Read and write permissions**.
   - Enable **Allow GitHub Actions to create and approve pull requests**.

2. **Dependencies:**
   - Your repository should have `jq` and `npx semver` installed for JSON manipulation and version incrementing.

## Example Scenarios 🌟

### Increment a Patch Version

Trigger the workflow with:
- `version_increment`: `patch`

The action will:
1. Read the current version (e.g., `1.0.0`).
2. Increment it to `1.0.1`.
3. Commit and push the changes to `version-bump-1.0.1`.
4. Create a pull request to merge into `master`.

### Use a Custom Version

Trigger the workflow with:
- `version_increment`: `custom`
- `custom_version`: `2.0.0`

The action will:
1. Set the version to `2.0.0`.
2. Commit and push the changes to `version-bump-2.0.0`.
3. Create a pull request to merge into `master`.

### Collaborate with Dependabot 🤝

This action pairs perfectly with Dependabot! For example, if Dependabot creates a pull request to update dependencies, you can merge it and then use **PackBumpPR** to increment your package version for the new changes. This allows you to:
- Keep your packages up-to-date without opening an IDE.
- Handle everything directly from GitHub—even on your phone while outside! 📱

## Why PackBumpPR? 🤔

- **Streamline Updates**: No need to open your IDE for small version bumps.
- **Save Time**: Automates the mundane tasks of version updates and PR creation.
- **Portable**: Use it anywhere, anytime, as long as you have access to GitHub.

## License 📜

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

PackBumpPR: Simplify, automate, and keep your workflow smooth! 🎉

