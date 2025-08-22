#!/bin/bash
# example-file-processor.sh - Sub-agent for file operations
# This script demonstrates a file processing sub-agent that can analyze,
# transform, and optimize files in a codebase

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -d, --directory DIR    Directory to process (default: current)"
    echo "  -t, --type TYPE        File type to process (js, ts, py, etc.)"
    echo "  -a, --action ACTION    Action to perform (analyze, optimize, format)"
    echo "  -v, --verbose          Enable verbose output"
    echo "  -h, --help             Show this help message"
}

# Default values
DIRECTORY="."
FILE_TYPE="js"
ACTION="analyze"
VERBOSE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--directory)
            DIRECTORY="$2"
            shift 2
            ;;
        -t|--type)
            FILE_TYPE="$2"
            shift 2
            ;;
        -a|--action)
            ACTION="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# File Processor Sub-agent
run_file_processor() {
    claude-code "You are FileProcessor sub-agent. Execute this workflow:

INITIALIZATION:
- Working directory: $DIRECTORY
- Target file type: *.$FILE_TYPE
- Action: $ACTION
- Create processing-log.md to track all operations

FILE DISCOVERY:
1. Find all .$FILE_TYPE files recursively in $DIRECTORY
2. Exclude node_modules, .git, build, dist directories
3. Create file-inventory.json with:
   - File paths
   - File sizes
   - Last modified dates
   - Line counts

PROCESSING ACTION: $ACTION

$(case $ACTION in
    analyze)
        echo "ANALYSIS MODE:
For each file in inventory:
1. Calculate complexity metrics:
   - Cyclomatic complexity
   - Lines of code
   - Comment ratio
   - Function count
   - Average function length
2. Identify code issues:
   - Long functions (>50 lines)
   - Deep nesting (>4 levels)
   - Duplicate code blocks
   - Missing documentation
3. Generate quality score (0-100)
4. Create analysis-report.md with:
   - Overall statistics
   - File-by-file breakdown
   - Top 10 most complex files
   - Improvement recommendations"
        ;;
    optimize)
        echo "OPTIMIZATION MODE:
For each file in inventory:
1. Code improvements:
   - Remove unused imports
   - Remove console.log statements
   - Add missing semicolons
   - Fix indentation (2 spaces)
   - Remove trailing whitespace
2. Performance optimizations:
   - Convert var to const/let
   - Use arrow functions where appropriate
   - Optimize loops
   - Add async/await where beneficial
3. Safety checks:
   - Run syntax validation
   - Ensure no breaking changes
   - Create backup before modifying
4. Generate optimization-report.md"
        ;;
    format)
        echo "FORMATTING MODE:
For each file in inventory:
1. Apply consistent formatting:
   - Standardize quotes (single/double)
   - Fix indentation
   - Organize imports
   - Add spacing around operators
   - Align object properties
2. Add file headers:
   - Copyright notice if missing
   - File description comment
   - Author information
3. Validate formatting:
   - Check against style guide
   - Run linter if available
4. Generate formatting-report.md"
        ;;
esac)

VALIDATION:
- Verify all processed files are syntactically correct
- If errors found, restore from backup
- Run any existing tests to ensure functionality preserved
- Calculate success rate

REPORTING:
Generate final-report.md with:
- Summary of actions taken
- Files processed: count and list
- Changes made per file
- Any errors encountered
- Time taken for processing
- Before/after metrics comparison

$(if [ "$VERBOSE" = true ]; then
    echo "VERBOSE OUTPUT:
- Log each file as it's processed
- Show detailed change descriptions
- Display real-time progress
- Include debug information"
fi)

ERROR HANDLING:
- If a file fails processing, log error and continue
- Keep track of all failures
- Provide rollback instructions if needed
- Exit with appropriate status code"
}

# Main execution
echo "Starting File Processor Sub-agent..."
echo "Directory: $DIRECTORY"
echo "File Type: $FILE_TYPE"
echo "Action: $ACTION"
echo "----------------------------------------"

# Run the sub-agent
run_file_processor

echo "----------------------------------------"
echo "File processing complete!"
echo "Check processing-log.md and final-report.md for details."