from django.shortcuts import render
import pandas as pd
import networkx as nx
from display.models import Edge
# bokeh imports
from bokeh.plotting import from_networkx
from bokeh.document import Document
from bokeh.layouts import column
from bokeh.models import (Circle, EdgesAndLinkedNodes,
                          HoverTool, MultiLine, Plot, TapTool,CustomJS,Slider)
from bokeh.embed import server_document
from bokeh.palettes import Spectral4

def get_data_from_database() -> pd.DataFrame:
    edges = Edge.objects.all()
    edge_list = list(edges.values())
    
    df = pd.DataFrame(edge_list)

    return df

def bokeh_handler(doc: Document) -> None:
    df = get_data_from_database()

    # Create networkx graph
    G = nx.from_pandas_edgelist(df=df,source='id1', target='id2', edge_attr=['weight'])

    # Create graph
    graph = from_networkx(G, nx.spring_layout,scale=1.8, center=(0,0))

    graph.node_renderer.glyph = Circle(size=20, fill_color="fill_color")
    graph.node_renderer.selection_glyph = Circle(size=15, fill_color='red')
    graph.node_renderer.hover_glyph = Circle(size=15, fill_color=Spectral4[1])
    graph.node_renderer.data_source.data = dict(
        index = list(range(1,len(G)+1)),
        fill_color = [Spectral4[0] for i in range(len(G))]
    )

    graph.edge_renderer.glyph = MultiLine(line_color="#808080", line_alpha=0.5, line_width=2)
    graph.edge_renderer.selection_glyph = MultiLine(line_color=Spectral4[2], line_width=2)
    graph.edge_renderer.hover_glyph = MultiLine(line_color=Spectral4[1], line_width=2)

    graph.selection_policy = EdgesAndLinkedNodes()
    graph.inspection_policy = EdgesAndLinkedNodes()

    # Set callback on graph. Callback fires when edge is selected.
    def edge_selected_callback(attr, old_selected, new_selected):
        print("Selected indices changed from", old_selected, "to", new_selected)
    
    graph.edge_renderer.data_source.selected.on_change('indices', edge_selected_callback)

    # plot callbacks
    og_edge_data = graph.edge_renderer.data_source.data
    og_node_data = graph.node_renderer.data_source

    on_graph_tap_callback = CustomJS(args= dict(node_source = graph.node_renderer.data_source, edge_source = graph.edge_renderer.data_source, og_node_source = og_node_data), code = """
        let selectedNodes = node_source.selected.indices;
        let selectedEdges = edge_source.selected.indices;
        const ORIGINAL_NODE_COLOR = '#2b83ba';
        let alertMessage = "";
    
        node_source.data['fill_color'].fill(ORIGINAL_NODE_COLOR);
        node_source.change.emit();

        if(selectedNodes.length > 0 && selectedEdges.length > 0){
            selectedEdges = [];
            edge_source.selected.indices = selectedEdges; 
            edge_source.change.emit();
        }
                            
        if(selectedEdges.length > 0){
            const startNodes = selectedEdges.map(edge => edge_source.data['start'][edge]);
            const endNodes = selectedEdges.map(edge => edge_source.data['end'][edge]);
            const weights = selectedEdges.map(edge => edge_source.data['weight'][edge]);
                            
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
            
            var h1Element = document.getElementById('myHeading');

            
            if (h1Element) {
                
                h1Element.textContent = alertMessage;
            }
            
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
        const selectedNodes = node_source.selected.indices;
        const selectedEdges = edge_source.selected.indices;
                        
        if(selectedNodes.length == 0 && selectedEdges == 0){
            node_source.data['fill_color'].fill(ORIGINAL_NODE_COLOR);
            node_source.change.emit();
        }

    """)
   
    # Plot
    p = Plot(width= 700, height = 700, title = 'Nodes are clickable and you can hover over edges and nodes', margin= 40)
    p.add_tools(HoverTool(renderers=[graph.edge_renderer],tooltips=[('Node 1', '@start'), ('Node 2', '@end'), ('Weight', '@weight')]))
    p.add_tools(HoverTool(renderers=[graph.node_renderer], tooltips=[('Node', '@index')]))

    p.add_tools(TapTool(renderers = [graph.edge_renderer, graph.node_renderer], callback = on_graph_tap_callback))
    p.js_on_event('tap', on_plot_tap_callback)
    p.renderers.append(graph)
    
    # Slider
    slider = Slider(start=0, end=5, value=0, step=1, title="Threshold: ", margin= 40)

    slider_callback = CustomJS(args=dict(source = graph.edge_renderer.data_source, slider = slider, original_data = og_edge_data), code= """  
        const data = source.data;
        const start = original_data['start'];  
        const end = original_data['end'];      
        const weight = original_data['weight'];
        const selected_value = slider.value;
        const ds = {};
        let filteredStart = [];
        let filteredEnd = [];
        let filteredWeight = [];
        
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

    slider.js_on_change('value', slider_callback)


    layout = column(p, slider)
    
    doc.add_root(layout)

def home(request):
    script = server_document(request.build_absolute_uri())
    return render(request, 'home.html', dict(script = script))