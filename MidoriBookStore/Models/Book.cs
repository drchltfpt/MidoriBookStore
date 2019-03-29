//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MidoriBookStore.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Book
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Book()
        {
            this.OrderLines = new HashSet<OrderLine>();
        }
    
        public int BookID { get; set; }
        public Nullable<int> PublisherID { get; set; }
        public Nullable<int> AuthorID { get; set; }
        public string BookTitle { get; set; }
        public string Notes { get; set; }
        public decimal BookPrice { get; set; }
        public string BookType { get; set; }
        public Nullable<bool> Status { get; set; }
        public string Url { get; set; }
    
        public virtual Author Author { get; set; }
        public virtual Publisher Publisher { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderLine> OrderLines { get; set; }

       
    }
}
