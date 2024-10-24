Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007959ADC4E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 08:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3rRm-0002Jh-Sg; Thu, 24 Oct 2024 02:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRk-0002Is-SS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3rRi-0003Ru-Oj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729751746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ug8pvu8j9ZZmRgar7cJxXuiLWHOWL3pPlF+gILxlOxo=;
 b=eBuPLCbEeed9MzwIknGnIcJhnYwmtgD8mApW1M3GKmV044djS1sflhaZP7a7gDvzds6Lvh
 i2FaHZ+t3fbzGwJcX/JNQXPjNPJN9kUjdf4jsFfvFyaBcFQOxstl13btBtyl0jazeVDlgS
 R/2h6tN6O2Mbk2HH80jNmbrrpDgZy0E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-ruHVheMaNLegHnQShwuQSw-1; Thu,
 24 Oct 2024 02:35:40 -0400
X-MC-Unique: ruHVheMaNLegHnQShwuQSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 124E71955F3E; Thu, 24 Oct 2024 06:35:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74AFC1956056; Thu, 24 Oct 2024 06:35:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 09/17] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Date: Thu, 24 Oct 2024 08:34:59 +0200
Message-ID: <20241024063507.1585765-10-clg@redhat.com>
In-Reply-To: <20241024063507.1585765-1-clg@redhat.com>
References: <20241024063507.1585765-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
when in scatter-gather accumulative mode. A hash context will maintain a
"running-hash" as each scatter-gather chunk is received.

Previously each scatter-gather "chunk" was cached
so the hash could be computed once the final chunk was received.
However, the cache was a shallow copy, so once the guest overwrote the
memory provided to HACE the final hash would not be correct.

Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121
Buglink: https://github.com/openbmc/qemu/issues/36

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Checkpatch fixes
       - Reworked qcrypto_hash*() error reports in do_hash_operation() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/misc/aspeed_hace.h |   4 ++
 hw/misc/aspeed_hace.c         | 104 +++++++++++++++++++---------------
 2 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index ecb1b67de816..4af99191955a 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
@@ -10,6 +11,7 @@
 #define ASPEED_HACE_H
 
 #include "hw/sysbus.h"
+#include "crypto/hash.h"
 
 #define TYPE_ASPEED_HACE "aspeed.hace"
 #define TYPE_ASPEED_AST2400_HACE TYPE_ASPEED_HACE "-ast2400"
@@ -35,6 +37,8 @@ struct AspeedHACEState {
 
     MemoryRegion *dram_mr;
     AddressSpace dram_as;
+
+    QCryptoHash *hash_ctx;
 };
 
 
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index b6f43f65b29a..bc1d66ad8064 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * Joel Stanley <joel@jms.id.au>
@@ -151,49 +152,28 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
     return iov_count;
 }
 
-/**
- * Generate iov for accumulative mode.
- *
- * @param s             aspeed hace state object
- * @param iov           iov of the current request
- * @param id            index of the current iov
- * @param req_len       length of the current request
- *
- * @return count of iov
- */
-static int gen_acc_mode_iov(AspeedHACEState *s, struct iovec *iov, int id,
-                            hwaddr *req_len)
-{
-    uint32_t pad_offset;
-    uint32_t total_msg_len;
-    s->total_req_len += *req_len;
-
-    if (has_padding(s, &iov[id], *req_len, &total_msg_len, &pad_offset)) {
-        if (s->iov_count) {
-            return reconstruct_iov(s, iov, id, &pad_offset);
-        }
-
-        *req_len -= s->total_req_len - total_msg_len;
-        s->total_req_len = 0;
-        iov[id].iov_len = *req_len;
-    } else {
-        s->iov_cache[s->iov_count].iov_base = iov->iov_base;
-        s->iov_cache[s->iov_count].iov_len = *req_len;
-        ++s->iov_count;
-    }
-
-    return id + 1;
-}
-
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
     struct iovec iov[ASPEED_HACE_MAX_SG];
+    uint32_t total_msg_len;
+    uint32_t pad_offset;
     g_autofree uint8_t *digest_buf = NULL;
     size_t digest_len = 0;
-    int niov = 0;
+    bool sg_acc_mode_final_request = false;
     int i;
     void *haddr;
+    Error *local_err = NULL;
+
+    if (acc_mode && s->hash_ctx == NULL) {
+        s->hash_ctx = qcrypto_hash_new(algo, &local_err);
+        if (s->hash_ctx == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash failed : %s",
+                          error_get_pretty(local_err));
+            error_free(local_err);
+            return;
+        }
+    }
 
     if (sg_mode) {
         uint32_t len = 0;
@@ -226,8 +206,16 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             }
             iov[i].iov_base = haddr;
             if (acc_mode) {
-                niov = gen_acc_mode_iov(s, iov, i, &plen);
-
+                s->total_req_len += plen;
+
+                if (has_padding(s, &iov[i], plen, &total_msg_len,
+                                &pad_offset)) {
+                    /* Padding being present indicates the final request */
+                    sg_acc_mode_final_request = true;
+                    iov[i].iov_len = pad_offset;
+                } else {
+                    iov[i].iov_len = plen;
+                }
             } else {
                 iov[i].iov_len = plen;
             }
@@ -252,21 +240,42 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
              * required to check whether cache is empty. If no, we should
              * combine cached iov and the current iov.
              */
-            uint32_t total_msg_len;
-            uint32_t pad_offset;
             s->total_req_len += len;
             if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
-                niov = reconstruct_iov(s, iov, 0, &pad_offset);
+                i = reconstruct_iov(s, iov, 0, &pad_offset);
             }
         }
     }
 
-    if (niov) {
-        i = niov;
-    }
+    if (acc_mode) {
+        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, &local_err) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash update failed : %s",
+                          error_get_pretty(local_err));
+            error_free(local_err);
+            return;
+        }
+
+        if (sg_acc_mode_final_request) {
+            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
+                                            &digest_len, &local_err)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "qcrypto hash finalize failed : %s",
+                              error_get_pretty(local_err));
+                error_free(local_err);
+                local_err = NULL;
+            }
 
-    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
+            qcrypto_hash_free(s->hash_ctx);
+
+            s->hash_ctx = NULL;
+            s->iov_count = 0;
+            s->total_req_len = 0;
+        }
+    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
+                                   &digest_len, &local_err) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash bytesv failed : %s",
+                      error_get_pretty(local_err));
+        error_free(local_err);
         return;
     }
 
@@ -397,6 +406,11 @@ static void aspeed_hace_reset(DeviceState *dev)
 {
     struct AspeedHACEState *s = ASPEED_HACE(dev);
 
+    if (s->hash_ctx != NULL) {
+        qcrypto_hash_free(s->hash_ctx);
+        s->hash_ctx = NULL;
+    }
+
     memset(s->regs, 0, sizeof(s->regs));
     s->iov_count = 0;
     s->total_req_len = 0;
-- 
2.47.0


