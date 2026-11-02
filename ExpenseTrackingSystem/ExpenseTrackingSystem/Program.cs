using System;

namespace ExpenseTrackingSystem
{
    class Expense
    {
        private string category;
        private double amount;

        // Constructor
        public Expense(string category, double amount)
        {
            this.category = category;
            this.amount = amount;
        }

        // Display Method
        public void Display()
        {
            Console.WriteLine("Category : " + category);
            Console.WriteLine("Amount   : Rs." + amount);
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("=== Expense Tracking Module ===");

                Console.Write("Enter Expense Category: ");
                string category = Console.ReadLine();

                Console.Write("Enter Expense Amount: ");
                double amount = Convert.ToDouble(Console.ReadLine());

                // Validation
                if (amount <= 0)
                {
                    throw new Exception("Amount must be greater than zero.");
                }

                // Create Object
                Expense exp = new Expense(category, amount);

                Console.WriteLine("\nExpense Added Successfully!\n");
                exp.Display();
            }
            catch (FormatException)
            {
                Console.WriteLine("\nError: Please enter a valid numeric amount.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("\nError: " + ex.Message);
            }
            finally
            {
                Console.WriteLine("\nThank you for using Expense Tracking System.");
            }

            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }
    }
}