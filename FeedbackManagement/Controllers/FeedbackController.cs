using System.Collections.Generic;
using System.Web.Mvc;
using FeedbackManagement.Models;

namespace FeedbackManagement.Controllers
{
    public class FeedbackController : Controller
    {
        private static readonly List<Feedback> feedbackList = new List<Feedback>();
        private static int nextId = 1;

        public ActionResult Index()
        {
            return View(feedbackList);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View(new Feedback());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Feedback feedback)
        {
            if (ModelState.IsValid)
            {
                feedback.Id = nextId++;
                feedbackList.Add(feedback);

                TempData["Message"] = "Feedback submitted successfully!";
                return RedirectToAction("Index");
            }

            return View(feedback);
        }
    }
}
