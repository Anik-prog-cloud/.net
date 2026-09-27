using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using ProductCatalog.Models;

namespace ProductCatalog.Controllers
{
    public class ProductController : Controller
    {
        private static readonly List<Product> _products = new List<Product>
        {
            new Product { Id = 1, Name = "Laptop", Category = "Electronics", Price = 55000, Description = "High performance laptop" },
            new Product { Id = 2, Name = "Smartphone", Category = "Electronics", Price = 25000, Description = "Latest smartphone" },
            new Product { Id = 3, Name = "Headphones", Category = "Accessories", Price = 2000, Description = "Wireless headphones" },
            new Product { Id = 4, Name = "Keyboard", Category = "Accessories", Price = 1500, Description = "Mechanical keyboard" },
            new Product { Id = 5, Name = "Smart Watch", Category = "Wearables", Price = 5000, Description = "Modern smart watch" }
        };

        public ActionResult Index()
        {
            return View(_products);
        }

        public ActionResult Details(int id)
        {
            var product = _products.FirstOrDefault(p => p.Id == id);
            if (product == null)
                return HttpNotFound();

            return View(product);
        }
    }
}
