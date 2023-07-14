Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE217539FF
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHCL-0004Ep-57; Fri, 14 Jul 2023 07:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAL-0002gG-Ac; Fri, 14 Jul 2023 07:40:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKHAE-0004fs-M6; Fri, 14 Jul 2023 07:40:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2403B13DA6;
 Fri, 14 Jul 2023 14:38:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1949214BB5;
 Fri, 14 Jul 2023 14:38:43 +0300 (MSK)
Received: (nullmailer pid 1186274 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 26/29] tree-wide spelling fixes in comments and some
 messages: scripts/
Date: Fri, 14 Jul 2023 14:38:31 +0300
Message-Id: <20230714113834.1186117-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/checkpatch.pl                             | 4 ++--
 scripts/ci/gitlab-pipeline-status                 | 2 +-
 scripts/codeconverter/codeconverter/qom_macros.py | 2 +-
 scripts/oss-fuzz/minimize_qtest_trace.py          | 8 ++++----
 scripts/performance/topN_callgrind.py             | 2 +-
 scripts/performance/topN_perf.py                  | 2 +-
 scripts/qapi/gen.py                               | 2 +-
 scripts/qapi/pylintrc                             | 2 +-
 scripts/replay-dump.py                            | 2 +-
 scripts/simplebench/bench_block_job.py            | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eeaec436eb..2dda08a859 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1623,3 +1623,3 @@ sub process {
 
-				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
+				# don't consider groups split by [.:/ ], like 2A.20:12ab
 				my $tmpline = $rawline;
@@ -2031,3 +2031,3 @@ sub process {
 		if ($line =~ /\bstatic\s.*=\s*(0|NULL|false)\s*;/) {
-			ERROR("do not initialise statics to 0 or NULL\n" .
+			ERROR("do not initialise statistics to 0 or NULL\n" .
 				$herecurr);
diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 924db327ff..e3343b0510 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -30,3 +30,3 @@ class CommunicationFailure(Exception):
 class NoPipelineFound(Exception):
-    """Communication is successfull but pipeline is not found."""
+    """Communication is successful but pipeline is not found."""
 
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
index 2d2f2055a3..2b0c8224a1 100644
--- a/scripts/codeconverter/codeconverter/qom_macros.py
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -144,3 +144,3 @@ def make_structname(self) -> str:
     def strip_typedef(self) -> Patch:
-        """generate patch that will strip typedef from the struct declartion
+        """generate patch that will strip typedef from the struct declaration
 
diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
index 20825768c2..d1f3990c16 100755
--- a/scripts/oss-fuzz/minimize_qtest_trace.py
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -4,3 +4,3 @@
 """
-This takes a crashing qtest trace and tries to remove superflous operations
+This takes a crashing qtest trace and tries to remove superfluous operations
 """
@@ -40,3 +40,3 @@ def usage():
 -M1: enable a loop around the remove minimizer, which may help decrease some
-     timing dependant instructions. Off by default.
+     timing dependent instructions. Off by default.
 -M2: try setting bits in operand of write/out to zero. Off by default.
@@ -179,3 +179,3 @@ def remove_lines(newtrace, outpath):
         # to the right side, then add one to n, until length/2^n == 0. The idea
-        # is to prune unneccessary bytes from long writes, while accommodating
+        # is to prune unnecessary bytes from long writes, while accommodating
         # arbitrary MemoryRegion access sizes and alignments.
@@ -294,3 +294,3 @@ def minimize_trace(inpath, outpath):
         old_len = len(newtrace)
-        print("trace lenth = ", old_len)
+        print("trace length = ", old_len)
         remove_lines(newtrace, outpath)
diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
index 67c59197af..f3f05fce55 100755
--- a/scripts/performance/topN_callgrind.py
+++ b/scripts/performance/topN_callgrind.py
@@ -6,3 +6,3 @@
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
index 07be195fc8..7b19e6a742 100755
--- a/scripts/performance/topN_perf.py
+++ b/scripts/performance/topN_perf.py
@@ -6,3 +6,3 @@
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 70bc576a10..bf5716b5f3 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -83,3 +83,3 @@ def write(self, output_dir: str) -> None:
 
-        # use os.open for O_CREAT to create and read a non-existant file
+        # use os.open for O_CREAT to create and read a non-existent file
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
index 90546df534..7f9686e578 100644
--- a/scripts/qapi/pylintrc
+++ b/scripts/qapi/pylintrc
@@ -13,3 +13,3 @@ ignore-patterns=schema.py,
 # file where it should appear only once). You can also use "--disable=all" to
-# disable everything first and then reenable specific checks. For example, if
+# disable everything first and then re-enable specific checks. For example, if
 # you want to run only the similarities checker, you can use "--disable=all
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 3ba97a6d30..b89dc29555 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -113,3 +113,3 @@ def print_event(eid, name, string=None, event_count=None):
 def decode_unimp(eid, name, _unused_dumpfile):
-    "Unimplimented decoder, will trigger exit"
+    "Unimplemented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 56191db44b..e575a3af10 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -41,3 +41,3 @@ def bench_block_job(cmd, cmd_args, qemu_args):
     Returns {'seconds': int} on success and {'error': str} on failure, dict may
-    contain addional 'vm-log' field. Return value is compatible with
+    contain additional 'vm-log' field. Return value is compatible with
     simplebench lib.
-- 
2.39.2


