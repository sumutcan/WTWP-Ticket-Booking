using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data.EntityClient;
using System.Configuration;
using TicketBooking;

namespace DataLayer
{
    public class DBConnection
    {
        string providerName = "System.Data.SqlClient";
        string serverName = ".";
        string databaseName = "CINECLUP";
        private CINECLUPEntities entity;
        public DBConnection()
        {
            // Specify the provider name, server and database.

            // Initialize the connection string builder for the
            // underlying provider.
            SqlConnectionStringBuilder sqlBuilder =
                new SqlConnectionStringBuilder();

            // Set the properties for the data source.
            sqlBuilder.DataSource = serverName;
            sqlBuilder.InitialCatalog = databaseName;
            sqlBuilder.IntegratedSecurity = true;

            // Build the SqlConnection connection string.
            string providerString = sqlBuilder.ToString();

            // Initialize the EntityConnectionStringBuilder.
            EntityConnectionStringBuilder entityBuilder =
                new EntityConnectionStringBuilder();

            //Set the provider name.
            entityBuilder.Provider = providerName;

            // Set the provider-specific connection string.
            entityBuilder.ProviderConnectionString = providerString;

            // Set the Metadata location.
            entityBuilder.Metadata = @"metadata=res://*/CINECLUP.csdl|res://*/CINECLUP.ssdl|res://*/CINECLUP.msl";



            entity = new CINECLUPEntities(entityBuilder.ToString());
        }
        public CINECLUPEntities ConnectDB
        {
            get
            {
                return entity;
            }
        }

    }
}
