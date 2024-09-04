Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D396BA99
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 13:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slo9i-0003dU-5O; Wed, 04 Sep 2024 07:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo9M-0001Yr-HE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1slo9D-0004kl-1F
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725449161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70jMuVZso5R0028zPf4/S/G6TSwBNhjs4yo5beZEVtA=;
 b=WtjVQ2rEp0ruPwq5XowTsQhL4tpEpsJw0t5+sg9knPntTts8n6MQnVmz8o26+bxuNFIlAe
 cvrzORYGi4sNJRmTbtACScu3+M6Ny9XDxVWiiEOCz4ekArJXNAQ2CbQDBF5sYSF7qSrOGN
 8KPo0fLe+txktPlhp5CNH70TGdYQMpk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-EQ1bwIKsP2y4bb1iuwKx4A-1; Wed,
 04 Sep 2024 07:18:51 -0400
X-MC-Unique: EQ1bwIKsP2y4bb1iuwKx4A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AACE1955D80; Wed,  4 Sep 2024 11:18:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9A431956086; Wed,  4 Sep 2024 11:18:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D25F121E682D; Wed,  4 Sep 2024 13:18:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 avihaih@nvidia.com
Subject: [PATCH v2 15/19] qapi/crypto: Rename QCryptoRSAPaddingAlgorithm to
 *Algo, and drop prefix
Date: Wed,  4 Sep 2024 13:18:32 +0200
Message-ID: <20240904111836.3273842-16-armbru@redhat.com>
In-Reply-To: <20240904111836.3273842-1-armbru@redhat.com>
References: <20240904111836.3273842-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

QCryptoRSAPaddingAlgorithm has a 'prefix' that overrides the generated
enumeration constants' prefix to QCRYPTO_RSA_PADDING_ALG.

We could simply drop 'prefix', but then the prefix becomes
QCRYPTO_RSA_PADDING_ALGORITHM, which is rather long.

We could additionally rename the type to QCryptoRSAPaddingAlg, but I
think the abbreviation "alg" is less than clear.

Rename the type to QCryptoRSAPaddingAlgo instead.  The prefix becomes
QCRYPTO_RSA_PADDING_ALGO.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/crypto.json                        |  9 ++++-----
 backends/cryptodev-builtin.c            |  6 +++---
 backends/cryptodev-lkcf.c               | 10 +++++-----
 tests/bench/benchmark-crypto-akcipher.c | 12 ++++++------
 tests/unit/test-crypto-akcipher.c       | 10 +++++-----
 crypto/akcipher-gcrypt.c.inc            | 18 +++++++++---------
 crypto/akcipher-nettle.c.inc            | 18 +++++++++---------
 7 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 331d49ebb8..867b09d322 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -608,7 +608,7 @@
   'data': ['public', 'private']}
 
 ##
-# @QCryptoRSAPaddingAlgorithm:
+# @QCryptoRSAPaddingAlgo:
 #
 # The padding algorithm for RSA.
 #
@@ -618,8 +618,7 @@
 #
 # Since: 7.1
 ##
-{ 'enum': 'QCryptoRSAPaddingAlgorithm',
-  'prefix': 'QCRYPTO_RSA_PADDING_ALG',
+{ 'enum': 'QCryptoRSAPaddingAlgo',
   'data': ['raw', 'pkcs1']}
 
 ##
@@ -629,13 +628,13 @@
 #
 # @hash-alg: QCryptoHashAlgo
 #
-# @padding-alg: QCryptoRSAPaddingAlgorithm
+# @padding-alg: QCryptoRSAPaddingAlgo
 #
 # Since: 7.1
 ##
 { 'struct': 'QCryptoAkCipherOptionsRSA',
   'data': { 'hash-alg':'QCryptoHashAlgo',
-            'padding-alg': 'QCryptoRSAPaddingAlgorithm'}}
+            'padding-alg': 'QCryptoRSAPaddingAlgo'}}
 
 ##
 # @QCryptoAkCipherOptions:
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index d8b64091b6..6f3990481b 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -65,7 +65,7 @@ static void cryptodev_builtin_init_akcipher(CryptoDevBackend *backend)
     QCryptoAkCipherOptions opts;
 
     opts.alg = QCRYPTO_AK_CIPHER_ALGO_RSA;
-    opts.u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW;
+    opts.u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW;
     if (qcrypto_akcipher_supports(&opts)) {
         backend->conf.crypto_services |=
                      (1u << QCRYPTODEV_BACKEND_SERVICE_AKCIPHER);
@@ -200,12 +200,12 @@ static int cryptodev_builtin_set_rsa_options(
             return -1;
         }
         opt->hash_alg = hash_alg;
-        opt->padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1;
+        opt->padding_alg = QCRYPTO_RSA_PADDING_ALGO_PKCS1;
         return 0;
     }
 
     if (virtio_padding_algo == VIRTIO_CRYPTO_RSA_RAW_PADDING) {
-        opt->padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW;
+        opt->padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW;
         return 0;
     }
 
diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 6fb6e03d98..fde32950f6 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -139,14 +139,14 @@ static int cryptodev_lkcf_set_op_desc(QCryptoAkCipherOptions *opts,
     }
 
     rsa_opt = &opts->u.rsa;
-    if (rsa_opt->padding_alg == QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+    if (rsa_opt->padding_alg == QCRYPTO_RSA_PADDING_ALGO_PKCS1) {
         snprintf(key_desc, desc_len, "enc=%s hash=%s",
-                 QCryptoRSAPaddingAlgorithm_str(rsa_opt->padding_alg),
+                 QCryptoRSAPaddingAlgo_str(rsa_opt->padding_alg),
                  QCryptoHashAlgo_str(rsa_opt->hash_alg));
 
     } else {
         snprintf(key_desc, desc_len, "enc=%s",
-                 QCryptoRSAPaddingAlgorithm_str(rsa_opt->padding_alg));
+                 QCryptoRSAPaddingAlgo_str(rsa_opt->padding_alg));
     }
     return 0;
 }
@@ -157,7 +157,7 @@ static int cryptodev_lkcf_set_rsa_opt(int virtio_padding_alg,
                                       Error **errp)
 {
     if (virtio_padding_alg == VIRTIO_CRYPTO_RSA_PKCS1_PADDING) {
-        opt->padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1;
+        opt->padding_alg = QCRYPTO_RSA_PADDING_ALGO_PKCS1;
 
         switch (virtio_hash_alg) {
         case VIRTIO_CRYPTO_RSA_MD5:
@@ -184,7 +184,7 @@ static int cryptodev_lkcf_set_rsa_opt(int virtio_padding_alg,
     }
 
     if (virtio_padding_alg == VIRTIO_CRYPTO_RSA_RAW_PADDING) {
-        opt->padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW;
+        opt->padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW;
         return 0;
     }
 
diff --git a/tests/bench/benchmark-crypto-akcipher.c b/tests/bench/benchmark-crypto-akcipher.c
index 225e426bde..750c7e89ee 100644
--- a/tests/bench/benchmark-crypto-akcipher.c
+++ b/tests/bench/benchmark-crypto-akcipher.c
@@ -20,7 +20,7 @@
 
 static QCryptoAkCipher *create_rsa_akcipher(const uint8_t *priv_key,
                                             size_t keylen,
-                                            QCryptoRSAPaddingAlgorithm padding,
+                                            QCryptoRSAPaddingAlgo padding,
                                             QCryptoHashAlgo hash)
 {
     QCryptoAkCipherOptions opt;
@@ -39,7 +39,7 @@ static void test_rsa_speed(const uint8_t *priv_key, size_t keylen,
 #define SHA1_DGST_LEN 20
 #define SIGN_TIMES 10000
 #define VERIFY_TIMES 100000
-#define PADDING QCRYPTO_RSA_PADDING_ALG_PKCS1
+#define PADDING QCRYPTO_RSA_PADDING_ALGO_PKCS1
 #define HASH QCRYPTO_HASH_ALGO_SHA1
 
     g_autoptr(QCryptoAkCipher) rsa =
@@ -53,7 +53,7 @@ static void test_rsa_speed(const uint8_t *priv_key, size_t keylen,
     signature = g_new0(uint8_t, key_size / BYTE);
 
     g_test_message("benchmark rsa%zu (%s-%s) sign...", key_size,
-                   QCryptoRSAPaddingAlgorithm_str(PADDING),
+                   QCryptoRSAPaddingAlgo_str(PADDING),
                    QCryptoHashAlgo_str(HASH));
     g_test_timer_start();
     for (count = 0; count < SIGN_TIMES; ++count) {
@@ -64,13 +64,13 @@ static void test_rsa_speed(const uint8_t *priv_key, size_t keylen,
     g_test_timer_elapsed();
     g_test_message("rsa%zu (%s-%s) sign %zu times in %.2f seconds,"
                    " %.2f times/sec ",
-                   key_size,  QCryptoRSAPaddingAlgorithm_str(PADDING),
+                   key_size,  QCryptoRSAPaddingAlgo_str(PADDING),
                    QCryptoHashAlgo_str(HASH),
                    count, g_test_timer_last(),
                    (double)count / g_test_timer_last());
 
     g_test_message("benchmark rsa%zu (%s-%s) verification...", key_size,
-                   QCryptoRSAPaddingAlgorithm_str(PADDING),
+                   QCryptoRSAPaddingAlgo_str(PADDING),
                    QCryptoHashAlgo_str(HASH));
     g_test_timer_start();
     for (count = 0; count < VERIFY_TIMES; ++count) {
@@ -81,7 +81,7 @@ static void test_rsa_speed(const uint8_t *priv_key, size_t keylen,
     g_test_timer_elapsed();
     g_test_message("rsa%zu (%s-%s) verify %zu times in %.2f seconds,"
                    " %.2f times/sec ",
-                   key_size, QCryptoRSAPaddingAlgorithm_str(PADDING),
+                   key_size, QCryptoRSAPaddingAlgo_str(PADDING),
                    QCryptoHashAlgo_str(HASH),
                    count, g_test_timer_last(),
                    (double)count / g_test_timer_last());
diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akcipher.c
index 7dd86125c2..53c2211ba8 100644
--- a/tests/unit/test-crypto-akcipher.c
+++ b/tests/unit/test-crypto-akcipher.c
@@ -787,7 +787,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
         .opt = {
             .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
-                .padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW,
+                .padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
             },
         },
         .pub_key = rsa1024_public_key,
@@ -807,7 +807,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
         .opt = {
             .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
-                .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
+                .padding_alg = QCRYPTO_RSA_PADDING_ALGO_PKCS1,
                 .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
             },
         },
@@ -832,7 +832,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
         .opt = {
             .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
-                .padding_alg = QCRYPTO_RSA_PADDING_ALG_RAW,
+                .padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
             },
         },
         .pub_key = rsa2048_public_key,
@@ -852,7 +852,7 @@ static QCryptoAkCipherTestData akcipher_test_data[] = {
         .opt = {
             .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
             .u.rsa = {
-                .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
+                .padding_alg = QCRYPTO_RSA_PADDING_ALGO_PKCS1,
                 .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
             },
         },
@@ -946,7 +946,7 @@ static void test_rsakey(const void *opaque)
     QCryptoAkCipherOptions opt = {
         .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
         .u.rsa = {
-            .padding_alg = QCRYPTO_RSA_PADDING_ALG_PKCS1,
+            .padding_alg = QCRYPTO_RSA_PADDING_ALGO_PKCS1,
             .hash_alg = QCRYPTO_HASH_ALGO_SHA1,
         }
     };
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
index 8f1c2b8143..5a880f6638 100644
--- a/crypto/akcipher-gcrypt.c.inc
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -32,7 +32,7 @@
 typedef struct QCryptoGcryptRSA {
     QCryptoAkCipher akcipher;
     gcry_sexp_t key;
-    QCryptoRSAPaddingAlgorithm padding_alg;
+    QCryptoRSAPaddingAlgo padding_alg;
     QCryptoHashAlgo hash_alg;
 } QCryptoGcryptRSA;
 
@@ -241,7 +241,7 @@ static int qcrypto_gcrypt_rsa_encrypt(QCryptoAkCipher *akcipher,
 
     err = gcry_sexp_build(&data_sexp, NULL,
                           "(data (flags %s) (value %b))",
-                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          QCryptoRSAPaddingAlgo_str(rsa->padding_alg),
                           in_len, in);
     if (gcry_err_code(err) != 0) {
         error_setg(errp, "Failed to build plaintext: %s/%s",
@@ -263,7 +263,7 @@ static int qcrypto_gcrypt_rsa_encrypt(QCryptoAkCipher *akcipher,
         goto cleanup;
     }
 
-    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALGO_RAW) {
         cipher_mpi = gcry_sexp_nth_mpi(cipher_sexp_item, 1, GCRYMPI_FMT_USG);
         if (!cipher_mpi) {
             error_setg(errp, "Invalid ciphertext result");
@@ -332,7 +332,7 @@ static int qcrypto_gcrypt_rsa_decrypt(QCryptoAkCipher *akcipher,
 
     err = gcry_sexp_build(&cipher_sexp, NULL,
                           "(enc-val (flags %s) (rsa (a %b) ))",
-                          QCryptoRSAPaddingAlgorithm_str(rsa->padding_alg),
+                          QCryptoRSAPaddingAlgo_str(rsa->padding_alg),
                           in_len, in);
     if (gcry_err_code(err) != 0) {
         error_setg(errp, "Failed to build ciphertext: %s/%s",
@@ -348,7 +348,7 @@ static int qcrypto_gcrypt_rsa_decrypt(QCryptoAkCipher *akcipher,
     }
 
     /* S-expression of plaintext: (value plaintext) */
-    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALGO_RAW) {
         data_mpi = gcry_sexp_nth_mpi(data_sexp, 1, GCRYMPI_FMT_USG);
         if (!data_mpi) {
             error_setg(errp, "Invalid plaintext result");
@@ -410,7 +410,7 @@ static int qcrypto_gcrypt_rsa_sign(QCryptoAkCipher *akcipher,
         return ret;
     }
 
-    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALGO_PKCS1) {
         error_setg(errp, "Invalid padding %u", rsa->padding_alg);
         return ret;
     }
@@ -482,7 +482,7 @@ static int qcrypto_gcrypt_rsa_verify(QCryptoAkCipher *akcipher,
         return ret;
     }
 
-    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALG_PKCS1) {
+    if (rsa->padding_alg != QCRYPTO_RSA_PADDING_ALGO_PKCS1) {
         error_setg(errp, "Invalid padding %u", rsa->padding_alg);
         return ret;
     }
@@ -570,10 +570,10 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
     switch (opts->alg) {
     case QCRYPTO_AK_CIPHER_ALGO_RSA:
         switch (opts->u.rsa.padding_alg) {
-        case QCRYPTO_RSA_PADDING_ALG_RAW:
+        case QCRYPTO_RSA_PADDING_ALGO_RAW:
             return true;
 
-        case QCRYPTO_RSA_PADDING_ALG_PKCS1:
+        case QCRYPTO_RSA_PADDING_ALGO_PKCS1:
             switch (opts->u.rsa.hash_alg) {
             case QCRYPTO_HASH_ALGO_MD5:
             case QCRYPTO_HASH_ALGO_SHA1:
diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
index 21f27f8286..1720f84362 100644
--- a/crypto/akcipher-nettle.c.inc
+++ b/crypto/akcipher-nettle.c.inc
@@ -33,7 +33,7 @@ typedef struct QCryptoNettleRSA {
     QCryptoAkCipher akcipher;
     struct rsa_public_key pub;
     struct rsa_private_key priv;
-    QCryptoRSAPaddingAlgorithm padding_alg;
+    QCryptoRSAPaddingAlgo padding_alg;
     QCryptoHashAlgo hash_alg;
 } QCryptoNettleRSA;
 
@@ -184,11 +184,11 @@ static int qcrypto_nettle_rsa_encrypt(QCryptoAkCipher *akcipher,
 
     /* Nettle do not support RSA encryption without any padding */
     switch (rsa->padding_alg) {
-    case QCRYPTO_RSA_PADDING_ALG_RAW:
+    case QCRYPTO_RSA_PADDING_ALGO_RAW:
         error_setg(errp, "RSA with raw padding is not supported");
         break;
 
-    case QCRYPTO_RSA_PADDING_ALG_PKCS1:
+    case QCRYPTO_RSA_PADDING_ALGO_PKCS1:
         mpz_init(c);
         if (rsa_encrypt(&rsa->pub, NULL, wrap_nettle_random_func,
                         data_len, (uint8_t *)data, c) != 1) {
@@ -223,11 +223,11 @@ static int qcrypto_nettle_rsa_decrypt(QCryptoAkCipher *akcipher,
     }
 
     switch (rsa->padding_alg) {
-    case QCRYPTO_RSA_PADDING_ALG_RAW:
+    case QCRYPTO_RSA_PADDING_ALGO_RAW:
         error_setg(errp, "RSA with raw padding is not supported");
         break;
 
-    case QCRYPTO_RSA_PADDING_ALG_PKCS1:
+    case QCRYPTO_RSA_PADDING_ALGO_PKCS1:
         nettle_mpz_init_set_str_256_u(c, enc_len, enc);
         if (!rsa_decrypt(&rsa->priv, &data_len, (uint8_t *)data, c)) {
             error_setg(errp, "Failed to decrypt");
@@ -257,7 +257,7 @@ static int qcrypto_nettle_rsa_sign(QCryptoAkCipher *akcipher,
      * The RSA algorithm cannot be used for signature/verification
      * without padding.
      */
-    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALGO_RAW) {
         error_setg(errp, "Try to make signature without padding");
         return ret;
     }
@@ -324,7 +324,7 @@ static int qcrypto_nettle_rsa_verify(QCryptoAkCipher *akcipher,
      * The RSA algorithm cannot be used for signature/verification
      * without padding.
      */
-    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALG_RAW) {
+    if (rsa->padding_alg == QCRYPTO_RSA_PADDING_ALGO_RAW) {
         error_setg(errp, "Try to verify signature without padding");
         return ret;
     }
@@ -427,7 +427,7 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
     switch (opts->alg) {
     case QCRYPTO_AK_CIPHER_ALGO_RSA:
         switch (opts->u.rsa.padding_alg) {
-        case QCRYPTO_RSA_PADDING_ALG_PKCS1:
+        case QCRYPTO_RSA_PADDING_ALGO_PKCS1:
             switch (opts->u.rsa.hash_alg) {
             case QCRYPTO_HASH_ALGO_MD5:
             case QCRYPTO_HASH_ALGO_SHA1:
@@ -439,7 +439,7 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
                 return false;
             }
 
-        case QCRYPTO_RSA_PADDING_ALG_RAW:
+        case QCRYPTO_RSA_PADDING_ALGO_RAW:
         default:
             return false;
         }
-- 
2.46.0


