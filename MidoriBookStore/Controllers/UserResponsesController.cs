using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MidoriBookStore.Models;

namespace MidoriBookStore.Controllers
{
    public class UserResponsesController : Controller
    {
        private BookStoreDBEntities db = new BookStoreDBEntities();

        // GET: UserResponses
        public ActionResult Index()
        {
            var userResponses = db.UserResponses.Include(u => u.User);
            return View(userResponses.ToList());
        }

        // GET: UserResponses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserResponse userResponse = db.UserResponses.Find(id);
            if (userResponse == null)
            {
                return HttpNotFound();
            }
            return View(userResponse);
        }

        // GET: UserResponses/Create
        public ActionResult Create()
        {
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username");
            return View();
        }

        // POST: UserResponses/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ResponseID,UserID,Username,Title,Email,Contents,IsActive,Reply")] UserResponse userResponse)
        {
            if (ModelState.IsValid)
            {
                db.UserResponses.Add(userResponse);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", userResponse.UserID);
            return View(userResponse);
        }

        // GET: UserResponses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserResponse userResponse = db.UserResponses.Find(id);
            if (userResponse == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", userResponse.UserID);
            return View(userResponse);
        }

        // POST: UserResponses/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ResponseID,UserID,Username,Title,Email,Contents,IsActive,Reply")] UserResponse userResponse)
        {
            if (ModelState.IsValid)
            {
                db.Entry(userResponse).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", userResponse.UserID);
            return View(userResponse);
        }

        // GET: UserResponses/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            UserResponse userResponse = db.UserResponses.Find(id);
            if (userResponse == null)
            {
                return HttpNotFound();
            }
            return View(userResponse);
        }

        // POST: UserResponses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            UserResponse userResponse = db.UserResponses.Find(id);
            db.UserResponses.Remove(userResponse);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
