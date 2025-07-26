#!/bin/bash

# Script to organize performance charts into a dedicated directory
# This script moves all generated PNG charts to a performance_charts directory

echo "Organizing performance charts..."

# Create performance_charts directory if it doesn't exist
mkdir -p performance_charts

# Move all task1, task2, and summary charts to the directory
echo "Moving Task 1 charts..."
mv task1_*.png performance_charts/ 2>/dev/null || echo "No Task 1 charts found"

echo "Moving Task 2 charts..."
mv task2_*.png performance_charts/ 2>/dev/null || echo "No Task 2 charts found"

echo "Moving summary chart..."
mv performance_comparison_summary.png performance_charts/ 2>/dev/null || echo "No summary chart found"

# List all charts in the directory
echo ""
echo "Performance charts organized in 'performance_charts/' directory:"
echo "================================================================"
ls -la performance_charts/*.png 2>/dev/null | wc -l | tr -d ' ' | xargs echo "Total charts:"
echo ""

echo "Task 1 Charts:"
ls performance_charts/task1_*.png 2>/dev/null | sed 's/performance_charts\///' | sort || echo "No Task 1 charts found"

echo ""
echo "Task 2 Charts:"
ls performance_charts/task2_*.png 2>/dev/null | sed 's/performance_charts\///' | sort || echo "No Task 2 charts found"

echo ""
echo "Summary Chart:"
ls performance_charts/performance_comparison_summary.png 2>/dev/null | sed 's/performance_charts\///' || echo "No summary chart found"

echo ""
echo "Charts organized successfully!" 