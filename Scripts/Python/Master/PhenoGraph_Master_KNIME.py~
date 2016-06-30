import phenograph
import numpy
import networkx
from scipy.sparse import coo_matrix
from scipy.io import mmread, mmwrite
from numpy import genfromtxt
data = genfromtxt('xxCsvPathxx', delimiter=',')
communities, graph, Q = phenograph.cluster(data)
numpy.savetxt('xxSaveCsvPathxx', communities, delimiter=",")
mmwrite('xxSaveGraphPathxx', graph)
text_file = open('xxSaveQPathxx', "w")
text_file.write(str(Q))
text_file.close()
G = networkx.Graph(graph)
networkx.write_pajek(G, path = 'xxPajekPathxx', encoding='UTF-8')
networkx.write_gml(G, path = 'xxGmlPathxx')
networkx.write_edgelist(G, path = 'xxTabPathxx', delimiter = '\t')
