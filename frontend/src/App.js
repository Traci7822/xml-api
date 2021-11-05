import React, { Component } from 'react'
import { Routes, Route } from "react-router-dom";
import Awards from './components/awards'
import Award from './components/award'
import Home from './Home'
import Filers from './components/filers'
import Filer from './components/filer'
import Address from './components/address';
import Receivers from './components/receivers'
import Receiver from './components/receiver'

// import NotFound from './NotFound'

export default function App() {
  return (
    <Routes>
      <Route path="/awards" element={<Awards />} />
      <Route path="/awards/:id" element={<Award />} />      
      <Route path="/filers" element={<Filers />} />
      <Route path="/filers/:id" element={<Filer />} />
      <Route path="/address/:user_type/:id" element={<Address />} />
      <Route path="/receivers" element={<Receivers />} />
      <Route path="/receivers/:id" element={<Receiver />} />
      <Route path="/" element={<Home />} />
    </Routes>
  )
}


