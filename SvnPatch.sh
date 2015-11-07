# get SvnRevision first
SvnRevisionOneLine=$(git svn log --oneline -1)
SvnRevision=${SvnRevisionOneLine%% *}
#echo "${SvnRevision#r}"
# --cached for staged files
# with prefix to sure
git diff --cached | sed -e "/^diff --git a/d" -e "/^index[ ]\w\{7\}[.][.]\w\{7\}/d" -e  "/^--- a/ s|$|	(revision ${SvnRevision#r})|" -e 's|^--- a/|--- |' -e '/^+++ b/ s/$/	(working copy)/' -e 's|^+++ b/|+++ |' > patch.diff.svn
