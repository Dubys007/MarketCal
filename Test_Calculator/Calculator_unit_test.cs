using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Calculator_TASK;
using Xunit;

namespace Test_Calculator
{
    public class Calculator_unit_test
    {
        [Fact]

        public void AdditionTest()
        {
            // Arrange

            double expected = 37;

            // Act

            double actual = Calculator.Add(25, 12);

            // Assert

            Assert.Equal(expected, actual);

        }


        [Fact]

        public void SubtractionTest()

        {
            // Arrange

            double expected = 10;

            // Act

            double actual = Calculator.Subtract(20, 10);

            // Assert

            Assert.Equal(expected, actual);

        }


        [Fact]

        public void MultiplicationTest()

        {
            // Arrange

            double expected = 20;

            // Act

            double actual = Calculator.Multiply(10, 2);

            // Assert

            Assert.Equal(expected, actual);

        }


        [Fact]

        public void DivisionTest()

        {
            // Arrange

            double expected = 25;

            // Act

            double actual = Calculator.Divide(50, 2);

            // Assert

            Assert.Equal(expected, actual);

        }
   

    }
}
