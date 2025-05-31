Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FF8AC9BFD
	for <lists+qemu-devel@lfdr.de>; Sat, 31 May 2025 19:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPsl-0007oP-WD; Sat, 31 May 2025 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqs-0003ju-Uc; Sat, 31 May 2025 13:18:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqq-0001DU-2y; Sat, 31 May 2025 13:18:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E14DF126B4B;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AD2FF21BA4E;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 27/27] qemu-img: extend cvtnum() and use it in more places
Date: Sat, 31 May 2025 20:16:09 +0300
Message-Id: <20250531171609.197078-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531171609.197078-1-mjt@tls.msk.ru>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cvtnum() expects input string to specify some sort of size
(optionally with KMG... suffix).  However, there are a lot
of other number conversions in there (using qemu_strtol &Co),
also, not all conversions which use cvtnum, actually expects
size, - like dd count=nn.

Add bool issize argument to cvtnum() to specify if it should
treat the argument as a size or something else, - this changes
conversion routine in use and error text.

Use the new cvtnum() in more places (like where strtol were used),
since it never return negative number in successful conversion.
When it makes sense, also specify upper or lower bounds at the
same time.  This simplifies option processing in multiple places,
removing the need of local temporary variables and longer error
reporting code.

While at it, fix errors, like depth in measure must be >= 1,
while the previous code allowed it to be 0.

In a few places, change unsigned variables (like of type size_t)
to be signed instead, - to avoid the need of temporary conversion
variable.  All these variables are okay to be signed, we never
assign <0 value to them except of the cases of conversion error,
where we return immediately.

While at it, remove allowed size suffixes from the error message
as it makes no sense most of the time (should be in help instead).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c                 | 111 +++++++++++++------------------------
 tests/qemu-iotests/049.out |   9 +--
 2 files changed, 40 insertions(+), 80 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 18f7ba07c9..8925e14ba6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -399,18 +399,16 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
-static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
-                           int64_t max)
+static int64_t cvtnum_full(const char *name, const char *value,
+                           bool issize, int64_t min, int64_t max)
 {
     int err;
     uint64_t res;
 
-    err = qemu_strtosz(value, NULL, &res);
+    err = issize ? qemu_strtosz(value, NULL, &res) :
+                   qemu_strtou64(value, NULL, 0, &res);
     if (err < 0 && err != -ERANGE) {
-        error_report("Invalid %s specified. You may use "
-                     "k, M, G, T, P or E suffixes for", name);
-        error_report("kilobytes, megabytes, gigabytes, terabytes, "
-                     "petabytes and exabytes.");
+        error_report("Invalid %s specified: '%s'.", name, value);
         return err;
     }
     if (err == -ERANGE || res > max || res < min) {
@@ -421,9 +419,9 @@ static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
     return res;
 }
 
-static int64_t cvtnum(const char *name, const char *value)
+static int64_t cvtnum(const char *name, const char *value, bool issize)
 {
-    return cvtnum_full(name, value, 0, INT64_MAX);
+    return cvtnum_full(name, value, issize, 0, INT64_MAX);
 }
 
 static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
@@ -526,7 +524,7 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 
     /* Get image size, if specified */
     if (optind < argc) {
-        img_size = cvtnum("image size", argv[optind++]);
+        img_size = cvtnum("image size", argv[optind++], true);
         if (img_size < 0) {
             goto fail;
         }
@@ -985,7 +983,7 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
             drop = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 return 1;
             }
@@ -2426,7 +2424,7 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum("buffer size for sparse output", optarg);
+            sval = cvtnum("buffer size for sparse output", optarg, true);
             if (sval < 0) {
                 goto fail_getopt;
             } else if (!QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
@@ -2460,16 +2458,15 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 goto fail_getopt;
             }
             break;
         case 'm':
-            if (qemu_strtol(optarg, NULL, 0, &s.num_coroutines) ||
-                s.num_coroutines < 1 || s.num_coroutines > MAX_COROUTINES) {
-                error_report("Invalid number of coroutines. Allowed number of"
-                             " coroutines is between 1 and %d", MAX_COROUTINES);
+            s.num_coroutines = cvtnum_full("number of coroutines", optarg,
+                                           false, 1, MAX_COROUTINES);
+            if (s.num_coroutines < 0) {
                 goto fail_getopt;
             }
             break;
@@ -3374,13 +3371,13 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             image_opts = true;
             break;
         case 's':
-            start_offset = cvtnum("start offset", optarg);
+            start_offset = cvtnum("start offset", optarg, true);
             if (start_offset < 0) {
                 return 1;
             }
             break;
         case 'l':
-            max_length = cvtnum("max length", optarg);
+            max_length = cvtnum("max length", optarg, true);
             if (max_length < 0) {
                 return 1;
             }
@@ -4717,9 +4714,9 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
     int count = 75000;
     int depth = 64;
     int64_t offset = 0;
-    size_t bufsize = 4096;
+    ssize_t bufsize = 4096;
     int pattern = 0;
-    size_t step = 0;
+    ssize_t step = 0;
     int flush_interval = 0;
     bool drain_on_flush = true;
     int64_t image_size;
@@ -4824,27 +4821,17 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case 'c':
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
-                error_report("Invalid request count specified");
+            count = cvtnum_full("request count", optarg, false, 1, INT_MAX);
+            if (count < 0) {
                 return 1;
             }
-            count = res;
             break;
-        }
         case 'd':
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) <= 0 || res > INT_MAX) {
-                error_report("Invalid queue depth specified");
+            depth = cvtnum_full("queue depth", optarg, false, 1, INT_MAX);
+            if (depth < 0) {
                 return 1;
             }
-            depth = res;
             break;
-        }
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
             break;
@@ -4857,64 +4844,40 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case 'o':
-        {
-            offset = cvtnum("offset", optarg);
+            offset = cvtnum("offset", optarg, true);
             if (offset < 0) {
                 return 1;
             }
             break;
-        }
-            break;
         case 's':
-        {
-            int64_t sval;
-
-            sval = cvtnum_full("buffer size", optarg, 0, INT_MAX);
-            if (sval < 0) {
+            bufsize = cvtnum_full("buffer size", optarg, true, 1, INT_MAX);
+            if (bufsize < 0) {
                 return 1;
             }
-
-            bufsize = sval;
             break;
-        }
         case 'S':
-        {
-            int64_t sval;
-
-            sval = cvtnum_full("step_size", optarg, 0, INT_MAX);
-            if (sval < 0) {
+            step = cvtnum_full("step size", optarg, true, 0, INT_MAX);
+            if (step < 0) {
                 return 1;
             }
-
-            step = sval;
             break;
-        }
         case 'w':
             flags |= BDRV_O_RDWR;
             is_write = true;
             break;
         case OPTION_PATTERN:
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > 0xff) {
-                error_report("Invalid pattern byte specified");
+            pattern = cvtnum_full("pattern byte", optarg, false, 0, 0xff);
+            if (pattern < 0) {
                 return 1;
             }
-            pattern = res;
             break;
-        }
         case OPTION_FLUSH_INTERVAL:
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
-                error_report("Invalid flush interval specified");
+            flush_interval = cvtnum_full("flush interval", optarg,
+                                         false, 0, INT_MAX);
+            if (flush_interval < 0) {
                 return 1;
             }
-            flush_interval = res;
             break;
-        }
         case OPTION_NO_DRAIN:
             drain_on_flush = false;
             break;
@@ -5126,7 +5089,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             add = true;
             break;
         case 'g':
-            granularity = cvtnum("granularity", optarg);
+            granularity = cvtnum("granularity", optarg, true);
             if (granularity < 0) {
                 return 1;
             }
@@ -5311,7 +5274,7 @@ static int img_dd_bs(const char *arg,
 {
     int64_t res;
 
-    res = cvtnum_full("bs", arg, 1, INT_MAX);
+    res = cvtnum_full("bs", arg, true, 1, INT_MAX);
 
     if (res < 0) {
         return 1;
@@ -5325,7 +5288,7 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    dd->count = cvtnum("count", arg);
+    dd->count = cvtnum("count", arg, false);
 
     if (dd->count < 0) {
         return 1;
@@ -5356,7 +5319,7 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    in->offset = cvtnum("skip", arg);
+    in->offset = cvtnum("skip", arg, false);
 
     if (in->offset < 0) {
         return 1;
@@ -5764,7 +5727,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
             user_creatable_process_cmdline(optarg);
             break;
         case 's':
-            img_size = cvtnum("image size", optarg);
+            img_size = cvtnum("image size", optarg, true);
             if (img_size < 0) {
                 goto out;
             }
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 34e1b452e6..a7a7d5a96e 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -98,8 +98,7 @@ qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: '-1k'.
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
@@ -107,8 +106,7 @@ Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: '1kilobyte'.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
@@ -116,8 +114,7 @@ Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: 'foobar'.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
-- 
2.39.5


