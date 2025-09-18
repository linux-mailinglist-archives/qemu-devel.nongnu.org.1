Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC6B32E4A
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Aug 2025 10:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uq6IH-0006fU-AA; Sun, 24 Aug 2025 04:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uq6IC-0006f7-Li; Sun, 24 Aug 2025 04:41:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uq6IA-0004Cu-JC; Sun, 24 Aug 2025 04:41:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB46F1495AE;
 Sun, 24 Aug 2025 11:41:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21DA3267774;
 Sun, 24 Aug 2025 11:41:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial] block/curl: drop old/unuspported curl version checks
Date: Sun, 24 Aug 2025 11:41:24 +0300
Message-ID: <20250824084127.2016645-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We currently require libcurl >=7.29.0.  Drop older LIBCURL_VERSION_NUM
checks from the driver.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/curl.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 00b949ea45..444f258ea3 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -516,7 +516,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
                              CURLOPT_REDIR_PROTOCOLS_STR, PROTOCOLS)) {
             goto err;
         }
-#elif LIBCURL_VERSION_NUM >= 0x071304
+#else
         if (curl_easy_setopt(state->curl, CURLOPT_PROTOCOLS, PROTOCOLS) ||
             curl_easy_setopt(state->curl, CURLOPT_REDIR_PROTOCOLS, PROTOCOLS)) {
             goto err;
@@ -821,22 +821,11 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 #endif
-    /* Prior CURL 7.19.4 return value of 0 could mean that the file size is not
-     * know or the size is zero. From 7.19.4 CURL returns -1 if size is not
-     * known and zero if it is really zero-length file. */
-#if LIBCURL_VERSION_NUM >= 0x071304
-    if (cl < 0) {
-        pstrcpy(state->errmsg, CURL_ERROR_SIZE,
-                "Server didn't report file size.");
-        goto out;
-    }
-#else
     if (cl <= 0) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
                 "Unknown file size or zero-length file.");
         goto out;
     }
-#endif
 
     s->len = cl;
 
-- 
2.47.2


