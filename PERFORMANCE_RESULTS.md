# PERFORMANCE_RESULTS.md

## Table of Contents
- [Introduction](#introduction)
- [Method Complexity Analysis](#method-complexity-analysis)
  - [addVertex](#addvertex)
  - [addEdge](#addedge)
  - [hasVertex](#hasvertex)
  - [hasEdge (by edge)](#hasedge-by-edge)
  - [hasEdge (by vertices)](#hasedge-by-vertices)
  - [getEdge](#getedge)
  - [getEdgeLength](#getedgelength)
  - [remove (vertex)](#remove-vertex)
  - [removeEdge](#removeedge)
  - [getTotalEdgeLength](#gettotaledgelength)
  - [getVertices](#getvertices)
  - [getEdges](#getedges)
  - [getEdges (vertex)](#getedges-vertex)
  - [getNeighbors](#getneighbors)
- [Empirical Results](#empirical-results)
- [Performance Plots](#performance-plots)
- [Discussion](#discussion)

## Introduction
This document analyzes the runtime complexity and empirical performance of all Task 1 and Task 2 methods for both ALGraph (Adjacency List) and AMGraph (Adjacency Matrix) implementations.

## Method Complexity Analysis

### addVertex
- **ALGraph:** O(1) — HashSet and HashMap insertions are O(1) on average.
- **AMGraph:** O(1) amortized — ArrayList/HashMap insertions are O(1), but resizing the matrix is O(V^2) (happens rarely).

### addEdge
- **ALGraph:** O(1) — HashSet insertions and adjacency list updates are O(1).
- **AMGraph:** O(1) — Direct matrix assignment and HashSet insertion are O(1).

### hasVertex
- **ALGraph:** O(1) — HashSet lookup.
- **AMGraph:** O(1) — HashMap lookup.

### hasEdge (by edge)
- **ALGraph:** O(1) — HashSet lookup.
- **AMGraph:** O(1) — HashSet lookup.

### hasEdge (by vertices)
- **ALGraph:** O(deg(v1)) — Must scan adjacency list for v1 (deg(v1) is degree of v1).
- **AMGraph:** O(1) — Matrix lookup.

### getEdge
- **ALGraph:** O(deg(v1)) — Must scan adjacency list for v1.
- **AMGraph:** O(E) — Must scan all edges to find the matching one (since only length is stored in matrix).

### getEdgeLength
- **ALGraph:** O(deg(v1)) — Uses getEdge.
- **AMGraph:** O(1) — Matrix lookup.

### remove (vertex)
- **ALGraph:** O(deg(v) + V) — Remove all incident edges (deg(v)), then remove from all structures.
- **AMGraph:** O(E + V) — Remove all incident edges (scan all edges), update matrix, reindex vertices.

### removeEdge
- **ALGraph:** O(1) — HashSet removals and adjacency list updates are O(1).
- **AMGraph:** O(1) — Matrix and HashSet removals are O(1).

### getTotalEdgeLength
- **ALGraph:** O(E) — Must sum all edge lengths.
- **AMGraph:** O(E) — Must sum all edge lengths.

### getVertices
- **ALGraph:** O(V) — Copy HashSet.
- **AMGraph:** O(V) — Copy ArrayList.

### getEdges
- **ALGraph:** O(E) — Copy HashSet.
- **AMGraph:** O(E) — Copy HashSet.

### getEdges (vertex)
- **ALGraph:** O(deg(v)) — Copy adjacency list for v.
- **AMGraph:** O(E) — Scan all edges for those incident to v.

### getNeighbors
- **ALGraph:** O(deg(v)) — Scan adjacency list for v.
- **AMGraph:** O(V * deg(v)) — Scan matrix row and then scan edges for each neighbor.

## Empirical Results

The performance benchmark was run on graphs of sizes: 10, 50, 100, 200, 500, 1000, and 2000 vertices. Each method was tested with 10,000 iterations after a 1,000 iteration warmup period to ensure accurate measurements.

### Task 1 Method Performance Results

**addVertex:**
- **ALGraph:** Consistent O(1) performance across all graph sizes
- **AMGraph:** O(1) amortized performance, with occasional spikes due to matrix resizing

**addEdge:**
- **ALGraph:** O(1) performance, very consistent
- **AMGraph:** O(1) performance, slightly faster than ALGraph due to direct matrix access

**hasVertex:**
- **ALGraph:** O(1) HashSet lookup, very fast
- **AMGraph:** O(1) HashMap lookup, comparable performance

**hasEdge (by edge):**
- **ALGraph:** O(1) HashSet lookup
- **AMGraph:** O(1) HashSet lookup, similar performance

**hasEdge (by vertices):**
- **ALGraph:** O(deg(v1)) - performance varies with vertex degree
- **AMGraph:** O(1) matrix lookup, much faster for high-degree vertices

**getEdge:**
- **ALGraph:** O(deg(v1)) - performance degrades with vertex degree
- **AMGraph:** O(E) - must scan all edges, slower for dense graphs

**getEdgeLength:**
- **ALGraph:** O(deg(v1)) - uses getEdge internally
- **AMGraph:** O(1) - direct matrix access, fastest method

### Task 2 Method Performance Results

**getTotalEdgeLength:**
- **ALGraph:** O(E) - must iterate through all edges
- **AMGraph:** O(E) - must iterate through all edges, similar performance

**removeEdge:**
- **ALGraph:** O(1) - HashSet and adjacency list removals
- **AMGraph:** O(1) - matrix and HashSet removals, slightly faster

**remove (vertex):**
- **ALGraph:** O(deg(v) + V) - performance varies significantly with vertex degree
- **AMGraph:** O(E + V) - must scan all edges and reindex, slower for dense graphs

**getVertices:**
- **ALGraph:** O(V) - HashSet copy operation
- **AMGraph:** O(V) - ArrayList copy operation, slightly faster

**getEdges:**
- **ALGraph:** O(E) - HashSet copy operation
- **AMGraph:** O(E) - HashSet copy operation, similar performance

**getEdges (vertex):**
- **ALGraph:** O(deg(v)) - copy adjacency list for vertex
- **AMGraph:** O(E) - must scan all edges, much slower for high-degree vertices

**getNeighbors:**
- **ALGraph:** O(deg(v)) - scan adjacency list for vertex
- **AMGraph:** O(V * deg(v)) - scan matrix row and then scan edges, significantly slower

## Performance Plots

The following performance charts have been generated using JFreeChart and show the empirical performance of each method:

### Task 1 Performance Charts:
- `task1_addVertex_performance.png` - Vertex addition performance
- `task1_addEdge_performance.png` - Edge addition performance  
- `task1_hasVertex_performance.png` - Vertex existence checking
- `task1_hasEdge_performance.png` - Edge existence checking
- `task1_getEdge_performance.png` - Edge retrieval performance
- `task1_getEdgeLength_performance.png` - Edge length retrieval

### Task 2 Performance Charts:
- `task2_getTotalEdgeLength_performance.png` - Total edge length calculation
- `task2_removeEdge_performance.png` - Edge removal performance
- `task2_remove_performance.png` - Vertex removal performance
- `task2_getVertices_performance.png` - Vertex collection retrieval
- `task2_getEdges_performance.png` - Edge collection retrieval
- `task2_getNeighbors_performance.png` - Neighbor retrieval performance

### Summary Performance Chart:
- `performance_comparison_summary.png` - Comprehensive comparison of ALGraph vs AMGraph performance across all methods (2000 vertex graph)

**Note**: All charts are automatically organized in the `performance_charts/` directory with a detailed README explaining each chart.

## Discussion

### Key Performance Insights:

1. **ALGraph Advantages:**
   - Superior performance for `getNeighbors()` and `getEdges(vertex)` operations
   - Better performance for vertex removal in sparse graphs
   - More consistent performance across different graph densities

2. **AMGraph Advantages:**
   - Faster `getEdgeLength()` due to direct matrix access
   - Better performance for `hasEdge(vertices)` and `addEdge()` operations
   - More predictable performance for vertex removal in dense graphs

3. **Critical Performance Differences:**
   - **getEdge:** AMGraph is significantly slower (O(E) vs O(deg(v))) for dense graphs
   - **getNeighbors:** AMGraph is much slower (O(V*deg(v)) vs O(deg(v))) for high-degree vertices
   - **remove(vertex):** ALGraph is faster for sparse graphs, AMGraph for dense graphs

4. **Memory vs Performance Trade-offs:**
   - ALGraph uses less memory for sparse graphs
   - AMGraph provides faster edge existence checks
   - Choice depends on the specific use case and graph density

### Recommendations:

- **Use ALGraph for:** Sparse graphs, frequent neighbor queries, vertex removals
- **Use AMGraph for:** Dense graphs, frequent edge length queries, edge existence checks
- **Hybrid approach:** Consider using both representations for different operations in the same application

The empirical results largely confirm the theoretical complexity analysis, with some practical considerations for memory allocation and cache performance affecting absolute timing values.

## How to Run the Benchmark

To reproduce these performance results, you can run the benchmark using Gradle:

```bash
# Run the complete performance benchmark
./gradlew runBenchmark

# Or run it with the custom task
./gradlew runExample -Pargs=GraphPerformanceBenchmark
```

The benchmark will:
1. Test all Task 1 and Task 2 methods on graphs of sizes 10, 50, 100, 200, 500, 1000, and 2000 vertices
2. Generate individual performance charts for each method
3. Create a comprehensive summary chart comparing ALGraph vs AMGraph performance
4. Automatically organize all charts into the `performance_charts/` directory
5. Create a detailed README explaining each chart

## Conclusion

This comprehensive performance analysis demonstrates the trade-offs between adjacency list and adjacency matrix graph representations:

- **ALGraph** excels in neighbor queries and vertex operations, making it ideal for sparse graphs and algorithms that frequently access vertex neighborhoods
- **AMGraph** provides faster edge existence checks and edge length queries, making it suitable for dense graphs and applications requiring frequent edge operations
- The choice between representations should be based on the specific use case, graph density, and the most common operations in the application

The generated charts provide visual evidence of these performance characteristics and can be used to guide implementation decisions for graph-based applications. 