# Versioning and Release Process

## Version Management

This project uses semantic versioning (MAJOR.MINOR.PATCH) defined in `CMakeLists.txt`:

```cmake
SET( ${PROJECT_NAME}_MAJOR_VERSION 1 )
SET( ${PROJECT_NAME}_MINOR_VERSION 1 )
SET( ${PROJECT_NAME}_PATCH_LEVEL 0 )
```

Current version: **1.1.0**

## Release Process

### 1. Update Version
To create a new release:

1. Update version numbers in `CMakeLists.txt`
2. Commit the version change
3. Create a git tag: `git tag v1.1.1`
4. Push the tag: `git push origin v1.1.1`

### 2. Automated Release
When you push a version tag (e.g., `v1.1.1`):

- GitHub Actions automatically creates a GitHub release
- Docker images are built and pushed with version tags:
  - `ghcr.io/markuskreitzer/LTE-Cell-Scanner:v1.1.1`
  - `ghcr.io/markuskreitzer/LTE-Cell-Scanner:v1.1`
  - `ghcr.io/markuskreitzer/LTE-Cell-Scanner:v1`
  - `ghcr.io/markuskreitzer/LTE-Cell-Scanner:latest`

### 3. Continuous Builds
- **Main branch**: Builds `latest-nightly` tag on every push
- **Pull requests**: Builds are tested but not published
- **Multi-arch**: Supports `linux/amd64` and `linux/arm64`

## Version Guidelines

### MAJOR version
- Breaking changes to API or CLI interface
- Major architectural changes
- Changes that require user configuration updates

### MINOR version  
- New features (new SDR support, new algorithms)
- Significant improvements to existing functionality
- Backward-compatible API additions

### PATCH version
- Bug fixes
- Performance improvements
- Documentation updates
- Build system improvements

## Docker Image Tags

| Tag | Description | When Updated |
|-----|-------------|--------------|
| `latest` | Most recent stable release | On new version tag |
| `latest-nightly` | Latest build from main branch | On every push to main |
| `vX.Y.Z` | Specific version | On version tag |
| `vX.Y` | Latest minor version | On version tag |
| `vX` | Latest major version | On version tag |

## Example Workflow

```bash
# 1. Update version for patch release
# Edit CMakeLists.txt: PATCH_LEVEL 0 -> 1

# 2. Commit and tag
git add CMakeLists.txt
git commit -m "bump version to 1.1.1"
git tag v1.1.1

# 3. Push changes
git push origin main
git push origin v1.1.1

# 4. Monitor GitHub Actions for build and release
```