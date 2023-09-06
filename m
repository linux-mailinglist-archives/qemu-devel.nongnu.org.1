Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACE793E61
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtDz-0002dK-Cc; Wed, 06 Sep 2023 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdtDi-0002Te-Pw; Wed, 06 Sep 2023 10:09:27 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdtDe-0000fK-KT; Wed, 06 Sep 2023 10:09:26 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdtAX-006xz5-0H;
 Wed, 06 Sep 2023 16:09:08 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Date: Wed,  6 Sep 2023 16:09:17 +0200
Message-Id: <20230906140917.559129-4-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906140917.559129-1-den@openvz.org>
References: <20230906140917.559129-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Each particular testcase could skipped intentionally and accidentally.
For example the test is not designed for a particular image format or
is not run due to the missed library.

The latter case is unwanted in reality. Though the discussion has
revealed that failing the test in such a case would be bad. Thus the
patch tries to do different thing. It adds additional status for
the test case - 'skipped' and bound intentinal cases to that state.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/common.rc     | 23 ++++++++++++++++-------
 tests/qemu-iotests/iotests.py    | 19 +++++++++++++++----
 tests/qemu-iotests/testrunner.py | 17 +++++++++++++++--
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd..74f64e8af8 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -37,6 +37,15 @@ _notrun()
     exit
 }
 
+# bail out, setting up .skip file
+_skip()
+{
+    echo "$*" >"$TEST_DIR/$seq.skip"
+    echo "$seq skipped: $*"
+    status=0
+    exit
+}
+
 if ! command -v gsed >/dev/null 2>&1; then
     if sed --version 2>&1 | grep -v 'not GNU sed' | grep 'GNU sed' > /dev/null;
     then
@@ -782,7 +791,7 @@ _supported_fmt()
         fi
     done
 
-    _notrun "not suitable for this image format: $IMGFMT"
+    _skip "not suitable for this image format: $IMGFMT"
 }
 
 # tests whether $IMGFMT is one of the unsupported image format for a test
@@ -791,7 +800,7 @@ _unsupported_fmt()
 {
     for f; do
         if [ "$f" = "$IMGFMT" ]; then
-            _notrun "not suitable for this image format: $IMGFMT"
+            _skip "not suitable for this image format: $IMGFMT"
         fi
     done
 }
@@ -806,7 +815,7 @@ _supported_proto()
         fi
     done
 
-    _notrun "not suitable for this image protocol: $IMGPROTO"
+    _skip "not suitable for this image protocol: $IMGPROTO"
 }
 
 # tests whether $IMGPROTO is specified as an unsupported image protocol for a test
@@ -815,7 +824,7 @@ _unsupported_proto()
 {
     for f; do
         if [ "$f" = "$IMGPROTO" ]; then
-            _notrun "not suitable for this image protocol: $IMGPROTO"
+            _skip "not suitable for this image protocol: $IMGPROTO"
             return
         fi
     done
@@ -843,7 +852,7 @@ _supported_cache_modes()
             return
         fi
     done
-    _notrun "not suitable for cache mode: $CACHEMODE"
+    _skip "not suitable for cache mode: $CACHEMODE"
 }
 
 # Check whether the filesystem supports O_DIRECT
@@ -895,7 +904,7 @@ _supported_aio_modes()
             return
         fi
     done
-    _notrun "not suitable for aio mode: $AIOMODE"
+    _skip "not suitable for aio mode: $AIOMODE"
 }
 _default_aio_mode()
 {
@@ -911,7 +920,7 @@ _unsupported_imgopts()
         # end of an option (\b or \> are not portable)
         if echo "$IMGOPTS " | grep -q 2>/dev/null "$bad_opt"
         then
-            _notrun "not suitable for image option: $bad_opt"
+            _skip "not suitable for image option: $bad_opt"
         fi
     done
 }
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ef66fbd62b..746772fab0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1353,6 +1353,17 @@ def notrun(reason):
     logger.warning("%s not run: %s", seq, reason)
     sys.exit(0)
 
+def skip(reason):
+    '''Skip this test suite for a purpose'''
+    # Each test in qemu-iotests has a number ("seq")
+    seq = os.path.basename(sys.argv[0])
+
+    with open('%s/%s.skip' % (test_dir, seq), 'w', encoding='utf-8') \
+            as outfile:
+        outfile.write(reason + '\n')
+    logger.warning("%s not run: %s", seq, reason)
+    sys.exit(0)
+
 def case_notrun(reason):
     '''Mark this test case as not having been run (without actually
     skipping it, that is left to the caller).  See
@@ -1377,7 +1388,7 @@ def _verify_image_format(supported_fmts: Sequence[str] = (),
 
     not_sup = supported_fmts and (imgfmt not in supported_fmts)
     if not_sup or (imgfmt in unsupported_fmts):
-        notrun('not suitable for this image format: %s' % imgfmt)
+        skip('not suitable for this image format: %s' % imgfmt)
 
     if imgfmt == 'luks':
         verify_working_luks()
@@ -1391,7 +1402,7 @@ def _verify_protocol(supported: Sequence[str] = (),
 
     not_sup = supported and (imgproto not in supported)
     if not_sup or (imgproto in unsupported):
-        notrun('not suitable for this protocol: %s' % imgproto)
+        skip('not suitable for this protocol: %s' % imgproto)
 
 def _verify_platform(supported: Sequence[str] = (),
                      unsupported: Sequence[str] = ()) -> None:
@@ -1404,11 +1415,11 @@ def _verify_platform(supported: Sequence[str] = (),
 
 def _verify_cache_mode(supported_cache_modes: Sequence[str] = ()) -> None:
     if supported_cache_modes and (cachemode not in supported_cache_modes):
-        notrun('not suitable for this cache mode: %s' % cachemode)
+        skip('not suitable for this cache mode: %s' % cachemode)
 
 def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
-        notrun('not suitable for this aio mode: %s' % aiomode)
+        skip('not suitable for this aio mode: %s' % aiomode)
 
 def _verify_formats(required_formats: Sequence[str] = ()) -> None:
     usf_list = list(set(required_formats) - set(supported_formats()))
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 7b322272e9..137dd6e06c 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -200,6 +200,8 @@ def test_print_one_line(self, test: str,
                 col = '\033[1m\033[31m'
             elif status == 'not run':
                 col = '\033[33m'
+            elif status == 'skipped':
+                col = '\033[34m'
             else:
                 col = ''
 
@@ -268,8 +270,9 @@ def do_run_test(self, test: str) -> TestResult:
         f_bad = Path(test_dir, f_test.name + '.out.bad')
         f_notrun = Path(test_dir, f_test.name + '.notrun')
         f_casenotrun = Path(test_dir, f_test.name + '.casenotrun')
+        f_skipped = Path(test_dir, f_test.name + '.skip')
 
-        for p in (f_notrun, f_casenotrun):
+        for p in (f_notrun, f_casenotrun, f_skipped):
             silent_unlink(p)
 
         t0 = time.time()
@@ -298,6 +301,10 @@ def do_run_test(self, test: str) -> TestResult:
             return TestResult(
                 status='not run',
                 description=f_notrun.read_text(encoding='utf-8').strip())
+        if f_skipped.exists():
+            return TestResult(
+                status='skipped',
+                description=f_skipped.read_text(encoding='utf-8').strip())
 
         casenotrun = ''
         if f_casenotrun.exists():
@@ -370,6 +377,7 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
         n_run = 0
         failed = []
         notrun = []
+        skipped = []
         casenotrun = []
 
         if self.tap:
@@ -392,7 +400,7 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
             else:
                 res = self.run_test(t, test_field_width)
 
-            assert res.status in ('pass', 'fail', 'not run')
+            assert res.status in ('pass', 'fail', 'not run', 'skipped')
 
             if res.casenotrun:
                 casenotrun.append(t)
@@ -409,6 +417,8 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
                         print('\n'.join(res.diff))
             elif res.status == 'not run':
                 notrun.append(name)
+            elif res.status == 'skipped':
+                skipped.append(name)
             elif res.status == 'pass':
                 assert res.elapsed is not None
                 self.last_elapsed.update(t, res.elapsed)
@@ -418,6 +428,9 @@ def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
                 break
 
         if not self.tap:
+            if skipped:
+                print('Skipped:', ' '.join(skipped))
+
             if notrun:
                 print('Not run:', ' '.join(notrun))
 
-- 
2.34.1


