import React, { Component } from 'react'
import { Routes, Route } from "react-router-dom";
import Awards from './components/awards'
import Home from './Home'
import Filers from './components/filers'
import Filer from './components/filer'
import Address from './components/address';

// import NotFound from './NotFound'

export default function App() {
  return (
    <Routes>
      <Route path="/awards" element={<Awards />} />
      <Route path="/filers" element={<Filers />} />
      <Route path="/filers/:id" element={<Filer />} />
      <Route path="/address/:id" element={<Address />} />
      <Route path="/" element={<Home />} />
    </Routes>
  )
}


