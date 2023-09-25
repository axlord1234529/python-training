from django.shortcuts import render
import pandas as pd
import networkx as nx
from display.models import Edge,User
from django.http import JsonResponse
# bokeh imports
from bokeh.plotting import from_networkx
from bokeh.document import Document
from bokeh.layouts import column, row
from bokeh.models import (Circle,
                          HoverTool, MultiLine, Plot, TapTool,CustomJS,Slider, DataTable, TableColumn)
from bokeh.embed import server_document
from bokeh.palettes import Spectral4

def get_data_from_database() -> pd.DataFrame:
    edges = Edge.objects.all()
    edge_list = list(edges.values())
    
    df = pd.DataFrame(edge_list)

    return df

def get_edge_info_for_table(request) -> JsonResponse:
    if request.method == 'GET':
        user1_id_list = request.GET.getlist('id_list1[]')
        user2_id_list = request.GET.getlist('id_list2[]')

        users1 =  [User.objects.values_list('username', flat=True).get(id=user_id) for user_id in user1_id_list ]
        users2 = [User.objects.values_list('username', flat=True).get(id=user_id) for user_id in user2_id_list ]

        response_data = {
            'users1': users1,
            'users2': users2,
        }
        return JsonResponse(response_data)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)
    
def get_user_info_for_table(request) -> JsonResponse:
    if request.method == 'GET':
        user_id_list = request.GET.getlist('id_list[]')
        

        users =  [User.objects.values_list('username', flat=True).get(id=user_id) for user_id in user_id_list ]
        email = [User.objects.values_list('email', flat=True).get(id=user_id) for user_id in user_id_list ]

        response_data = {
            'users': users,
            'email': email,
        }
        return JsonResponse(response_data)
    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)

def bokeh_handler(doc: Document) -> None:
    # Create tables
    columns = [
        TableColumn(field="users1", title="User 1"),
        TableColumn(field="users2", title="User 2")
    ]
    edge_data_table = DataTable( columns=columns, width=400, height=280)

    columns = [
        TableColumn(field="users1", title="User 1"),
        TableColumn(field="users2", title="User 2")
    ]

    node_columns = [
        TableColumn(field="users", title="User"),
        TableColumn(field="email", title="E-mail")
    ]
    node_data_table = DataTable( columns=node_columns, width=400, height=280)

    # get data for graph from db
    df = get_data_from_database()

    # Create networkx graph
    G = nx.from_pandas_edgelist(df=df,source='user1_id', target='user2_id', edge_attr=['weight'])

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

    # graph callbacks
    def edge_selected_callback(attr,old,new):
        node_source =  graph.node_renderer.data_source
        index = node_source.data['index']
        start_nodes = [graph.edge_renderer.data_source.data['start'][edge] for edge in new]
        end_nodes = [graph.edge_renderer.data_source.data['end'][edge] for edge in new]
        
        # reset color
        graph.node_renderer.data_source.data = dict(
            index = index ,
            fill_color =  [Spectral4[0] for i in  range(len(index))]
        )
        
        # color red
        for node in start_nodes:
            for i in range(len(node_source.data['index'])):
                if node_source.data['index'][i] == node:
                    node_source.data['fill_color'][i] = 'red'

        for node in end_nodes:
            for i in range(len(node_source.data['index'])):
                if node_source.data['index'][i] == node:
                    node_source.data['fill_color'][i] = 'red'

        new_node_data = {
            'index' : node_source.data['index'],
            'fill_color': node_source.data['fill_color']
        }
        
        graph.node_renderer.data_source.data = new_node_data
        
    js_node_selected_callback = CustomJS(args=dict(node_source = graph.node_renderer.data_source,data_table_source = node_data_table.source), code = """ 
        const selectedNodes = node_source.selected.indices;
        const userIdList = selectedNodes.map(node => node_source.data['index'][node]);
        getUserInfoById(userIdList,data_table_source);
                                        """)
    
    js_edge_selected_callback = CustomJS(args=dict(node_source = graph.node_renderer.data_source, edge_source = graph.edge_renderer.data_source, data_table_source = edge_data_table.source), code = """
        const dt = data_table_source
        let selectedEdges = edge_source.selected.indices;                             
        const startNodes = selectedEdges.map(edge => edge_source.data['start'][edge]);
        const endNodes = selectedEdges.map(edge => edge_source.data['end'][edge]);
                                      
        getEdgeInfoById(startNodes,endNodes,dt);
        dt.change.emit();
                                      """)

    graph.edge_renderer.data_source.selected.on_change('indices', edge_selected_callback)
    graph.edge_renderer.data_source.selected.js_on_change('indices',js_edge_selected_callback)
    graph.node_renderer.data_source.selected.js_on_change('indices',js_node_selected_callback)

    og_edge_data = graph.edge_renderer.data_source.data
    og_node_data = graph.node_renderer.data_source.data
   
    # Plot
    p = Plot(width= 700, height = 700, title = 'Nodes are clickable and you can hover over edges and nodes')
    p.add_tools(HoverTool(renderers=[graph.edge_renderer],tooltips=[('Node 1', '@start'), ('Node 2', '@end'), ('Weight', '@weight')]))
    p.add_tools(HoverTool(renderers=[graph.node_renderer], tooltips=[('Node', '@index')]))

    p.add_tools(TapTool(renderers = [graph.edge_renderer, graph.node_renderer]))

    def on_plot_tap_callback_2():
        # Reset node's colors when clicking on plot
        ORIGINAL_NODE_COLOR = '#2b83ba'
        selected_nodes =  graph.node_renderer.data_source.selected.indices
        selected_edges =  graph.edge_renderer.data_source.selected.indices
        if len(selected_nodes) == 0 and len(selected_edges) == 0:
            graph.node_renderer.data_source.data['fill_color']  = [ORIGINAL_NODE_COLOR for i in range(len(graph.node_renderer.data_source.data['fill_color']))]

    p.on_event('tap', on_plot_tap_callback_2)
    p.renderers.append(graph)

    # Slider
    slider = Slider(start=0, end=5, value=0, step=1, title="Threshold: ")

    def slider_callback(attr,old,new):
        # filter edges
        graph.edge_renderer.data_source.selected.indices = []
        start_nodes =  og_edge_data['start']
        end_nodes = og_edge_data['end']
        weights = og_edge_data['weight']
        
        new_edge_data = {'start' : [ start_nodes[i] for i in range(len(start_nodes)) if weights[i] > new ],
              'end': [ end_nodes[i] for i in range(len(end_nodes)) if weights[i] > new],
              'weight': [weight for weight in weights if weight > new]}
        
        graph.edge_renderer.data_source.data = new_edge_data
        # filter nodes
        indices = og_node_data['index']
        new_index = [index for index in indices if index in new_edge_data['start'] or index in new_edge_data['end']]

        new_node_data = {'index' : new_index,
                        'fill_color' : [Spectral4[0] for i in range(len(new_index))]}
        
        graph.node_renderer.data_source.data = new_node_data

    slider.on_change('value',slider_callback)

    layout = column(row(p, column(edge_data_table, node_data_table)),slider)
    
    doc.add_root(layout)

def home(request):
    script = server_document(request.build_absolute_uri())
    return render(request, 'home.html', dict(script = script))