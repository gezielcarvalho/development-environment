import * as React from "react";
import Navbar from "react-bootstrap/Navbar";
import Container from "react-bootstrap/Container";
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";
import "bootstrap/dist/css/bootstrap.css";

import { BrowserRouter as Router , Routes, Route, Link } from "react-router-dom";

import EditAirline from "./components/airline/edit.component";
import AirlineList from "./components/airline/list.component";
import CreateAirline from "./components/airline/create.component";

function App() {
  return (<Router>
    <Navbar bg="primary">
      <Container>
        <Link to={"/"} className="navbar-brand text-white">
          Basic Crud App
        </Link>
      </Container>
    </Navbar>

    <Container className="mt-5">
      <Row>
        <Col md={12}>
          <Routes>
            <Route path="/airline/create" element={<CreateAirline />} />
            <Route path="/airline/edit/:id" element={<EditAirline />} />
            <Route exact path='/' element={<AirlineList />} />
          </Routes>
        </Col>
      </Row>
    </Container>
  </Router>);
}

export default App;