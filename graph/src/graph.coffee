((d3) ->
  d3.graph = (graph) ->
    graph = {} unless graph?
    nodes = []
    links = []

    graph.description = -> 'd3.graph with ' + nodes.length + ' nodes and ' +
      links.length + ' links'

    graph.nodes = (_nodes) ->
      return nodes unless _nodes?
      nodes = _nodes
      return this

    graph.links = (_links) ->
      return links unless _links?
      links = _links
      return this

    graph.matrix = (_matrix) ->

    return graph

  d3.graph.matrix = (matrix) ->
    matrix = [] unless matrix?

    matrixObj = (i, j) -> matrix[i][j]

    matrixObj.description = -> matrix.length + ' adjacency matrix'

    matrixObj.data = matrixObj.matrix = (_matrix) ->
      return matrix unless _matrix?
      matrix = _matrix
      return this

    matrixObj.set = matrixObj.addEdge = (i, j, value) ->
      console.warn 'addEdge: argument "value" is 0. It could lead to
        unpredictable behavior' if value is 0

      matrix[i][j] = if value? then value else 1
      return this

    matrixObj.remove = matrixObj.removeEdge = (i, j) ->
      matrix[i][j] = 0
      return this

    matrixObj.has = matrixObj.hasEdge = (i, j) -> !!matrix[i][j]

    matrixObj.outE = matrixObj.outEdges = (i) ->
      edge for edge in matrix[i] when edge

    matrixObj.inE = matrixObj.inEdges = (j) ->
      row[j] for row in matrix when row[j]

    matrixObj.connectedEdges = matrixObj.connectedE = (i) ->
      matrixObj.inEdges(i).concat(matrixObj.outEdges(i))
    matrixObj.inOutE = matrixObj.inOutEdges = matrixObj.connectedEdges
    matrixObj.outInE = matrixObj.outInEdges = matrixObj.connectedEdges

    return matrixObj

  d3.graph.listToMatrix = (links) ->
    max = d3.max links, (d) -> d3.max([d.source, d.target])
    matrix = ((0 for i in [1..max]) for i in [1..max])
    for link in links
      matrix[links.source][link.target] = 1
    return matrix

  d3.graph.matrixToList = (matrix) ->
    links = []
    for row, i in matrix
      for element, j in row
        links.push source: i, target: j, value: matrix[i][j]
    return links

)(d3)