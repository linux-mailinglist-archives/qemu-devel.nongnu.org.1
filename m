Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D58AADC30
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 12:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCbdy-00049Z-Vx; Wed, 07 May 2025 06:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCbds-00047Y-UF
 for qemu-devel@nongnu.org; Wed, 07 May 2025 06:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCbdo-0003TS-J4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 06:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746612278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j1iMEZsN5gpB4W/+faNTKPRZZG6KKUfHUDDXIPHQzZA=;
 b=hzY43IZoDV5PpaA/Zi/YxNJwB03Y30VqCj9eOzjmYYYQMYvcIaJSuyHXa9FMJPIuBla5Ah
 yTALVMocIQ7odirGvOCISqNQ0Ixs1/t57BXgel11L+RZoVp7cmqBmrtJhVDgGEVJuYin2Z
 Zvk3Mqf+f/y/aVARrxwuEtdRyPy8S/c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-ZZPDhH7wPHWbzRutUUayOg-1; Wed,
 07 May 2025 06:04:36 -0400
X-MC-Unique: ZZPDhH7wPHWbzRutUUayOg-1
X-Mimecast-MFC-AGG-ID: ZZPDhH7wPHWbzRutUUayOg_1746612276
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8155180099B
 for <qemu-devel@nongnu.org>; Wed,  7 May 2025 10:04:35 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.63])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A4831953B8D; Wed,  7 May 2025 10:04:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] crypto: fully drop built-in cipher provider
Date: Wed,  7 May 2025 11:04:30 +0100
Message-ID: <20250507100430.150360-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When originally creating the internal crypto cipher APIs, they were
wired up to use the built-in D3DES and AES implementations, as a way
to gracefully transition to the new APIs without introducing an
immediate hard dep on any external crypto libraries for the VNC
password auth (D3DES) or the qcow2 encryption (AES).

In the 6.1.0 release we dropped the built-in D3DES impl, and also
the XTS mode for the AES impl, leaving only AES with ECB/CBC modes.
The rational was that with the system emulators, it is expected that
3rd party crypto libraries will be available.

The qcow2 LUKS impl is preferred to the legacy raw AES impl, and by
default that requires AES in XTS mode, limiting the usefulness of
the built-in cipher provider.

The built-in AES impl has known timing attacks and is only suitable
for use cases where a security boundary is already not expected to
be provided (TCG).

Providing a built-in cipher impl thus potentially misleads users,
should they configure a QEMU without any crypto library, and try
to use it with the LUKS backend, even if that requires a non-default
configuration choice.

Complete what we started in 6.1.0 and purge the remaining AES
support.

Use of either gnutls, nettle, or libcrypt is now mandatory for any
cipher support, except for TCG impls.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-builtin.c.inc | 303 ------------------------------------
 crypto/cipher-stub.c.inc    |  41 +++++
 crypto/cipher.c             |   2 +-
 3 files changed, 42 insertions(+), 304 deletions(-)
 delete mode 100644 crypto/cipher-builtin.c.inc
 create mode 100644 crypto/cipher-stub.c.inc

diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
deleted file mode 100644
index da5fcbd9a3..0000000000
--- a/crypto/cipher-builtin.c.inc
+++ /dev/null
@@ -1,303 +0,0 @@
-/*
- * QEMU Crypto cipher built-in algorithms
- *
- * Copyright (c) 2015 Red Hat, Inc.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- *
- */
-
-#include "crypto/aes.h"
-
-typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
-struct QCryptoCipherBuiltinAESContext {
-    AES_KEY enc;
-    AES_KEY dec;
-};
-
-typedef struct QCryptoCipherBuiltinAES QCryptoCipherBuiltinAES;
-struct QCryptoCipherBuiltinAES {
-    QCryptoCipher base;
-    QCryptoCipherBuiltinAESContext key;
-    uint8_t iv[AES_BLOCK_SIZE];
-};
-
-
-static inline bool qcrypto_length_check(size_t len, size_t blocksize,
-                                        Error **errp)
-{
-    if (unlikely(len & (blocksize - 1))) {
-        error_setg(errp, "Length %zu must be a multiple of block size %zu",
-                   len, blocksize);
-        return false;
-    }
-    return true;
-}
-
-static void qcrypto_cipher_ctx_free(QCryptoCipher *cipher)
-{
-    g_free(cipher);
-}
-
-static int qcrypto_cipher_no_setiv(QCryptoCipher *cipher,
-                                   const uint8_t *iv, size_t niv,
-                                   Error **errp)
-{
-    error_setg(errp, "Setting IV is not supported");
-    return -1;
-}
-
-static void do_aes_encrypt_ecb(const void *vctx,
-                               size_t len,
-                               uint8_t *out,
-                               const uint8_t *in)
-{
-    const QCryptoCipherBuiltinAESContext *ctx = vctx;
-
-    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
-    while (len) {
-        AES_encrypt(in, out, &ctx->enc);
-        in += AES_BLOCK_SIZE;
-        out += AES_BLOCK_SIZE;
-        len -= AES_BLOCK_SIZE;
-    }
-}
-
-static void do_aes_decrypt_ecb(const void *vctx,
-                               size_t len,
-                               uint8_t *out,
-                               const uint8_t *in)
-{
-    const QCryptoCipherBuiltinAESContext *ctx = vctx;
-
-    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
-    while (len) {
-        AES_decrypt(in, out, &ctx->dec);
-        in += AES_BLOCK_SIZE;
-        out += AES_BLOCK_SIZE;
-        len -= AES_BLOCK_SIZE;
-    }
-}
-
-static void do_aes_encrypt_cbc(const AES_KEY *key,
-                               size_t len,
-                               uint8_t *out,
-                               const uint8_t *in,
-                               uint8_t *ivec)
-{
-    uint8_t tmp[AES_BLOCK_SIZE];
-    size_t n;
-
-    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
-    while (len) {
-        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-            tmp[n] = in[n] ^ ivec[n];
-        }
-        AES_encrypt(tmp, out, key);
-        memcpy(ivec, out, AES_BLOCK_SIZE);
-        len -= AES_BLOCK_SIZE;
-        in += AES_BLOCK_SIZE;
-        out += AES_BLOCK_SIZE;
-    }
-}
-
-static void do_aes_decrypt_cbc(const AES_KEY *key,
-                               size_t len,
-                               uint8_t *out,
-                               const uint8_t *in,
-                               uint8_t *ivec)
-{
-    uint8_t tmp[AES_BLOCK_SIZE];
-    size_t n;
-
-    /* We have already verified that len % AES_BLOCK_SIZE == 0. */
-    while (len) {
-        memcpy(tmp, in, AES_BLOCK_SIZE);
-        AES_decrypt(in, out, key);
-        for (n = 0; n < AES_BLOCK_SIZE; ++n) {
-            out[n] ^= ivec[n];
-        }
-        memcpy(ivec, tmp, AES_BLOCK_SIZE);
-        len -= AES_BLOCK_SIZE;
-        in += AES_BLOCK_SIZE;
-        out += AES_BLOCK_SIZE;
-    }
-}
-
-static int qcrypto_cipher_aes_encrypt_ecb(QCryptoCipher *cipher,
-                                          const void *in, void *out,
-                                          size_t len, Error **errp)
-{
-    QCryptoCipherBuiltinAES *ctx
-        = container_of(cipher, QCryptoCipherBuiltinAES, base);
-
-    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
-        return -1;
-    }
-    do_aes_encrypt_ecb(&ctx->key, len, out, in);
-    return 0;
-}
-
-static int qcrypto_cipher_aes_decrypt_ecb(QCryptoCipher *cipher,
-                                          const void *in, void *out,
-                                          size_t len, Error **errp)
-{
-    QCryptoCipherBuiltinAES *ctx
-        = container_of(cipher, QCryptoCipherBuiltinAES, base);
-
-    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
-        return -1;
-    }
-    do_aes_decrypt_ecb(&ctx->key, len, out, in);
-    return 0;
-}
-
-static int qcrypto_cipher_aes_encrypt_cbc(QCryptoCipher *cipher,
-                                          const void *in, void *out,
-                                          size_t len, Error **errp)
-{
-    QCryptoCipherBuiltinAES *ctx
-        = container_of(cipher, QCryptoCipherBuiltinAES, base);
-
-    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
-        return -1;
-    }
-    do_aes_encrypt_cbc(&ctx->key.enc, len, out, in, ctx->iv);
-    return 0;
-}
-
-static int qcrypto_cipher_aes_decrypt_cbc(QCryptoCipher *cipher,
-                                          const void *in, void *out,
-                                          size_t len, Error **errp)
-{
-    QCryptoCipherBuiltinAES *ctx
-        = container_of(cipher, QCryptoCipherBuiltinAES, base);
-
-    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
-        return -1;
-    }
-    do_aes_decrypt_cbc(&ctx->key.dec, len, out, in, ctx->iv);
-    return 0;
-}
-
-static int qcrypto_cipher_aes_setiv(QCryptoCipher *cipher, const uint8_t *iv,
-                             size_t niv, Error **errp)
-{
-    QCryptoCipherBuiltinAES *ctx
-        = container_of(cipher, QCryptoCipherBuiltinAES, base);
-
-    if (niv != AES_BLOCK_SIZE) {
-        error_setg(errp, "IV must be %d bytes not %zu",
-                   AES_BLOCK_SIZE, niv);
-        return -1;
-    }
-
-    memcpy(ctx->iv, iv, AES_BLOCK_SIZE);
-    return 0;
-}
-
-static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_ecb = {
-    .cipher_encrypt = qcrypto_cipher_aes_encrypt_ecb,
-    .cipher_decrypt = qcrypto_cipher_aes_decrypt_ecb,
-    .cipher_setiv = qcrypto_cipher_no_setiv,
-    .cipher_free = qcrypto_cipher_ctx_free,
-};
-
-static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_cbc = {
-    .cipher_encrypt = qcrypto_cipher_aes_encrypt_cbc,
-    .cipher_decrypt = qcrypto_cipher_aes_decrypt_cbc,
-    .cipher_setiv = qcrypto_cipher_aes_setiv,
-    .cipher_free = qcrypto_cipher_ctx_free,
-};
-
-bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
-                             QCryptoCipherMode mode)
-{
-    switch (alg) {
-    case QCRYPTO_CIPHER_ALGO_AES_128:
-    case QCRYPTO_CIPHER_ALGO_AES_192:
-    case QCRYPTO_CIPHER_ALGO_AES_256:
-        switch (mode) {
-        case QCRYPTO_CIPHER_MODE_ECB:
-        case QCRYPTO_CIPHER_MODE_CBC:
-            return true;
-        default:
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-}
-
-static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
-                                             QCryptoCipherMode mode,
-                                             const uint8_t *key,
-                                             size_t nkey,
-                                             Error **errp)
-{
-    if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
-        return NULL;
-    }
-
-    switch (alg) {
-    case QCRYPTO_CIPHER_ALGO_AES_128:
-    case QCRYPTO_CIPHER_ALGO_AES_192:
-    case QCRYPTO_CIPHER_ALGO_AES_256:
-        {
-            QCryptoCipherBuiltinAES *ctx;
-            const QCryptoCipherDriver *drv;
-
-            switch (mode) {
-            case QCRYPTO_CIPHER_MODE_ECB:
-                drv = &qcrypto_cipher_aes_driver_ecb;
-                break;
-            case QCRYPTO_CIPHER_MODE_CBC:
-                drv = &qcrypto_cipher_aes_driver_cbc;
-                break;
-            default:
-                goto bad_mode;
-            }
-
-            ctx = g_new0(QCryptoCipherBuiltinAES, 1);
-            ctx->base.driver = drv;
-
-            if (AES_set_encrypt_key(key, nkey * 8, &ctx->key.enc)) {
-                error_setg(errp, "Failed to set encryption key");
-                goto error;
-            }
-            if (AES_set_decrypt_key(key, nkey * 8, &ctx->key.dec)) {
-                error_setg(errp, "Failed to set decryption key");
-                goto error;
-            }
-
-            return &ctx->base;
-
-        error:
-            g_free(ctx);
-            return NULL;
-        }
-
-    default:
-        error_setg(errp,
-                   "Unsupported cipher algorithm %s",
-                   QCryptoCipherAlgo_str(alg));
-        return NULL;
-    }
-
- bad_mode:
-    error_setg(errp, "Unsupported cipher mode %s",
-               QCryptoCipherMode_str(mode));
-    return NULL;
-}
diff --git a/crypto/cipher-stub.c.inc b/crypto/cipher-stub.c.inc
new file mode 100644
index 0000000000..2574882d89
--- /dev/null
+++ b/crypto/cipher-stub.c.inc
@@ -0,0 +1,41 @@
+/*
+ * QEMU Crypto cipher built-in algorithms
+ *
+ * Copyright (c) 2015 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
+                             QCryptoCipherMode mode)
+{
+    return false;
+}
+
+static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
+                                             QCryptoCipherMode mode,
+                                             const uint8_t *key,
+                                             size_t nkey,
+                                             Error **errp)
+{
+    if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
+        return NULL;
+    }
+
+    error_setg(errp,
+               "Unsupported cipher algorithm %s, no crypto library enabled in build",
+               QCryptoCipherAlgo_str(alg));
+    return NULL;
+}
diff --git a/crypto/cipher.c b/crypto/cipher.c
index c14a8b8a11..229710f76b 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -145,7 +145,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo alg,
 #elif defined CONFIG_GNUTLS_CRYPTO
 #include "cipher-gnutls.c.inc"
 #else
-#include "cipher-builtin.c.inc"
+#include "cipher-stub.c.inc"
 #endif
 
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgo alg,
-- 
2.49.0


