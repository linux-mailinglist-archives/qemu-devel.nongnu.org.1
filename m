Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A06E973DBC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 18:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41n-0007GN-5I; Tue, 10 Sep 2024 12:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41Z-0006nM-LH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0007ZD-1t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PydUzejW3OmfbnNZOGPbw9odvqLIxws3j18KThH2+9g=;
 b=GMQ4xetglBTC156LLwXpAcArGNsuJbeEgC2vri4zTmx0/DPYwvfmXqHzQdeyOl5AzDPqHF
 0XE1937nZcI0ySi45ns9d0a7o0tRxcJ4IrZYnEivUSK51iiOBnUPvGvzDjg1qMo8Az0zhD
 MZ6v+AFhnloTRoFw5axBWW88nllUQdQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-89mGMmzDMKCu1URXx3wcaw-1; Tue,
 10 Sep 2024 12:47:21 -0400
X-MC-Unique: 89mGMmzDMKCu1URXx3wcaw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 106D21955F3D; Tue, 10 Sep 2024 16:47:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 526FD1956052; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 921A121E6828; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/19] qapi/crypto: Drop unwanted 'prefix'
Date: Tue, 10 Sep 2024 18:47:05 +0200
Message-ID: <20240910164714.1993531-11-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QAPI's 'prefix' feature can make the connection between enumeration
type and its constants less than obvious.  It's best used with
restraint.

QCryptoAkCipherKeyType has a 'prefix' that overrides the generated
enumeration constants' prefix to QCRYPTO_AKCIPHER_KEY_TYPE.

Drop it.  The prefix becomes QCRYPTO_AK_CIPHER_KEY_TYPE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240904111836.3273842-11-armbru@redhat.com>
---
 qapi/crypto.json                        |  1 -
 backends/cryptodev-builtin.c            |  4 ++--
 backends/cryptodev-lkcf.c               |  6 +++---
 tests/bench/benchmark-crypto-akcipher.c |  2 +-
 tests/unit/test-crypto-akcipher.c       | 28 ++++++++++++-------------
 crypto/akcipher-gcrypt.c.inc            |  8 +++----
 crypto/akcipher-nettle.c.inc            |  8 +++----
 crypto/rsakey-builtin.c.inc             |  4 ++--
 crypto/rsakey-nettle.c.inc              |  4 ++--
 9 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index fb00c706b2..b5c25e7cd9 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -609,7 +609,6 @@
 # Since: 7.1
 ##
 { 'enum': 'QCryptoAkCipherKeyType',
-  'prefix': 'QCRYPTO_AKCIPHER_KEY_TYPE',
   'data': ['public', 'private']}
 
 ##
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 940104ee55..e95af9bb72 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -334,11 +334,11 @@ static int cryptodev_builtin_create_akcipher_session(
 
     switch (sess_info->keytype) {
     case VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
-        type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+        type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC;
         break;
 
     case VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
-        type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+        type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE;
         break;
 
     default:
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 45aba1ff67..e1ee11a158 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -322,7 +322,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
      * 2. generally, public key related compution is fast, just compute it with
      * thread-pool.
      */
-    if (session->keytype == QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE) {
+    if (session->keytype == QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
         if (qcrypto_akcipher_export_p8info(&session->akcipher_opts,
                                            session->key, session->keylen,
                                            &p8info, &p8info_len,
@@ -534,11 +534,11 @@ static int cryptodev_lkcf_create_asym_session(
 
     switch (sess_info->keytype) {
     case VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
-        sess->keytype = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+        sess->keytype = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC;
         break;
 
     case VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
-        sess->keytype = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+        sess->keytype = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE;
         break;
 
     default:
diff --git a/tests/bench/benchmark-crypto-akcipher.c b/tests/bench/benchmark-crypto-akcipher.c
index 5e68cb0a1c..bbc29c9b12 100644
--- a/tests/bench/benchmark-crypto-akcipher.c
+++ b/tests/bench/benchmark-crypto-akcipher.c
@@ -28,7 +28,7 @@ static QCryptoAkCipher *create_rsa_akcipher(const uint8_t *priv_key,
     opt.alg = QCRYPTO_AKCIPHER_ALG_RSA;
     opt.u.rsa.padding_alg = padding;
     opt.u.rsa.hash_alg = hash;
-    return qcrypto_akcipher_new(&opt, QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+    return qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
                                 priv_key, keylen, &error_abort);
 }
 
diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akcipher.c
index 4f1f4214dd..59bc6f1e69 100644
--- a/tests/unit/test-crypto-akcipher.c
+++ b/tests/unit/test-crypto-akcipher.c
@@ -692,7 +692,7 @@ struct QCryptoAkCipherTestData {
 static QCryptoRSAKeyTestData rsakey_test_data[] = {
     {
         .path = "/crypto/akcipher/rsakey-1024-public",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa1024_public_key,
         .keylen = sizeof(rsa1024_public_key),
         .is_valid_key = true,
@@ -700,7 +700,7 @@ static QCryptoRSAKeyTestData rsakey_test_data[] = {
     },
     {
         .path = "/crypto/akcipher/rsakey-1024-private",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
         .key = rsa1024_private_key,
         .keylen = sizeof(rsa1024_private_key),
         .is_valid_key = true,
@@ -708,7 +708,7 @@ static QCryptoRSAKeyTestData rsakey_test_data[] = {
     },
     {
         .path = "/crypto/akcipher/rsakey-2048-public",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa2048_public_key,
         .keylen = sizeof(rsa2048_public_key),
         .is_valid_key = true,
@@ -716,7 +716,7 @@ static QCryptoRSAKeyTestData rsakey_test_data[] = {
     },
     {
         .path = "/crypto/akcipher/rsakey-2048-private",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
         .key = rsa2048_private_key,
         .keylen = sizeof(rsa2048_private_key),
         .is_valid_key = true,
@@ -724,56 +724,56 @@ static QCryptoRSAKeyTestData rsakey_test_data[] = {
     },
     {
         .path = "/crypto/akcipher/rsakey-public-lack-elem",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa_public_key_lack_element,
         .keylen = sizeof(rsa_public_key_lack_element),
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-private-lack-elem",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
         .key = rsa_private_key_lack_element,
         .keylen = sizeof(rsa_private_key_lack_element),
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-public-empty-elem",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa_public_key_empty_element,
         .keylen = sizeof(rsa_public_key_empty_element),
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-private-empty-elem",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
         .key = rsa_private_key_empty_element,
         .keylen = sizeof(rsa_private_key_empty_element),
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-public-empty-key",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = NULL,
         .keylen = 0,
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-private-empty-key",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
         .key = NULL,
         .keylen = 0,
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-public-invalid-length-val",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa_public_key_invalid_length_val,
         .keylen = sizeof(rsa_public_key_invalid_length_val),
         .is_valid_key = false,
     },
     {
         .path = "/crypto/akcipher/rsakey-public-extra-elem",
-        .key_type = QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+        .key_type = QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
         .key = rsa_public_key_extra_elem,
         .keylen = sizeof(rsa_public_key_extra_elem),
         .is_valid_key = false,
@@ -885,12 +885,12 @@ static void test_akcipher(const void *opaque)
         return;
     }
     pub_key = qcrypto_akcipher_new(&data->opt,
-                                   QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC,
+                                   QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
                                    data->pub_key, data->pub_key_len,
                                    &error_abort);
     g_assert(pub_key != NULL);
     priv_key = qcrypto_akcipher_new(&data->opt,
-                                    QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE,
+                                    QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
                                     data->priv_key, data->priv_key_len,
                                     &error_abort);
     g_assert(priv_key != NULL);
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
index abb1fb272e..e942d43421 100644
--- a/crypto/akcipher-gcrypt.c.inc
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -85,7 +85,7 @@ static int qcrypto_gcrypt_parse_rsa_private_key(
     const uint8_t *key, size_t keylen, Error **errp)
 {
     g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
-        QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE, key, keylen, errp);
+        QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE, key, keylen, errp);
     gcry_mpi_t n = NULL, e = NULL, d = NULL, p = NULL, q = NULL, u = NULL;
     bool compute_mul_inv = false;
     int ret = -1;
@@ -178,7 +178,7 @@ static int qcrypto_gcrypt_parse_rsa_public_key(QCryptoGcryptRSA *rsa,
 {
 
     g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
-        QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC, key, keylen, errp);
+        QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC, key, keylen, errp);
     gcry_mpi_t n = NULL, e = NULL;
     int ret = -1;
     gcry_error_t err;
@@ -540,13 +540,13 @@ static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(
     rsa->akcipher.driver = &gcrypt_rsa;
 
     switch (type) {
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
         if (qcrypto_gcrypt_parse_rsa_private_key(rsa, key, keylen, errp) != 0) {
             goto error;
         }
         break;
 
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
         if (qcrypto_gcrypt_parse_rsa_public_key(rsa, key, keylen, errp) != 0) {
             goto error;
         }
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
index 02699e6e6d..62ac8699c4 100644
--- a/crypto/akcipher-nettle.c.inc
+++ b/crypto/akcipher-nettle.c.inc
@@ -87,7 +87,7 @@ static int qcrypt_nettle_parse_rsa_private_key(QCryptoNettleRSA *rsa,
                                                Error **errp)
 {
     g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
-        QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE, key, keylen, errp);
+        QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE, key, keylen, errp);
 
     if (!rsa_key) {
         return -1;
@@ -137,7 +137,7 @@ static int qcrypt_nettle_parse_rsa_public_key(QCryptoNettleRSA *rsa,
                                               Error **errp)
 {
     g_autoptr(QCryptoAkCipherRSAKey) rsa_key = qcrypto_akcipher_rsakey_parse(
-        QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC, key, keylen, errp);
+        QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC, key, keylen, errp);
 
     if (!rsa_key) {
         return -1;
@@ -397,13 +397,13 @@ static QCryptoAkCipher *qcrypto_nettle_rsa_new(
     rsa_private_key_init(&rsa->priv);
 
     switch (type) {
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
         if (qcrypt_nettle_parse_rsa_private_key(rsa, key, keylen, errp) != 0) {
             goto error;
         }
         break;
 
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
         if (qcrypt_nettle_parse_rsa_public_key(rsa, key, keylen, errp) != 0) {
             goto error;
         }
diff --git a/crypto/rsakey-builtin.c.inc b/crypto/rsakey-builtin.c.inc
index 46cc7afe87..6337b84c54 100644
--- a/crypto/rsakey-builtin.c.inc
+++ b/crypto/rsakey-builtin.c.inc
@@ -183,10 +183,10 @@ QCryptoAkCipherRSAKey *qcrypto_akcipher_rsakey_parse(
     size_t keylen, Error **errp)
 {
     switch (type) {
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
         return qcrypto_builtin_rsa_private_key_parse(key, keylen, errp);
 
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
         return qcrypto_builtin_rsa_public_key_parse(key, keylen, errp);
 
     default:
diff --git a/crypto/rsakey-nettle.c.inc b/crypto/rsakey-nettle.c.inc
index cc49872e78..b7f34b0234 100644
--- a/crypto/rsakey-nettle.c.inc
+++ b/crypto/rsakey-nettle.c.inc
@@ -145,10 +145,10 @@ QCryptoAkCipherRSAKey *qcrypto_akcipher_rsakey_parse(
     size_t keylen, Error **errp)
 {
     switch (type) {
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PRIVATE:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
         return qcrypto_nettle_rsa_private_key_parse(key, keylen, errp);
 
-    case QCRYPTO_AKCIPHER_KEY_TYPE_PUBLIC:
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
         return qcrypto_nettle_rsa_public_key_parse(key, keylen, errp);
 
     default:
-- 
2.46.0


