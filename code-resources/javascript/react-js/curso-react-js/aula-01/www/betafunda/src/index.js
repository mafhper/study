import React from "react";
import ReactDOM from "react-dom";

function Nav() {
    return ( <
        div >
        <
        p > Navigation < /p> <
        p > Navigation < /p> < /
        div >
    );
}

function Header(props) {
    return ( <
        div >
        <
        p > { props.titulo } < /p> < /
        div >
    );
}



ReactDOM.render( <
    React.StrictMode >
    <
    Header titulo = "This is a title"
    fontSize = '35' / >
    <
    Header titulo = "This is another title"
    fontSize = '24' / >
    <
    Nav / >
    <
    /React.StrictMode>, document.getElementById("root")
);