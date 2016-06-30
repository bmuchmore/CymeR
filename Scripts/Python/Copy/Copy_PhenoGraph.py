import phenograph
import numpy
import networkx
from scipy.sparse import coo_matrix
from scipy.io import mmread, mmwrite
from numpy import genfromtxt
data = genfromtxt('/tmp/knime-r-tmp98175/RtmpiQkGmD/Input/PhenoGraphInput.csv', delimiter=',')
communities, graph, Q = phenograph.cluster(data)
numpy.savetxt('/tmp/knime-r-tmp98175/RtmpiQkGmD/Communities/communities.txt', communities, delimiter=",")
mmwrite('/tmp/knime-r-tmp98175/RtmpiQkGmD/MTX/Graph.mtx', graph)
text_file = open('/tmp/knime-r-tmp98175/RtmpiQkGmD/Q/Q.txt', "w")
text_file.write(str(Q))
text_file.close()
G = networkx.Graph(graph)
networkx.write_pajek(G, path = '/tmp/knime-r-tmp98175/RtmpiQkGmD/NET/graph.net', encoding='UTF-8')
networkx.write_gml(G, path = '/tmp/knime-r-tmp98175/RtmpiQkGmD/GML/graph.gml')
networkx.write_edgelist(G, path = '/tmp/knime-r-tmp98175/RtmpiQkGmD/Edgelist/graph.edgelist', delimiter = '\t')
