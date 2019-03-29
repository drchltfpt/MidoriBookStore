using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MidoriBookStore.Models.AddToCart
{
    public class CartItem
    {

        private BookStoreDBEntities1 db = new BookStoreDBEntities1();

        public int BookId { get; set; }

        public int Quantity { get; set; }

        public Book GetBookById()
        {
            return db.Books.Find(BookId);
        }

        public double Total
        {
            get
            {
                return Convert.ToDouble(GetBookById().BookPrice * Quantity);
            }
            set { }
        }

        public System.DateTime DateCreated { get; set; }

        public CartItem(int bookId)
        {
            BookId = bookId;
            Quantity = 1;
        }

        public override bool Equals(object obj)
        {
            CartItem ci = (CartItem)obj;
            return BookId.Equals(ci.BookId);
        }

    }
}