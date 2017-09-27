using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Collections.ObjectModel;
using System.Linq;
using System.Xml.Serialization;
using System.IO;
using System.Text;
using System.Collections;

namespace SQLAggregateFunctions
{
    [System.Serializable]
    [Microsoft.SqlServer.Server.SqlUserDefinedAggregate(
       Microsoft.SqlServer.Server.Format.UserDefined,
       IsInvariantToDuplicates = false, // receiving the same value again changes the result
       IsInvariantToNulls = false,      // receiving a NULL value changes the result
       IsInvariantToOrder = true,       // the order of the values doesn't affect the result
       IsNullIfEmpty = true,            // if no values are given the result is null
       MaxByteSize = -1,
       Name = "MostCommon"              // name of the aggregate
    )]
    public struct MostCommon : IBinarySerialize
    {
        private Collection<string> pool;
        private string result;
        private int count;

        public void Init()
        {
            pool = new Collection<string>();
            result = string.Empty;
            count = -1;
        }
        public void Accumulate(string value)
        {
            if (null != value)
            {
                pool.Add(value.ToString());
            }
        }
        public void Merge(MostCommon group)
        {
            if (null != group.pool && group.pool.Count > 0)
            {
                foreach (string entry in group.pool)
                {
                    pool.Add(entry);
                }
            }
        }
        public SqlString Terminate()
        {
            string[] distinctValues = pool.Distinct().ToArray();

            foreach (string distinctValue in distinctValues)
            {
                int tempCount = pool.Count(s => s.Equals(distinctValue, StringComparison.OrdinalIgnoreCase));

                if (tempCount > count)
                {
                    count = tempCount;
                    result = distinctValue;
                }
            }

            return new SqlString(result.ToString());
        }

        #region IBinarySerialize Members
        public void Read(System.IO.BinaryReader reader)
        {
            this.result = reader.ReadString();
            this.count = reader.ReadInt32();
            int itemsCount = reader.ReadInt32();
            
            pool = new Collection<string>();

            for (int i = 0; i < itemsCount; i++)
	        {
	            this.pool.Add(reader.ReadString());
	        } 
        }
        public void Write(System.IO.BinaryWriter writer)
        {
            writer.Write(this.result);
            writer.Write(this.count);
            writer.Write(pool.Count);
            
            foreach (string entry in pool)
            {
                writer.Write(entry);
            } 
        }
        #endregion
    }
}