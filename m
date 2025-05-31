Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6EAC9BEB
	for <lists+qemu-devel@lfdr.de>; Sat, 31 May 2025 19:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPov-00017g-Jz; Sat, 31 May 2025 13:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPoh-00016Q-0h; Sat, 31 May 2025 13:16:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPof-00011e-BI; Sat, 31 May 2025 13:16:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD179126B32;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 92A5221BA35;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 02/27] qemu-img: create: convert img_size to signed,
 simplify handling
Date: Sat, 31 May 2025 20:15:44 +0300
Message-Id: <20250531171609.197078-3-mjt@tls.msk.ru>
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

Initializing an unsigned as -1, or using temporary
sval for conversion is awkward.  Since we don't allow
other "negative" values anyway, use signed value and
pass it to bdrv_img_create() (where it is properly
converted to unsigned), simplifying code.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ec0f1152df..974d31a4b3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -511,7 +511,7 @@ static int64_t cvtnum(const char *name, const char *value)
 static int img_create(int argc, char **argv)
 {
     int c;
-    uint64_t img_size = -1;
+    int64_t img_size = -1;
     const char *fmt = "raw";
     const char *base_fmt = NULL;
     const char *filename;
@@ -582,13 +582,10 @@ static int img_create(int argc, char **argv)
 
     /* Get image size, if specified */
     if (optind < argc) {
-        int64_t sval;
-
-        sval = cvtnum("image size", argv[optind++]);
-        if (sval < 0) {
+        img_size = cvtnum("image size", argv[optind++]);
+        if (img_size < 0) {
             goto fail;
         }
-        img_size = (uint64_t)sval;
     }
     if (optind != argc) {
         error_exit("Unexpected argument: %s", argv[optind]);
-- 
2.39.5


