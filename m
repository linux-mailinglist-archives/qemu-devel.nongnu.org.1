Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30274AC9BEE
	for <lists+qemu-devel@lfdr.de>; Sat, 31 May 2025 19:19:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPp8-00018A-SP; Sat, 31 May 2025 13:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPod-00015U-SZ; Sat, 31 May 2025 13:16:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPob-000117-R9; Sat, 31 May 2025 13:16:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B31AD126B31;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8B4FE21BA34;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 01/27] qemu-img: measure: convert img_size to signed,
 simplify handling
Date: Sat, 31 May 2025 20:15:43 +0300
Message-Id: <20250531171609.197078-2-mjt@tls.msk.ru>
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

qemu_opt_set_number() expects signed int64_t.

Use int64_t instead of uint64_t for img_size, use -1 as "unset"
value instead of UINT64_MAX, and do not require temporary sval
for conversion from string.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 139eeb5039..ec0f1152df 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5368,7 +5368,7 @@ static int img_measure(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     QemuOptsList *create_opts = NULL;
     bool image_opts = false;
-    uint64_t img_size = UINT64_MAX;
+    int64_t img_size = -1;
     BlockMeasureInfo *info = NULL;
     Error *local_err = NULL;
     int ret = 1;
@@ -5426,16 +5426,11 @@ static int img_measure(int argc, char **argv)
             }
             break;
         case OPTION_SIZE:
-        {
-            int64_t sval;
-
-            sval = cvtnum("image size", optarg);
-            if (sval < 0) {
+            img_size = cvtnum("image size", optarg);
+            if (img_size < 0) {
                 goto out;
             }
-            img_size = (uint64_t)sval;
-        }
-        break;
+            break;
         }
     }
 
@@ -5450,11 +5445,11 @@ static int img_measure(int argc, char **argv)
         error_report("--image-opts, -f, and -l require a filename argument.");
         goto out;
     }
-    if (filename && img_size != UINT64_MAX) {
+    if (filename && img_size != -1) {
         error_report("--size N cannot be used together with a filename.");
         goto out;
     }
-    if (!filename && img_size == UINT64_MAX) {
+    if (!filename && img_size == -1) {
         error_report("Either --size N or one filename must be specified.");
         goto out;
     }
@@ -5502,7 +5497,7 @@ static int img_measure(int argc, char **argv)
             goto out;
         }
     }
-    if (img_size != UINT64_MAX) {
+    if (img_size != -1) {
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
     }
 
-- 
2.39.5


