def iff(condition, trueVal, falseVal):
    if condition:
        return trueVal
    else:
        return falseVal


# Constants
start = 1
end = 100000
num_bins = 20

# Calculating the base of the logarithm
log_base = (end / start) ** (1 / num_bins)

# Calculating the bin edges
bin_edges = []
for i in range(num_bins + 1):
    bin_edges.append(start * log_base**i)

# print(bin_edges, "========================================")

# Rounding the bin edges to the nearest integer
bin_edges_int = [int(round(edge)) for edge in bin_edges]

print(bin_edges_int)

# # Adjusting for any potential overlaps or gaps due to rounding
# bin_edges_norm = [bin_edges_int[0]]
# for i in range(1, len(bin_edges_int) - 1):
#     # To avoid overlap, start the next bin where the previous one ended
#     next_edge = max(bin_edges_int[i], bin_edges_norm[-1] + 1)
#     bin_edges_norm.append(next_edge)

# # Ensuring the last bin edge is the end of the range
# bin_edges_norm.append(end)

# # print(bin_edges_norm, "========================================")

# # Write SQL query for binning

# sql = """-- Code was generated with a Python script
# WITH CommitRanges AS (
#   SELECT 1 AS "Position", '1' AS "Range" UNION ALL
# """

# for i in range(1, len(bin_edges_norm) - 1):
#     from_val = str(bin_edges_norm[i])
#     to_val = str(bin_edges_norm[i + 1] - 1)
#     sql += (
#         "  SELECT "
#         + str(i + 1)
#         + ", '"
#         + from_val
#         + iff(from_val != to_val, "-" + to_val, "")
#         + "' UNION ALL\n"
#     )

# sql += "  SELECT " + str(len(bin_edges_norm)) + ", '" + str(end) + "+'\n)"
# sql += """
# SELECT
#   cr."Position",
#   cr."Range" AS "Commit Range",
#   COALESCE(COUNT(r.commits_count), 0) as "Number of Repos"
# FROM
#   CommitRanges cr
# LEFT JOIN
#   repos r ON cr."Position" = CASE
#     WHEN r.commits_count == 1 THEN 1
# """

# for i in range(len(bin_edges_norm) - 2):
#     sql += (
#         "    WHEN r.commits_count <= "
#         + str(bin_edges_norm[i + 2] - 1)
#         + " THEN "
#         + str(i + 2)
#         + "\n"
#     )

# sql += "    ELSE " + str(len(bin_edges_norm))
# sql += """
#   END
# GROUP BY cr."Range"
# ORDER BY cr."Position"
# """

# print(sql)
