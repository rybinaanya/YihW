import plotly.graph_objects as go
import pickle
import numpy as np
import plotly.io as pio
pio.renderers.default = 'iframe'  # or 'notebook' or 'colab' or 'jupyterlab'

path = '.'
name1 = 'YihW_long'
ls, gs = [], []
for i in range(1, 6):
    with open(f'{path}/{name1}/result_model_{i}.pkl', 'rb') as f:
        data = pickle.load(f)
    ls.append(data['plddt'])
    gs.append(np.mean(data['plddt']))
ranked_long = zip(gs, ls)
ranked_long = sorted(ranked_long, key=lambda t: t[0])[::-1]


name2 = 'YihW_short'
ls, gs = [], []
for i in range(1, 6):
    with open(f'{path}/{name2}/result_model_{i}.pkl', 'rb') as f:
        data = pickle.load(f)
    ls.append(data['plddt'])
    gs.append(np.mean(data['plddt']))
ranked_short = zip(gs, ls)
ranked_short = sorted(ranked_short, key=lambda t: t[0])[::-1]


ls = ranked_long[0][1]
gs = ranked_long[0][0]
plot = go.Figure(data=[go.Scatter(
    x=np.arange(len(ls)), y=ls, showlegend=True, mode='lines', hoverinfo='x+y', line=dict(width=4),
    name=f'full-length, Average pLDDT = {gs:.2f}', line_color='#0981D1')
])

ls = ranked_short[0][1]
gs = ranked_short[0][0]
plot.add_trace(go.Scatter(x=np.arange(24, len(ls)+24), y=ls, showlegend=True, mode='lines', hoverinfo='x+y',
                          line_color='#7FFFD4', line=dict(width=4), name=f'shortened, Average pLDDT = {gs:.2f}'))

plot.update_xaxes(title_text="Residue")
plot.update_yaxes(title_text="Confidence score pLDDT")
plot.layout.template = "plotly_white"
plot.update_layout(title='Predicted pLDDT', font=dict(size=25),  title_x=0.5)
plot.show()


pio.write_image(plot, 'pLDDT_ranked_0_both_YihW.png', scale=2, width=2200, height=1080)
