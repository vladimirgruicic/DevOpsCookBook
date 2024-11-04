
### README for Performance Tuning

**File: `performance_tuning/README.md`**
```markdown
# Performance Tuning

This directory contains scripts aimed at optimizing system and application performance on Linux systems.

## Scripts

1. **system_tuning.sh**: 
   - Provides methods for tuning system performance based on resource usage.
   - Adjusts parameters such as swappiness, CPU governor, I/O scheduler, and file descriptor limits.

2. **application_tuning.sh**: 
   - Optimizes application performance through various techniques.
   - Includes adjustments for web server caching, database connection limits, and PHP settings.

## Usage

- Make the scripts executable:
  ```bash
  chmod +x system_tuning.sh application_tuning.sh
