# FNN-with-Verilog
MNIST-Classifier-FNN Implementation with Verilog and 8 available neurons.
This FNN has already been trained and the suitable weights and biases are used in this verilog implementation for testing.

## Inputs
In this project we designed a fully conncted FNN that has 8 2-input ```MAC```(Multiply And Accumulate) units available at a time. 
The FNN inputs belong to images in the MNIST dataset. Each input consists of 62 8-bit sign-and-magnitude numbers.

## First Layer
Has 30 neurons but due to limited resources, only 8 neurons can work at a time and each of this neurons can only process 8 of its 62 inputs.

## Second Layer 
Has 10 nerons and follows the same restrictions as the first layer. This layer is the output layer and the index of the neuron with the largest output indicates the class that each input belongs to.

## Documentation
For full project description, please refer to Description.pdf.

Datapath and Controller figures are also available at CAD#4_REPORT.pdf.
