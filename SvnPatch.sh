# get SvnRevision first
SvnRevisionOneLine=$(git svn log --oneline -1)
SvnRevision=${SvnRevisionOneLine%% *}
#echo "${SvnRevision#r}"
# --cached for staged files
# with prefix to sure
git diff --cached | sed -e "s/^diff --git a/d" -e "s/^index[ ]\w\{7\}[.][.]\w\{7\}/d" -e  "/^--- a/ s|$|	(revision ${SvnRevision#r})|" 's|^--- a/|--- |' -e '/^+++ b/ s/$/	(working copy)/' 's|^+++ b/|+++ |' > patch.diff.svn
