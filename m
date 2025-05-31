Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB8BAC9BE8
	for <lists+qemu-devel@lfdr.de>; Sat, 31 May 2025 19:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpH-0001DV-RA; Sat, 31 May 2025 13:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPok-000187-S6; Sat, 31 May 2025 13:16:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPoi-000125-Io; Sat, 31 May 2025 13:16:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D66C3126B34;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A48DD21BA37;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 04/27] qemu-img: pass current cmd info into command handlers
Date: Sat, 31 May 2025 20:15:46 +0300
Message-Id: <20250531171609.197078-5-mjt@tls.msk.ru>
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

This info will be used to generate --help output.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 4ece594360..7e3350bb38 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -60,7 +60,7 @@
 
 typedef struct img_cmd_t {
     const char *name;
-    int (*handler)(int argc, char **argv);
+    int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
 } img_cmd_t;
 
 enum {
@@ -514,7 +514,7 @@ static int64_t cvtnum(const char *name, const char *value)
     return cvtnum_full(name, value, 0, INT64_MAX);
 }
 
-static int img_create(int argc, char **argv)
+static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     int64_t img_size = -1;
@@ -719,7 +719,7 @@ static int collect_image_check(BlockDriverState *bs,
  *  3 - Check completed, image has leaked clusters, but is good otherwise
  * 63 - Checks are not supported by the image format
  */
-static int img_check(int argc, char **argv)
+static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -951,7 +951,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     }
 }
 
-static int img_commit(int argc, char **argv)
+static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret, flags;
     const char *filename, *fmt, *cache, *base;
@@ -1358,7 +1358,7 @@ static int check_empty_sectors(BlockBackend *blk, int64_t offset,
  * 1 - Images differ
  * >1 - Error occurred
  */
-static int img_compare(int argc, char **argv)
+static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
 {
     const char *fmt1 = NULL, *fmt2 = NULL, *cache, *filename1, *filename2;
     BlockBackend *blk1, *blk2;
@@ -2234,7 +2234,7 @@ static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
     blk_set_io_limits(blk, &cfg);
 }
 
-static int img_convert(int argc, char **argv)
+static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = BDRV_O_NO_SHARE;
     const char *fmt = NULL, *out_fmt = NULL, *cache = "unsafe",
@@ -3002,7 +3002,7 @@ err:
     return NULL;
 }
 
-static int img_info(int argc, char **argv)
+static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3227,7 +3227,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     return true;
 }
 
-static int img_map(int argc, char **argv)
+static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3376,7 +3376,7 @@ out:
 #define SNAPSHOT_APPLY  3
 #define SNAPSHOT_DELETE 4
 
-static int img_snapshot(int argc, char **argv)
+static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -3534,7 +3534,7 @@ static int img_snapshot(int argc, char **argv)
     return 0;
 }
 
-static int img_rebase(int argc, char **argv)
+static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
@@ -4028,7 +4028,7 @@ out:
     return 0;
 }
 
-static int img_resize(int argc, char **argv)
+static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
@@ -4241,7 +4241,7 @@ static int print_amend_option_help(const char *format)
     return 0;
 }
 
-static int img_amend(int argc, char **argv)
+static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 0;
@@ -4509,7 +4509,7 @@ static void bench_cb(void *opaque, int ret)
     }
 }
 
-static int img_bench(int argc, char **argv)
+static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret = 0;
     const char *fmt = NULL, *filename;
@@ -4779,7 +4779,7 @@ typedef struct ImgBitmapAction {
     QSIMPLEQ_ENTRY(ImgBitmapAction) next;
 } ImgBitmapAction;
 
-static int img_bitmap(int argc, char **argv)
+static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 1;
@@ -5079,7 +5079,7 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
 
-static int img_dd(int argc, char **argv)
+static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int ret = 0;
     char *arg = NULL;
@@ -5347,7 +5347,7 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
     g_string_free(str, true);
 }
 
-static int img_measure(int argc, char **argv)
+static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 {
     static const struct option long_options[] = {
         {"help", no_argument, 0, 'h'},
@@ -5614,7 +5614,7 @@ int main(int argc, char **argv)
             argc -= optind;
             qemu_reset_optind();
             argv[0] = argv0;
-            return cmd->handler(argc, argv);
+            return cmd->handler(cmd, argc, argv);
         }
     }
 
-- 
2.39.5


