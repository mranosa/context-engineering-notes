#!/bin/bash
# example-code-migrator.sh - Sub-agent for code migration
# This script demonstrates a code migration sub-agent that can transform
# code from one framework/version to another

# Function to display usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -s, --source TYPE      Source framework/version (e.g., react16, vue2)"
    echo "  -t, --target TYPE      Target framework/version (e.g., react18, vue3)"
    echo "  -d, --directory DIR    Directory to migrate (default: current)"
    echo "  -b, --backup           Create backup before migration"
    echo "  -n, --dry-run          Perform dry run without changes"
    echo "  -h, --help             Show this help message"
}

# Default values
SOURCE=""
TARGET=""
DIRECTORY="."
BACKUP=false
DRY_RUN=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--source)
            SOURCE="$2"
            shift 2
            ;;
        -t|--target)
            TARGET="$2"
            shift 2
            ;;
        -d|--directory)
            DIRECTORY="$2"
            shift 2
            ;;
        -b|--backup)
            BACKUP=true
            shift
            ;;
        -n|--dry-run)
            DRY_RUN=true
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

# Validate required arguments
if [ -z "$SOURCE" ] || [ -z "$TARGET" ]; then
    echo "Error: Source and target must be specified"
    show_usage
    exit 1
fi

# Code Migrator Sub-agent
run_code_migrator() {
    claude-code "You are CodeMigrator sub-agent. Perform migration from $SOURCE to $TARGET:

MIGRATION CONTEXT:
- Source: $SOURCE
- Target: $TARGET
- Directory: $DIRECTORY
- Backup: $BACKUP
- Dry Run: $DRY_RUN

PHASE 1: ANALYSIS
1. Scan $DIRECTORY to identify:
   - Project structure
   - Dependencies in package.json
   - Framework-specific files
   - Configuration files
   - Test setup

2. Create migration-plan.md with:
   - Files to migrate
   - Dependencies to update
   - Breaking changes identified
   - Risk assessment (low/medium/high)
   - Estimated effort

3. Detect migration type:
$(case "${SOURCE}_to_${TARGET}" in
    react16_to_react18)
        echo "   REACT 16 to 18 MIGRATION:
   - Identify class components to convert
   - Find deprecated lifecycle methods
   - Locate ReactDOM.render usage
   - Check for automatic batching issues
   - Find Suspense boundary needs"
        ;;
    vue2_to_vue3)
        echo "   VUE 2 to 3 MIGRATION:
   - Identify Options API components
   - Find filters to replace
   - Locate Vue.set/Vue.delete usage
   - Check for slot syntax changes
   - Find v-model changes needed"
        ;;
    js_to_ts)
        echo "   JAVASCRIPT to TYPESCRIPT:
   - Analyze type inference possibilities
   - Identify function signatures
   - Find object shapes
   - Detect API contracts
   - Locate any type needs"
        ;;
    commonjs_to_esm)
        echo "   COMMONJS to ES MODULES:
   - Find require() statements
   - Locate module.exports
   - Identify dynamic requires
   - Check circular dependencies
   - Find __dirname/__filename usage"
        ;;
    *)
        echo "   GENERIC MIGRATION:
   - Identify syntax differences
   - Find API changes
   - Locate deprecated features
   - Check compatibility issues"
        ;;
esac)

$(if [ "$BACKUP" = true ]; then
    echo "
PHASE 2: BACKUP
1. Create backup directory: ${DIRECTORY}_backup_$(date +%Y%m%d_%H%M%S)
2. Copy all source files
3. Create backup manifest
4. Verify backup integrity"
fi)

PHASE 3: MIGRATION EXECUTION
$(if [ "$DRY_RUN" = true ]; then
    echo "DRY RUN MODE - No actual changes will be made
1. Simulate migrations
2. Generate change preview
3. Create dry-run-report.md"
else
    echo "LIVE MIGRATION MODE
1. Process files in order of dependency
2. Apply transformations
3. Update configurations
4. Modify package.json"
fi)

TRANSFORMATION RULES:
$(case "${SOURCE}_to_${TARGET}" in
    react16_to_react18)
        echo "
// Class to Function Component
BEFORE:
class MyComponent extends React.Component {
  state = { count: 0 }
  componentDidMount() { ... }
  render() { return <div>{this.state.count}</div> }
}

AFTER:
function MyComponent() {
  const [count, setCount] = useState(0);
  useEffect(() => { ... }, []);
  return <div>{count}</div>;
}

// ReactDOM.render to createRoot
BEFORE:
ReactDOM.render(<App />, document.getElementById('root'));

AFTER:
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);"
        ;;
    vue2_to_vue3)
        echo "
// Options API to Composition API
BEFORE:
export default {
  data() { return { count: 0 } },
  methods: { increment() { this.count++ } },
  mounted() { ... }
}

AFTER:
export default {
  setup() {
    const count = ref(0);
    const increment = () => count.value++;
    onMounted(() => { ... });
    return { count, increment };
  }
}"
        ;;
    js_to_ts)
        echo "
// Add Type Annotations
BEFORE:
function processUser(user) {
  return user.name.toUpperCase();
}

AFTER:
interface User {
  name: string;
  id: number;
}

function processUser(user: User): string {
  return user.name.toUpperCase();
}"
        ;;
esac)

PHASE 4: DEPENDENCY UPDATE
1. Update package.json with new versions
2. Add new required dependencies
3. Remove deprecated packages
4. Update scripts if needed
5. Generate lock file updates

PHASE 5: TESTING
1. Run syntax validation
2. Execute existing tests
3. Fix any test failures
4. Update test configurations
5. Generate test-results.md

PHASE 6: VALIDATION
1. Ensure no syntax errors
2. Verify imports resolve
3. Check for type errors (if applicable)
4. Validate configuration files
5. Run build process

PHASE 7: REPORTING
Generate migration-report.md with:
- Migration summary
- Files migrated: count and list
- Changes per file
- Dependencies updated
- Test results
- Manual steps required
- Rollback instructions

ERROR HANDLING:
- Log all errors to migration-errors.log
- Attempt automatic fixes where possible
- Provide manual fix instructions
- Option to rollback on critical errors

SUCCESS CRITERIA:
- All files migrated successfully
- No syntax errors
- Tests passing (or marked for update)
- Build succeeds
- Documentation updated"
}

# Main execution
echo "Starting Code Migration Sub-agent..."
echo "Migrating from $SOURCE to $TARGET"
echo "Directory: $DIRECTORY"
[ "$BACKUP" = true ] && echo "Backup: Enabled"
[ "$DRY_RUN" = true ] && echo "Mode: Dry Run"
echo "----------------------------------------"

# Run the sub-agent
run_code_migrator

echo "----------------------------------------"
echo "Migration process complete!"
echo "Check migration-report.md for details."
[ "$BACKUP" = true ] && echo "Backup created in ${DIRECTORY}_backup_*"