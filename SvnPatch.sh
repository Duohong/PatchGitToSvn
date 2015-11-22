# get SvnRevision first
SvnRevision=$(git svn find-rev $(git rev-parse head))
#echo "${SvnRevision}"
# --cached for staged files
# with prefix to sure
git diff --cached | sed -e "/^diff --git a/d" -e "/^index[ ]\w\{7\}[.][.]\w\{7\}/d" -e  "/^--- a/ s|$|	(revision ${SvnRevision})|" -e 's|^--- a/|--- |' -e '/^+++ b/ s/$/	(working copy)/' -e 's|^+++ b/|+++ |' > patch.diff.svn
