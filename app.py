import streamlit as st
import pandas as pd
import numpy as np
import re
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestRegressor
import lime
import lime.lime_tabular
def parse_verilog_complexity(content):
    content = content.decode("utf-8")
    nodes = len(re.findall(r'\b(assign|always|and|or|xor|nand|nor)\b', content))
    complexity_score = len(re.findall(r';', content))
    logic_depth = int(np.log2(complexity_score + 1) * 2) 
    wires = re.findall(r'wire\s+(\w+);', content)
    max_fanout = 1
    if wires:
        for wire in wires:
            usage = len(re.findall(rf'\b{wire}\b', content))
            max_fanout = max(max_fanout, usage)
    return [nodes, logic_depth, max_fanout]
@st.cache_resource
def load_model():
    df = pd.read_csv('rtl_dataset.csv')
    X = df[['Nodes', 'Logic_Depth', 'Fan_Out']]
    y = df['Timing_Delay_ns']
    model = RandomForestRegressor(n_estimators=100, random_state=42)
    model.fit(X, y)
    return model, X
model, X_train = load_model()
st.title("⚡ AI-Powered FPGA Timing Predictor")
st.markdown("### Instant timing closure analysis without Synthesis")
uploaded_file = st.file_uploader("Upload Verilog File (.v)", type="v")
if uploaded_file is not None:
    st.success("File Uploaded Successfully!")
    features = parse_verilog_complexity(uploaded_file.read())
    col1, col2, col3 = st.columns(3)
    col1.metric("Gate Count", features[0])
    col2.metric("Logic Depth", features[1])
    col3.metric("Max Fan-out", features[2])
    input_df = pd.DataFrame([features], columns=['Nodes', 'Logic_Depth', 'Fan_Out'])
    prediction = model.predict(input_df)[0]
    st.divider()
    st.metric("⏱️ Predicted Timing Delay", f"{prediction:} ns")
    st.subheader("Why this prediction?")
    with st.spinner("Generating AI Explanation..."):
        explainer = lime.lime_tabular.LimeTabularExplainer(
            training_data=np.array(X_train),
            feature_names=X_train.columns,
            class_names=['Timing_Delay_ns'],
            mode='regression'
        )
        exp = explainer.explain_instance(
            data_row=np.array(features), 
            predict_fn=lambda x: model.predict(pd.DataFrame(x, columns=X_train.columns))
        )
        st.pyplot(exp.as_pyplot_figure())