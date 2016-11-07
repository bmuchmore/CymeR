import phenograph
import numpy
import networkx
from scipy.sparse import coo_matrix
from scipy.io import mmread, mmwrite
from numpy import genfromtxt
data = genfromtxt('/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/Input/Bendall.fcs.csv', delimiter=',')
communities, graph, Q = phenograph.cluster(data)
numpy.savetxt('/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/Communities/Bendall.fcs.csv', communities, delimiter=",")
mmwrite('/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/MTX/Bendall.fcs.graph.mtx', graph)
text_file = open('/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/Q/Bendall.fcs.Q.txt', "w")
text_file.write(str(Q))
text_file.close()
G = networkx.Graph(graph)
networkx.write_pajek(G, path = '/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/NET/Bendall.fcs.graph.net', encoding='UTF-8')
networkx.write_gml(G, path = '/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/GML/Bendall.fcs.graph.gml')
networkx.write_edgelist(G, path = '/home/developer/Data/Bendall/CUR/BHT.SNE.2D/PhenoGraph/Edgelist/Bendall.fcs.graph.edgelist', delimiter = '\t')
