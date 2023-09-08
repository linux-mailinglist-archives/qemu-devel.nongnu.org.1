Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F379854E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYE3-00077j-Q4; Fri, 08 Sep 2023 05:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYE1-00075V-Cg; Fri, 08 Sep 2023 05:56:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDv-0006l7-FD; Fri, 08 Sep 2023 05:56:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4657200D0;
 Fri,  8 Sep 2023 12:56:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9C45E26916;
 Fri,  8 Sep 2023 12:55:57 +0300 (MSK)
Received: (nullmailer pid 275964 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/23] scripts/: spelling fixes
Date: Fri,  8 Sep 2023 12:55:05 +0300
Message-Id: <20230908095520.275866-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/checkpatch.pl                             | 2 +-
 scripts/ci/gitlab-pipeline-status                 | 2 +-
 scripts/codeconverter/codeconverter/qom_macros.py | 2 +-
 scripts/oss-fuzz/minimize_qtest_trace.py          | 8 ++++----
 scripts/performance/topN_callgrind.py             | 2 +-
 scripts/performance/topN_perf.py                  | 2 +-
 scripts/qapi/gen.py                               | 2 +-
 scripts/replay-dump.py                            | 2 +-
 scripts/simplebench/bench_block_job.py            | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eeaec436eb..1ad9ccb74b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1621,7 +1621,7 @@ sub process {
 				my $hex =
 					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
 
-				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
+				# don't consider groups split by [.:/ ], like 2A.20:12ab
 				my $tmpline = $rawline;
 				$tmpline =~ s/($hex[.:\/ ])+$hex//g;
 
diff --git a/scripts/ci/gitlab-pipeline-status b/scripts/ci/gitlab-pipeline-status
index 924db327ff..e3343b0510 100755
--- a/scripts/ci/gitlab-pipeline-status
+++ b/scripts/ci/gitlab-pipeline-status
@@ -28,7 +28,7 @@ class CommunicationFailure(Exception):
 
 
 class NoPipelineFound(Exception):
-    """Communication is successfull but pipeline is not found."""
+    """Communication is successful but pipeline is not found."""
 
 
 def get_local_branch_commit(branch):
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
index 2d2f2055a3..2b0c8224a1 100644
--- a/scripts/codeconverter/codeconverter/qom_macros.py
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -142,7 +142,7 @@ def make_structname(self) -> str:
         return name
 
     def strip_typedef(self) -> Patch:
-        """generate patch that will strip typedef from the struct declartion
+        """generate patch that will strip typedef from the struct declaration
 
         The caller is responsible for readding the typedef somewhere else.
         """
diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
index 20825768c2..d1f3990c16 100755
--- a/scripts/oss-fuzz/minimize_qtest_trace.py
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -2,7 +2,7 @@
 # -*- coding: utf-8 -*-
 
 """
-This takes a crashing qtest trace and tries to remove superflous operations
+This takes a crashing qtest trace and tries to remove superfluous operations
 """
 
 import sys
@@ -38,7 +38,7 @@ def usage():
 Options:
 
 -M1: enable a loop around the remove minimizer, which may help decrease some
-     timing dependant instructions. Off by default.
+     timing dependent instructions. Off by default.
 -M2: try setting bits in operand of write/out to zero. Off by default.
 
 """.format((sys.argv[0])))
@@ -177,7 +177,7 @@ def remove_lines(newtrace, outpath):
         # it into two separate write commands. If splitting the data operand
         # from length/2^n bytes to the left does not work, try to move the pivot
         # to the right side, then add one to n, until length/2^n == 0. The idea
-        # is to prune unneccessary bytes from long writes, while accommodating
+        # is to prune unnecessary bytes from long writes, while accommodating
         # arbitrary MemoryRegion access sizes and alignments.
 
         # This algorithm will fail under some rare situations.
@@ -292,7 +292,7 @@ def minimize_trace(inpath, outpath):
     old_len = len(newtrace) + 1
     while(old_len > len(newtrace)):
         old_len = len(newtrace)
-        print("trace lenth = ", old_len)
+        print("trace length = ", old_len)
         remove_lines(newtrace, outpath)
         if not M1 and not M2:
             break
diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
index 67c59197af..f3f05fce55 100755
--- a/scripts/performance/topN_callgrind.py
+++ b/scripts/performance/topN_callgrind.py
@@ -4,7 +4,7 @@
 #  Syntax:
 #  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
 #  [-h] - Print the script arguments help message.
 #  [-n] - Specify the number of top functions to print.
diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
index 07be195fc8..7b19e6a742 100755
--- a/scripts/performance/topN_perf.py
+++ b/scripts/performance/topN_perf.py
@@ -4,7 +4,7 @@
 #  Syntax:
 #  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
 #           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
+#           <target executable> [<target executable options>]
 #
 #  [-h] - Print the script arguments help message.
 #  [-n] - Specify the number of top functions to print.
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 70bc576a10..bf5716b5f3 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -81,7 +81,7 @@ def write(self, output_dir: str) -> None:
         if odir:
             os.makedirs(odir, exist_ok=True)
 
-        # use os.open for O_CREAT to create and read a non-existant file
+        # use os.open for O_CREAT to create and read a non-existent file
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
         with os.fdopen(fd, 'r+', encoding='utf-8') as fp:
             text = self.get_content()
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 3ba97a6d30..b89dc29555 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -111,7 +111,7 @@ def print_event(eid, name, string=None, event_count=None):
 # Decoders for each event type
 
 def decode_unimp(eid, name, _unused_dumpfile):
-    "Unimplimented decoder, will trigger exit"
+    "Unimplemented decoder, will trigger exit"
     print("%s not handled - will now stop" % (name))
     return False
 
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index 56191db44b..e575a3af10 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -39,7 +39,7 @@ def bench_block_job(cmd, cmd_args, qemu_args):
                  binary
 
     Returns {'seconds': int} on success and {'error': str} on failure, dict may
-    contain addional 'vm-log' field. Return value is compatible with
+    contain additional 'vm-log' field. Return value is compatible with
     simplebench lib.
     """
 
-- 
2.39.2


