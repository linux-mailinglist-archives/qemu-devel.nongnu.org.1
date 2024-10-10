Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA57998D3D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 18:23:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvvp-00078w-I2; Thu, 10 Oct 2024 12:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvm-00077u-Pc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syvvl-0004Rb-Ct
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728577344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kT3aGvUcuMqLA9BKCOREUSBudqYFPF5d/C7lc+Fqp0o=;
 b=I1fRd8lN3FalBSSXQC4feNDr0OgBLwVz2w+CGRVKaXPrFaRFKgoicTkDcGF2kTWQCmo9wD
 0VbbchiILxFtxjNiq2VBFYNIGz+R4gOWcQ3wfojtrMxJQlALSvvhO4QQKkOu/wtL2BUDsD
 iJNznpZIR/P3pW5zWboNcRCbfYgEUPQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-iXU3l2z-MROoYD5EzBg5GQ-1; Thu,
 10 Oct 2024 12:22:23 -0400
X-MC-Unique: iXU3l2z-MROoYD5EzBg5GQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EDC11955DD4; Thu, 10 Oct 2024 16:22:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85DD8300019E; Thu, 10 Oct 2024 16:22:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kunwu <chentao@kylinos.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alejandro Zeise <alejandro.zeise@seagate.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/17] crypto/hash-nettle: Remove old hash API functions
Date: Thu, 10 Oct 2024 17:20:20 +0100
Message-ID: <20241010162024.988284-14-berrange@redhat.com>
In-Reply-To: <20241010162024.988284-1-berrange@redhat.com>
References: <20241010162024.988284-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alejandro Zeise <alejandro.zeise@seagate.com>

Removes old hash implementation in the nettle hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[ clg: - Fixed spelling in commit log ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-nettle.c | 53 --------------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 07e18ce26c..570ce8a645 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -104,58 +104,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
     return false;
 }
 
-
-static int
-qcrypto_nettle_hash_bytesv(QCryptoHashAlgo alg,
-                           const struct iovec *iov,
-                           size_t niov,
-                           uint8_t **result,
-                           size_t *resultlen,
-                           Error **errp)
-{
-    size_t i;
-    union qcrypto_hash_ctx ctx;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    qcrypto_hash_alg_map[alg].init(&ctx);
-
-    for (i = 0; i < niov; i++) {
-        /* Some versions of nettle have functions
-         * declared with 'int' instead of 'size_t'
-         * so to be safe avoid writing more than
-         * UINT_MAX bytes at a time
-         */
-        size_t len = iov[i].iov_len;
-        uint8_t *base = iov[i].iov_base;
-        while (len) {
-            size_t shortlen = MIN(len, UINT_MAX);
-            qcrypto_hash_alg_map[alg].write(&ctx, len, base);
-            len -= shortlen;
-            base += len;
-        }
-    }
-
-    if (*resultlen == 0) {
-        *resultlen = qcrypto_hash_alg_map[alg].len;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != qcrypto_hash_alg_map[alg].len) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %zu",
-                   *resultlen, qcrypto_hash_alg_map[alg].len);
-        return -1;
-    }
-
-    qcrypto_hash_alg_map[alg].result(&ctx, *resultlen, *result);
-
-    return 0;
-}
-
 static
 QCryptoHash *qcrypto_nettle_hash_new(QCryptoHashAlgo alg, Error **errp)
 {
@@ -223,7 +171,6 @@ int qcrypto_nettle_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_nettle_hash_bytesv,
     .hash_new      = qcrypto_nettle_hash_new,
     .hash_update   = qcrypto_nettle_hash_update,
     .hash_finalize = qcrypto_nettle_hash_finalize,
-- 
2.46.0


