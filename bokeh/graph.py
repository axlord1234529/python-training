import pandas as pd
import networkx as nx
from bokeh.plotting import figure, from_networkx, show,curdoc
from bokeh.models import (BoxSelectTool, Circle, EdgesAndLinkedNodes,NodesAndLinkedEdges,
                          HoverTool, MultiLine, Plot, TapTool,CustomJS,Slider,Select)
from bokeh.palettes import Spectral4
from bokeh.layouts import column

df = pd.read_csv('D13_graph4.csv',sep=';')
df = df.astype('int32')
weights = df[df['ID2'] == 17]['weight'].tolist()
for i in range(len(weights)):
    if i == 16:
        df.loc[(df['ID1'] == 17) & (df['ID2'] == i+2), 'weight'] = weights[i]
    else: 
        df.loc[(df['ID1'] == 17) & (df['ID2'] == i+1), 'weight'] = weights[i]


G = nx.from_pandas_edgelist(df=df,source='ID1', target='ID2', edge_attr=['weight'])


p = Plot(width= 700, height = 700, title = 'Nodes are clickable and you can hover over edges and nodes')
p.grid.grid_line_color = None

graph = from_networkx(G, nx.spring_layout,scale=1.8, center=(0,0))

p.add_tools(HoverTool(renderers=[graph.edge_renderer],tooltips=[('Node 1', '@start'), ('Node 2', '@end'), ('Weight', '@weight')]))
p.add_tools(HoverTool(renderers=[graph.node_renderer], tooltips=[('Node', '@index')]))


gl = graph.node_renderer.glyph = Circle(size=20, fill_color="fill_color")
graph.node_renderer.selection_glyph = Circle(size=15, fill_color='red')
graph.node_renderer.hover_glyph = Circle(size=15, fill_color=Spectral4[1])
graph.node_renderer.data_source.data = dict(
    index = list(range(1,len(G)+1)),
    fill_color = [Spectral4[0] for i in range(len(G))]
)
og_node_colors = graph.node_renderer.data_source.data['fill_color']
graph.edge_renderer.glyph = MultiLine(line_color="#808080", line_alpha=0.5, line_width=2)
graph.edge_renderer.selection_glyph = MultiLine(line_color=Spectral4[2], line_width=2)
graph.edge_renderer.hover_glyph = MultiLine(line_color=Spectral4[1], line_width=2)

graph.selection_policy = EdgesAndLinkedNodes()
graph.inspection_policy = EdgesAndLinkedNodes()


og_edge_data = graph.edge_renderer.data_source.data

slider = Slider(start=0, end=5, value=0, step=1, title="Threshold: ")

callback = CustomJS(args=dict(source = graph.edge_renderer.data_source, slider = slider, original_data = og_edge_data), code= """  
    const data = source.data;
    const start = original_data['start'];  
    const end = original_data['end'];      
    const weight = original_data['weight'];
    const selected_value = slider.value;
    const ds = {};
    var filteredStart = [];
    var filteredEnd = [];
    var filteredWeight = [];
    
    if(selected_value > 0){
        for (var i = 0; i < start.length; i++) {
            if (weight[i] > selected_value) {
                filteredStart.push(start[i]);
                filteredEnd.push(end[i]);
                filteredWeight.push(weight[i]);
            }
        }                
    }else {
        filteredStart = start;
        filteredEnd = end;
        filteredWeight = weight;
    }

    ds['start'] = filteredStart;
    ds['end'] = filteredEnd;
    ds['weight'] = filteredWeight;
    
    source.data = ds;

    source.change.emit();            
""")


og_node_data = graph.node_renderer.data_source

on_graph_tap_callback = CustomJS(args= dict(node_source = graph.node_renderer.data_source, edge_source = graph.edge_renderer.data_source, og_node_source = og_node_data), code = """
    var selectedNodes = node_source.selected.indices;
    var selectedEdges = edge_source.selected.indices;
    const ORIGINAL_NODE_COLOR = '#2b83ba';
    var alertMessage = "";
   
    node_source.data['fill_color'].fill(ORIGINAL_NODE_COLOR);
    node_source.change.emit();

    if(selectedNodes.length > 0 && selectedEdges.length > 0){
        selectedEdges = [];
        edge_source.selected.indices = selectedEdges; 
        edge_source.change.emit();
    }
                           
    if(selectedEdges.length > 0){
        var startNodes = selectedEdges.map(edge => edge_source.data['start'][edge]);
        var endNodes = selectedEdges.map(edge => edge_source.data['end'][edge]);
        var weights = selectedEdges.map(edge => edge_source.data['weight'][edge]);
                           
        startNodes.forEach( node => {
            node_source.data['fill_color'][node-1] = 'red';
        })
        
        endNodes.forEach( node => {
            node_source.data['fill_color'][node-1] = 'red';
        })
        node_source.change.emit();
        
        const edges = [];
        for(var i = 0; i < selectedEdges.length; i++) {
            edges[i] = "(" + startNodes[i] + ";" + endNodes[i] + ";" + weights[i] + ")";
        }
        alertMessage = "Selected edges (start;end;weight): " + edges.join(", ");           
        
                           
                                 
        setTimeout(function() {
            window.alert(alertMessage);
        }, 200);
        
    }
    
    if (selectedNodes.length > 0 && selectedEdges.length == 0) { 
        const indexes = [];
        const startNodes = edge_source.data['start'];
        const endNodes = edge_source.data['end'];
                
        selectedNodes.forEach( node => {
            startNodes.forEach((startNode, index) => {
                if(startNode === node+1){
                    indexes.push(index);
                }
            });
            
            endNodes.forEach((endNode, index) => {
                if(endNode === node+1){
                    indexes.push(index);
                }
            }); 
        });

        edge_source.selected.indices = indexes;
                           
        edge_source.change.emit();
    }                  
    
""")

on_plot_tap_callback = CustomJS(args= dict(node_source = graph.node_renderer.data_source, edge_source = graph.edge_renderer.data_source ), code = """
    const ORIGINAL_NODE_COLOR = '#2b83ba';
    var selectedNodes = node_source.selected.indices;
    var selectedEdges = edge_source.selected.indices;
                    
    if(selectedNodes.length == 0 && selectedEdges == 0){
        node_source.data['fill_color'].fill(ORIGINAL_NODE_COLOR);
        node_source.change.emit();
    }

""")


p.add_tools(TapTool(renderers = [graph.edge_renderer, graph.node_renderer],callback=on_graph_tap_callback))
p.js_on_event('tap', on_plot_tap_callback)

slider.js_on_change('value', callback)

p.renderers.append(graph)

layout = column(p, slider)


show(layout)


