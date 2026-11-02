using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
using Inventory_Management_Module.Models;

namespace Inventory_Management_Module.Controllers
{
    public class ProductController : Controller
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["InventoryDbConnection"].ConnectionString;

        public ActionResult Index()
        {
            var products = new List<Product>();

            try
            {
                using (var connection = new SqlConnection(connectionString))
                using (var command = new SqlCommand("SELECT ProductId, ProductName, Quantity, Price FROM Product ORDER BY ProductId", connection))
                {
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            products.Add(MapProduct(reader));
                        }
                    }
                }
            }
            catch (Exception exception)
            {
                ViewBag.ErrorMessage = "Unable to load products. " + exception.Message;
            }

            return View(products);
        }

        public ActionResult Details(int? id)
        {
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(400);
            }

            try
            {
                var product = GetProductById(id.Value);
                if (product == null)
                {
                    return HttpNotFound();
                }

                return View(product);
            }
            catch (Exception exception)
            {
                return new HttpStatusCodeResult(500, exception.Message);
            }
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product product)
        {
            if (!ModelState.IsValid)
            {
                return View(product);
            }

            try
            {
                using (var connection = new SqlConnection(connectionString))
                using (var command = new SqlCommand("INSERT INTO Product (ProductName, Quantity, Price) VALUES (@ProductName, @Quantity, @Price)", connection))
                {
                    AddProductParameters(command, product);
                    connection.Open();
                    command.ExecuteNonQuery();
                }

                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                ModelState.AddModelError("", "Unable to save the product. " + exception.Message);
                return View(product);
            }
        }

        [HttpGet]
        public ActionResult Edit(int? id)
        {
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(400);
            }

            try
            {
                var product = GetProductById(id.Value);
                if (product == null)
                {
                    return HttpNotFound();
                }

                return View(product);
            }
            catch (Exception exception)
            {
                return new HttpStatusCodeResult(500, exception.Message);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product product)
        {
            if (!ModelState.IsValid)
            {
                return View(product);
            }

            try
            {
                using (var connection = new SqlConnection(connectionString))
                using (var command = new SqlCommand("UPDATE Product SET ProductName = @ProductName, Quantity = @Quantity, Price = @Price WHERE ProductId = @ProductId", connection))
                {
                    AddProductParameters(command, product);
                    command.Parameters.Add("@ProductId", SqlDbType.Int).Value = product.ProductId;
                    connection.Open();

                    if (command.ExecuteNonQuery() == 0)
                    {
                        return HttpNotFound();
                    }
                }

                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                ModelState.AddModelError("", "Unable to update the product. " + exception.Message);
                return View(product);
            }
        }

        [HttpGet]
        public ActionResult Delete(int? id)
        {
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(400);
            }

            try
            {
                var product = GetProductById(id.Value);
                if (product == null)
                {
                    return HttpNotFound();
                }

                return View(product);
            }
            catch (Exception exception)
            {
                return new HttpStatusCodeResult(500, exception.Message);
            }
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
                using (var connection = new SqlConnection(connectionString))
                using (var command = new SqlCommand("DELETE FROM Product WHERE ProductId = @ProductId", connection))
                {
                    command.Parameters.Add("@ProductId", SqlDbType.Int).Value = id;
                    connection.Open();

                    if (command.ExecuteNonQuery() == 0)
                    {
                        return HttpNotFound();
                    }
                }

                return RedirectToAction("Index");
            }
            catch (Exception exception)
            {
                return new HttpStatusCodeResult(500, exception.Message);
            }
        }

        private Product GetProductById(int id)
        {
            using (var connection = new SqlConnection(connectionString))
            using (var command = new SqlCommand("SELECT ProductId, ProductName, Quantity, Price FROM Product WHERE ProductId = @ProductId", connection))
            {
                command.Parameters.Add("@ProductId", SqlDbType.Int).Value = id;
                connection.Open();

                using (var reader = command.ExecuteReader())
                {
                    return reader.Read() ? MapProduct(reader) : null;
                }
            }
        }

        private static Product MapProduct(SqlDataReader reader)
        {
            return new Product
            {
                ProductId = Convert.ToInt32(reader["ProductId"]),
                ProductName = Convert.ToString(reader["ProductName"]),
                Quantity = Convert.ToInt32(reader["Quantity"]),
                Price = Convert.ToDecimal(reader["Price"])
            };
        }

        private static void AddProductParameters(SqlCommand command, Product product)
        {
            command.Parameters.Add("@ProductName", SqlDbType.VarChar, 100).Value = product.ProductName;
            command.Parameters.Add("@Quantity", SqlDbType.Int).Value = product.Quantity;
            var priceParameter = command.Parameters.Add("@Price", SqlDbType.Decimal);
            priceParameter.Precision = 10;
            priceParameter.Scale = 2;
            priceParameter.Value = product.Price;
        }
    }
}