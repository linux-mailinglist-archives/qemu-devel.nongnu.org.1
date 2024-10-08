Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52B99401F
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 09:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy56E-0008Aq-56; Tue, 08 Oct 2024 03:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy56B-0008A8-8b
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sy569-0005bx-Rd
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 03:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728374257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypa5LEggZwEYyE+5hDvWP9/ozU5gJQ2VY7QZvpl5r+0=;
 b=TwiYGAnnE0Z7ytpP8oVUo3ilGdDJ6xWulrcDjpy5415Qe3J5u99CpJln/tFI8fItIxlPnk
 bFaIF9fqqFL6WnzSFqEcI+OpBfD+yBIqC9ySbjUtDDGaPUV+0Eapa9ouONdsuzpzRzh9/n
 8yoXj3pLTjAsalhm2EMMuidNzx05M0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-0qv7Kr4hOMC-RNbEEMo7bg-1; Tue,
 08 Oct 2024 03:57:35 -0400
X-MC-Unique: 0qv7Kr4hOMC-RNbEEMo7bg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49DA91956058; Tue,  8 Oct 2024 07:57:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC1AA300018D; Tue,  8 Oct 2024 07:57:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	berrange@redhat.com
Cc: kris.conklin@seagate.com, jonathan.henze@seagate.com,
 evan.burgess@seagate.com, peter.maydell@linaro.org,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 02/16] crypto/hash-glib: Implement new hash API
Date: Tue,  8 Oct 2024 09:57:09 +0200
Message-ID: <20241008075724.2772149-3-clg@redhat.com>
In-Reply-To: <20241008075724.2772149-1-clg@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

Implements the new hashing API in the GLib hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
[ clg: - Dropped qcrypto_hash_supports() in qcrypto_glib_hash_new()
       - Removed superfluous cast (GChecksum *) in qcrypto_glib_hash_free()
       - Reworked qcrypto_glib_hash_finalize() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/hash-glib.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index a5a2949333ae..783283facc18 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -95,6 +96,72 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgo alg,
 }
 
 
+static
+QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgo alg,
+                                   Error **errp)
+{
+    QCryptoHash *hash;
+
+    hash = g_new(QCryptoHash, 1);
+    hash->alg = alg;
+    hash->opaque = g_checksum_new(qcrypto_hash_alg_map[alg]);
+
+    return hash;
+}
+
+static
+void qcrypto_glib_hash_free(QCryptoHash *hash)
+{
+    if (hash->opaque) {
+        g_checksum_free(hash->opaque);
+    }
+
+    g_free(hash);
+}
+
+
+static
+int qcrypto_glib_hash_update(QCryptoHash *hash,
+                             const struct iovec *iov,
+                             size_t niov,
+                             Error **errp)
+{
+    GChecksum *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        g_checksum_update(ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_glib_hash_finalize(QCryptoHash *hash,
+                               uint8_t **result,
+                               size_t *result_len,
+                               Error **errp)
+{
+    int ret;
+    GChecksum *ctx = hash->opaque;
+
+    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[hash->alg]);
+    if (ret < 0) {
+        error_setg(errp, "Unable to get hash length");
+        *result_len = 0;
+        return -1;
+    }
+
+    *result_len = ret;
+    *result = g_new(uint8_t, *result_len);
+
+    g_checksum_get_digest(ctx, *result, result_len);
+    return 0;
+}
+
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_glib_hash_bytesv,
+    .hash_new      = qcrypto_glib_hash_new,
+    .hash_update   = qcrypto_glib_hash_update,
+    .hash_finalize = qcrypto_glib_hash_finalize,
+    .hash_free     = qcrypto_glib_hash_free,
 };
-- 
2.46.2


