using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Calculator_TASK
{
    public partial class Form1 : Form
    {

        Double value = 0;
        String operation = "";
        bool operation_pressed = false;


        public Form1()
        {
            InitializeComponent();
            Calculator calculator = new Calculator();
        }

        private void button16_Click(object sender, EventArgs e)
        {

        }

        private void button14_Click(object sender, EventArgs e)
        {

        }

        private void button15_Click(object sender, EventArgs e)
        {

        }

        private void button17_Click(object sender, EventArgs e)
        {

        }

        private void button13_Click(object sender, EventArgs e)
        {

        }

        private void button18_Click(object sender, EventArgs e)
        {

        }

        private void button_Click(object sender, EventArgs e)
        {

            if ((result.Text == "0") || (operation_pressed))
                result.Clear();

            operation_pressed = false;
            Button b = (Button)sender;  //converted to button 
            result.Text = result.Text + b.Text;
        }

        private void operator_click(object sender, EventArgs e)
        {
            if ((result.Text == "can't divide by zero"))
            {
                result.Text = "0";


            }
            Button b = (Button)sender;

            if (value != 0)
            {
                button14.PerformClick();
                operation_pressed = true;
                operation = b.Text;
                equation.Text = value + "" + operation;
            }
            else
            {

            

            operation = b.Text;
            value = double.Parse(result.Text);
            operation_pressed = true;
            equation.Text = value + "" + operation;
            }
        }

        private void equal_Click(object sender, EventArgs e)
        {
            operation_pressed = false;

            equation.Text = "";
            switch (operation)
            {
                case "+":
                    
                    result.Text = Calculator.Add(value, double.Parse(result.Text)).ToString();
                    break;

                case "-":
                   
                    result.Text = Calculator.Subtract(value, double.Parse(result.Text)).ToString();
                    break;

                case "*":
                   
                    result.Text = Calculator.Multiply(value, double.Parse(result.Text)).ToString();
                    break;
                case "/":
                   
                    try
                    {
                        result.Text = Calculator.Divide(value, double.Parse(result.Text)).ToString();
                    }
                    catch (Exception ex)
                    {
                        result.Text = ex.Message.ToString();

                    }

                    break;
                default:
                    break;
            }

            value = int.Parse(result.Text);
            operation = "";

        }

        private void clear_Click(object sender, EventArgs e)
        {
            result.Text = "0";
        }
    }
    }

