Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC2AC3B21
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 10:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJSqW-0004jF-Mp; Mon, 26 May 2025 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqO-0004XH-4D
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJSqM-0002J1-Hk
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748246757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWuKDU1l3/MIRoRXixZsuU9PRyWkBtBq/fLKRMnsGQ0=;
 b=aIy1JWUxUAaQTT8zHUjJPAzdLgdn3G7KJBS5EvegZQt7H4FKS+WWVU8AbvdRYPtom9Dv18
 bFYNvGTuZOqblEmj3ZQYPlTa7EVQREXl5hbtnQERoYpLzw14yEm8GAIzndze3HZoDJsZwN
 bVfK8NVD48w0ts8nF5vQE6l1cqFajBY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-IX0pJxcENy-rZDP16Rs5eQ-1; Mon,
 26 May 2025 04:05:46 -0400
X-MC-Unique: IX0pJxcENy-rZDP16Rs5eQ-1
X-Mimecast-MFC-AGG-ID: IX0pJxcENy-rZDP16Rs5eQ_1748246746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC57D195606E; Mon, 26 May 2025 08:05:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 442C118003FD; Mon, 26 May 2025 08:05:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/39] hw/misc/aspeed_hace: Extract non-accumulation hash
 execution into helper function
Date: Mon, 26 May 2025 10:04:42 +0200
Message-ID: <20250526080512.1697528-10-clg@redhat.com>
In-Reply-To: <20250526080512.1697528-1-clg@redhat.com>
References: <20250526080512.1697528-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

To improve code readability and maintainability of do_hash_operation(), this
commit introduces a new helper function: hash_execute_non_acc_mode().

The helper encapsulate the hashing logic for non-accumulation mode.

No functional changes are introduced.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 7da781f8649e..c50e228cdf95 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -248,6 +248,25 @@ static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
     }
 }
 
+static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
+                                      struct iovec *iov, int iov_idx)
+{
+    g_autofree uint8_t *digest_buf = NULL;
+    Error *local_err = NULL;
+    size_t digest_len = 0;
+
+    if (qcrypto_hash_bytesv(algo, iov, iov_idx, &digest_buf,
+                            &digest_len, &local_err) < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: qcrypto hash bytesv failed : %s",
+                      __func__, error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
+}
+
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
@@ -304,15 +323,12 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             s->hash_ctx = NULL;
             s->total_req_len = 0;
         }
-    } else if (qcrypto_hash_bytesv(algo, iov, iov_idx, &digest_buf,
-                                   &digest_len, &local_err) < 0) {
-        qemu_log_mask(LOG_GUEST_ERROR, "qcrypto hash bytesv failed : %s",
-                      error_get_pretty(local_err));
-        error_free(local_err);
-        return;
-    }
 
-    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf, digest_len);
+        hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf,
+                                        digest_len);
+    } else {
+        hash_execute_non_acc_mode(s, algo, iov, iov_idx);
+    }
 }
 
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
-- 
2.49.0


