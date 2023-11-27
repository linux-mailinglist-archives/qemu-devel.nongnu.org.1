Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847317FA571
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:59:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7e0w-0008TJ-EW; Mon, 27 Nov 2023 10:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7e0s-0008Sx-93
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:59:10 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7e0p-00005K-KW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:59:10 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cfd04a6e49so7585035ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701100621; x=1701705421;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxwKc74S2HwW2/HZTnSF9TxIg1AzXyKXmrE8eHOOjSw=;
 b=VPoiLfUQzTp8e6moh/KX91cOlBv+xk0Is3c0Ok3ZQzJKmSAGPgM5IIqldYI1JcHYfW
 U1NjnibUTO0SN8zHPv/7RrckpmwABM3waVSq4u5QC5es9efI434z1nstZh8RzTLD7yoU
 0RYl6mx4iEfuC3ev5QS/1zeDR/6aIGO4Lki0CY+3A3Rqo9Z+PWQ8JGKlQS9dMHUI4ZTY
 a+P0jNGDsyV1PIDA7Qp9UdNnanGNKUWHlD5zzdkucNEQUUsMq++1gmgISzUoSQLzDNuW
 srbXzqDu5JyeWp/XclbcAukaR5HS/jMqjMiEnfilkxWfw2LxMhsAStsjmrcpma9QWVrV
 KMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701100621; x=1701705421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxwKc74S2HwW2/HZTnSF9TxIg1AzXyKXmrE8eHOOjSw=;
 b=vC5kFV5fWLjCb3uG331b/FhswVNT7x9PgozJZKBfN0NfzYZ8GtBnrvJmEmJ6bcKQBt
 ktO198F7Gj7/d2Py8x3MmkCJgX8Rm+tXvzSOqiaEDUZZ4PTTLq3CQcGBr4fA5JG8ax0S
 8PEkS6EEuysKnUM4NnZ+i78xZ6pHEEajzczFLVWscMA7Kye4y0uGgb6TAwgQIXrO1o8m
 FuId5ftnsgqVB3ERa3Wmdb/NLq6UfTU+NKFJhS1703iFXYhER+51nYCk6HS4EenS1upz
 rzRFhkLXZY9SoH9rBj+RNXzIOo9JxeGWUpm4qg8jZK+U7RS3FEUen4ERitb9BO0qC5ep
 u7zA==
X-Gm-Message-State: AOJu0Yw2Db770xG3LQH0QGxit3PjyFuLErb0YIxiSM85gkXvlpdcgfZX
 lJK9M1hnBwnjwt7vhH7wjdquinxnEo1hDArjqPut+WY8
X-Google-Smtp-Source: AGHT+IHDYy3CWjWtN4Ezsal8I8pqTFCXL7BbiztMPiZvrjhho8chJAD3Oi0kYwHRHV5grsF+fQiqMA==
X-Received: by 2002:a17:902:ec92:b0:1cf:bf7b:adf2 with SMTP id
 x18-20020a170902ec9200b001cfbf7badf2mr8919722plg.32.1701100621045; 
 Mon, 27 Nov 2023 07:57:01 -0800 (PST)
Received: from localhost.localdomain ([171.216.79.177])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a170902b48a00b001cfb52ebffesm4642669plr.147.2023.11.27.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 07:57:00 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH] crypto: Introduce SM4 symmetric cipher algorithm
Date: Mon, 27 Nov 2023 23:55:34 +0800
Message-Id: <386ee33ff8f1dc4e8416b037e548ae36c983d054.1701100272.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).

SM4 (GBT.32907-2016) is a cryptographic standard issued by the
Organization of State Commercial Administration of China (OSCCA)
as an authorized cryptographic algorithms for the use within China.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c             |  7 ++++++
 crypto/cipher-gcrypt.c.inc      |  4 ++++
 crypto/cipher-nettle.c.inc      | 42 +++++++++++++++++++++++++++++++++
 crypto/cipher.c                 |  2 ++
 qapi/crypto.json                |  5 +++-
 tests/unit/test-crypto-cipher.c | 11 +++++++++
 6 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index fb01ec38bb..1cb7f21a05 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -95,12 +95,19 @@ qcrypto_block_luks_cipher_size_map_twofish[] = {
     { 0, 0 },
 };
 
+static const QCryptoBlockLUKSCipherSizeMap
+qcrypto_block_luks_cipher_size_map_sm4[] = {
+    { 16, QCRYPTO_CIPHER_ALG_SM4},
+    { 0, 0 },
+};
+
 static const QCryptoBlockLUKSCipherNameMap
 qcrypto_block_luks_cipher_name_map[] = {
     { "aes", qcrypto_block_luks_cipher_size_map_aes },
     { "cast5", qcrypto_block_luks_cipher_size_map_cast5 },
     { "serpent", qcrypto_block_luks_cipher_size_map_serpent },
     { "twofish", qcrypto_block_luks_cipher_size_map_twofish },
+    { "sm4", qcrypto_block_luks_cipher_size_map_sm4},
 };
 
 QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) != 48);
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index a6a0117717..03af50b0c3 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -35,6 +35,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_SERPENT_256:
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+    case QCRYPTO_CIPHER_ALG_SM4:
         break;
     default:
         return false;
@@ -219,6 +220,9 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
         gcryalg = GCRY_CIPHER_TWOFISH;
         break;
+    case QCRYPTO_CIPHER_ALG_SM4:
+        gcryalg = GCRY_CIPHER_SM4;
+        break;
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 24cc61f87b..cd2ca0c7b5 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -30,6 +30,7 @@
 #include <nettle/serpent.h>
 #include <nettle/twofish.h>
 #include <nettle/ctr.h>
+#include <nettle/sm4.h>
 #ifndef CONFIG_QEMU_PRIVATE_XTS
 #include <nettle/xts.h>
 #endif
@@ -426,6 +427,28 @@ DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
                        QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
                        twofish_encrypt_native, twofish_decrypt_native)
 
+typedef struct QCryptoNettleSm4 {
+    QCryptoCipher base;
+    struct sm4_ctx key[2];
+} QCryptoNettleSm4;
+
+static void sm4_encrypt_native(void *ctx, size_t length,
+                               uint8_t *dst, const uint8_t *src)
+{
+    struct sm4_ctx *keys = ctx;
+    sm4_crypt(&keys[0], length, dst, src);
+}
+
+static void sm4_decrypt_native(void *ctx, size_t length,
+                               uint8_t *dst, const uint8_t *src)
+{
+    struct sm4_ctx *keys = ctx;
+    sm4_crypt(&keys[1], length, dst, src);
+}
+
+DEFINE_ECB(qcrypto_nettle_sm4,
+           QCryptoNettleSm4, SM4_BLOCK_SIZE,
+           sm4_encrypt_native, sm4_decrypt_native)
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
@@ -443,6 +466,7 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_192:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+    case QCRYPTO_CIPHER_ALG_SM4:
         break;
     default:
         return false;
@@ -702,6 +726,24 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
             return &ctx->base;
         }
 
+    case QCRYPTO_CIPHER_ALG_SM4:
+        {
+            QCryptoNettleSm4 *ctx = g_new0(QCryptoNettleSm4, 1);
+
+            switch (mode) {
+            case QCRYPTO_CIPHER_MODE_ECB:
+                ctx->base.driver = &qcrypto_nettle_sm4_driver_ecb;
+                break;
+            default:
+                goto bad_cipher_mode;
+            }
+
+            sm4_set_encrypt_key(&ctx->key[0], key);
+            sm4_set_decrypt_key(&ctx->key[1], key);
+
+            return &ctx->base;
+        }
+
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 74b09a5b26..048ceaa6a3 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -38,6 +38,7 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 24,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
+    [QCRYPTO_CIPHER_ALG_SM4] = 16,
 };
 
 static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
@@ -53,6 +54,7 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
+    [QCRYPTO_CIPHER_ALG_SM4] = 16,
 };
 
 static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..95fa10bb6d 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -94,6 +94,8 @@
 #
 # @twofish-256: Twofish with 256 bit / 32 byte keys
 #
+# @sm4: SM4 with 128 bit / 16 byte keys (since 8.2)
+#
 # Since: 2.6
 ##
 { 'enum': 'QCryptoCipherAlgorithm',
@@ -102,7 +104,8 @@
            'des', '3des',
            'cast5-128',
            'serpent-128', 'serpent-192', 'serpent-256',
-           'twofish-128', 'twofish-192', 'twofish-256']}
+           'twofish-128', 'twofish-192', 'twofish-256',
+           'sm4']}
 
 ##
 # @QCryptoCipherMode:
diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index d9d9d078ff..80a4984e43 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -382,6 +382,17 @@ static QCryptoCipherTestData test_data[] = {
         .plaintext = "90afe91bb288544f2c32dc239b2635e6",
         .ciphertext = "6cb4561c40bf0a9705931cb6d408e7fa",
     },
+    {
+        /* SM4, GB/T 32907-2016, Appendix A.1 */
+        .path = "/crypto/cipher/sm4",
+        .alg = QCRYPTO_CIPHER_ALG_SM4,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key = "0123456789abcdeffedcba9876543210",
+        .plaintext  =
+            "0123456789abcdeffedcba9876543210",
+        .ciphertext =
+            "681edf34d206965e86b3e94f536e4246",
+    },
     {
         /* #1 32 byte key, 32 byte PTX */
         .path = "/crypto/cipher/aes-xts-128-1",
-- 
2.39.1


