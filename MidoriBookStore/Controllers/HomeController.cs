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
    public class HomeController : Controller
    {
        private BookStoreDBEntities1 db = new BookStoreDBEntities1();

        // GET: Home
        public ActionResult Index()
        {
            var books = db.Books.Include(b => b.Author).Include(b => b.Publisher);
            return View(books.ToList());
        }

        // GET: Home/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return View("Index", db);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            System.Diagnostics.Debug.WriteLine(book.BookID);
            ViewData["book"] = book;
            return View();
        }

        // GET: Home/Create
        public ActionResult Create()
        {
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName");
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName");
            return View();
        }

        // POST: Home/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BookID,PublisherID,AuthorID,BookTitle,Notes,BookPrice,BookType,Status,Url")] Book book)
        {
            if (ModelState.IsValid)
            {
                db.Books.Add(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // GET: Home/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // POST: Home/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BookID,PublisherID,AuthorID,BookTitle,Notes,BookPrice,BookType,Status,Url")] Book book)
        {
            if (ModelState.IsValid)
            {
                db.Entry(book).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // GET: Home/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }

        // POST: Home/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Book book = db.Books.Find(id);
            db.Books.Remove(book);
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

        public ActionResult Search(string searchString)
        {
            var books = from m in db.Books
                         select m;

            if (!String.IsNullOrEmpty(searchString))
            {
                books = books.Where(s => s.BookTitle.Contains(searchString));
            }

            return View(books);
        }

        public ActionResult About()
        {
            return View();
        }

    }
}
