using MidoriBookStore.Models.AddToCart;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MidoriBookStore.Controllers
{
    public class AddToCartController : Controller
    {
        // GET: AddToCart
        public ActionResult Index()
        {
            if (Session["Cart"] == null)
            {
                return View("~/Views/Shared/Error.cshtml");
            }

            ViewData["cart"] = (List<CartItem>)Session["Cart"];


            return View();
        }

        // GET: AddToCart/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: AddToCart/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: AddToCart/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: AddToCart/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: AddToCart/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: AddToCart/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: AddToCart/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
