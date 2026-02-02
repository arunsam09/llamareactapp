1. Start

Function starts (e.g. build_context_and_support())

2. Iterate search results

Loop over search results

For each result:

idx = chunk index

file_name = source document name

3. Extract figure metadata

Call process_figures_metadata(figures, file_name)

Normalize:

image_url

caption

page_number

chunk_index (idx)

filename

4. Deduplicate images per chunk

Call deduplicate_images(images, idx)

Remove duplicate images within the same chunk

5. Store images per chunk

Save result as:

images_by_idx[idx] = unique_images

6. Collect global image candidates

Append each unique image to:

all_image_candidates

Build:

candidate_key_map (image key → index in candidates)

7. Check for image candidates

Decision: Are there any image candidates?

If NO:

Set:

image_ranked_indices = []

Skip LLM ranking

If YES:

Proceed to ranking

8. Build ranking prompt

Create prompt using:

user query

image captions + metadata

9. Call LLM for image ranking

LLM returns ranked image indices (best → worst)

10. Validate ranking result

Decision: Is LLM output valid?

If YES:

Use returned ranked indices

If NO:

Apply fallback:

image_ranked_indices = first 5 indices

(max_fallback = 5)

11. Clean ranked indices

Remove:

duplicates

out-of-range indices

Convert to:

ranked_index_set

12. Compute relevant chunks

For each ranked image:

Get its chunk_index

Build:

relevant_chunks set

13. Check relevant chunks

Decision: Are relevant chunks empty?

If YES:

Default:

relevant_chunks = {0}

If NO:

Use detected chunks

14. Collect figures for relevant chunks

From images_by_idx

Collect images belonging to relevant_chunks

15. Deduplicate figures globally

Remove duplicate figures across chunks

16. Build context text

Join text of relevant chunks

Truncate if token limit exceeded

17. Build context_with_figures

Combine:

chunk text

inline figure references

18. Build supporting_content

Include:

ranked images

captions

filenames

page numbers

19. Return

Return:

context_with_figures

supporting_content
