using System;

namespace EmployeePayrollSystem
{
    interface IPayable
    {
        double CalculateSalary();
    }

    class Employee
    {
        protected int empId;
        protected string empName;

        public Employee(int id, string name)
        {
            empId = id;
            empName = name;
        }

        public virtual void Display()
        {
            Console.WriteLine("ID: " + empId);
            Console.WriteLine("Name: " + empName);
        }
    }

    class PermanentEmployee : Employee, IPayable
    {
        double salary, bonus;

        public PermanentEmployee(int id, string name, double salary, double bonus)
            : base(id, name)
        {
            this.salary = salary;
            this.bonus = bonus;
        }

        public double CalculateSalary()
        {
            return salary + bonus;
        }

        public override void Display()
        {
            Console.WriteLine("\nPermanent Employee");
            base.Display();
            Console.WriteLine("Total Salary: " + CalculateSalary());
        }
    }

    class ContractEmployee : Employee, IPayable
    {
        int hours;
        double rate;

        public ContractEmployee(int id, string name, int hours, double rate)
            : base(id, name)
        {
            this.hours = hours;
            this.rate = rate;
        }

        public double CalculateSalary()
        {
            return hours * rate;
        }

        public override void Display()
        {
            Console.WriteLine("\nContract Employee");
            base.Display();
            Console.WriteLine("Total Salary: " + CalculateSalary());
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            Employee e1 = new PermanentEmployee(1, "Anik", 30000, 5000);
            Employee e2 = new ContractEmployee(2, "Rahul", 100, 200);

            e1.Display();
            e2.Display();

            Console.ReadKey();
        }
    }
}