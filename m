Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CED7FBE16
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:28:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7zz2-0003yX-Ql; Tue, 28 Nov 2023 10:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7zyz-0003y3-Io
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:26:41 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r7zyv-0002At-Ug
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:26:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cfb4d28c43so26692835ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701185074; x=1701789874;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QIs1sbtj+BmbWiuWD5CNEyM9R5uBGlfBWwIq3YbS0Hk=;
 b=oZKi0BCiSddUwECLmOzWe+sbLUzayuoVzxyUfroKgGmywZFc1FjeJxzVI5Xvkl/FTR
 52rOhDZGKDIzzt0uMIEx59QrxpyGzUgg+HJOWK7L7OMG2GnXcDSu+rSAYVPy/ydF0mUi
 0KTzg+pnCeeb+bqR1UjL1IsmiZRWiMiLaxG+tSFk6Dxni0ZhQdybSrs4pHN9JRZpY80U
 AlTQ8TzVZsxO8T0HTWO91sJdxnjgBdg3qkemsktXHXj057H8IdF+OgQ01PCiDFrGuGV2
 2ra98YwRfueHtPCP7laHo8+Go7/Y8yNgte6P2NVdYWpFCOB7SpcZisrsGW9HD5X65QEM
 fyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701185074; x=1701789874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QIs1sbtj+BmbWiuWD5CNEyM9R5uBGlfBWwIq3YbS0Hk=;
 b=vdv8gCMcgIRFa752WBUuh8kJlRyDbdwKFPHTQgNoMsJZJlv+skhcvbtF6DrmOf7qGC
 kkQoAlFfuqM7SMJ+jvAOfnVPyUecX5W0u5B1xuL0WL5mhZZHIjCOfpTNVIqhrvFesRI1
 aT6DewJmZj0Bgf40tHYjr5UMBlrmnMpDFU3TqQMyIZjfBRWKnGVtp4pwjTLnEablYD+p
 XtFeELNdZ3UFdNxaJ6TdmYeX6VmpMNc5NDaurYknVlRTodKLgkJJXKCsCh2HaEdlozXo
 jics30CFurOltV+ZlEzTxQaXmbwWEfLj2mdqRC0fJC7xq/EZkwjUKSRHb5K/Es6rrPEh
 gOjw==
X-Gm-Message-State: AOJu0YxCn5XJjkGPx6PR+rq83j/FLgtCSDJrl+4PSiZXdG7kfEmv65n2
 tIHMoR7gbUEnv/83Tg8nmZupT07ZE1PJCtWfw/RTk+Q+
X-Google-Smtp-Source: AGHT+IGxKeEANmQwfDAsWOCqJH1PqiinhFJwXVnB3cKCcvA01/omthKgXN/nRSEmSMhyEzA9hbs0Zw==
X-Received: by 2002:a17:902:be12:b0:1c3:1f0c:fb82 with SMTP id
 r18-20020a170902be1200b001c31f0cfb82mr15244660pls.41.1701185073166; 
 Tue, 28 Nov 2023 07:24:33 -0800 (PST)
Received: from localhost.localdomain ([171.216.139.230])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170902d50b00b001c5fe217fb9sm10385453plg.267.2023.11.28.07.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:24:32 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v2] crypto: Introduce SM4 symmetric cipher algorithm
Date: Tue, 28 Nov 2023 23:24:22 +0800
Message-Id: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
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

Use the crypto-sm4 meson build option for enabling this feature.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c             | 11 ++++++++
 crypto/cipher-gcrypt.c.inc      |  8 ++++++
 crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
 crypto/cipher.c                 |  6 ++++
 meson.build                     | 23 ++++++++++++++++
 meson_options.txt               |  2 ++
 qapi/crypto.json                |  5 +++-
 scripts/meson-buildoptions.sh   |  3 ++
 tests/unit/test-crypto-cipher.c | 13 +++++++++
 9 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index fb01ec38bb..f0813d69b4 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -95,12 +95,23 @@ qcrypto_block_luks_cipher_size_map_twofish[] = {
     { 0, 0 },
 };
 
+#ifdef CONFIG_CRYPTO_SM4
+static const QCryptoBlockLUKSCipherSizeMap
+qcrypto_block_luks_cipher_size_map_sm4[] = {
+    { 16, QCRYPTO_CIPHER_ALG_SM4},
+    { 0, 0 },
+};
+#endif
+
 static const QCryptoBlockLUKSCipherNameMap
 qcrypto_block_luks_cipher_name_map[] = {
     { "aes", qcrypto_block_luks_cipher_size_map_aes },
     { "cast5", qcrypto_block_luks_cipher_size_map_cast5 },
     { "serpent", qcrypto_block_luks_cipher_size_map_serpent },
     { "twofish", qcrypto_block_luks_cipher_size_map_twofish },
+#ifdef CONFIG_CRYPTO_SM4
+    { "sm4", qcrypto_block_luks_cipher_size_map_sm4},
+#endif
 };
 
 QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) != 48);
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
index a6a0117717..1377cbaf14 100644
--- a/crypto/cipher-gcrypt.c.inc
+++ b/crypto/cipher-gcrypt.c.inc
@@ -35,6 +35,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_SERPENT_256:
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+#ifdef CONFIG_CRYPTO_SM4
+    case QCRYPTO_CIPHER_ALG_SM4:
+#endif
         break;
     default:
         return false;
@@ -219,6 +222,11 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
         gcryalg = GCRY_CIPHER_TWOFISH;
         break;
+#ifdef CONFIG_CRYPTO_SM4
+    case QCRYPTO_CIPHER_ALG_SM4:
+        gcryalg = GCRY_CIPHER_SM4;
+        break;
+#endif
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
                    QCryptoCipherAlgorithm_str(alg));
diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 24cc61f87b..42b39e18a2 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -33,6 +33,9 @@
 #ifndef CONFIG_QEMU_PRIVATE_XTS
 #include <nettle/xts.h>
 #endif
+#ifdef CONFIG_CRYPTO_SM4
+#include <nettle/sm4.h>
+#endif
 
 static inline bool qcrypto_length_check(size_t len, size_t blocksize,
                                         Error **errp)
@@ -426,6 +429,30 @@ DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
                        QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
                        twofish_encrypt_native, twofish_decrypt_native)
 
+#ifdef CONFIG_CRYPTO_SM4
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
+#endif
 
 bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
                              QCryptoCipherMode mode)
@@ -443,6 +470,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
     case QCRYPTO_CIPHER_ALG_TWOFISH_128:
     case QCRYPTO_CIPHER_ALG_TWOFISH_192:
     case QCRYPTO_CIPHER_ALG_TWOFISH_256:
+#ifdef CONFIG_CRYPTO_SM4
+    case QCRYPTO_CIPHER_ALG_SM4:
+#endif
         break;
     default:
         return false;
@@ -701,6 +731,25 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
 
             return &ctx->base;
         }
+#ifdef CONFIG_CRYPTO_SM4
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
+#endif
 
     default:
         error_setg(errp, "Unsupported cipher algorithm %s",
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 74b09a5b26..5f512768ea 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -38,6 +38,9 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 24,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
+#ifdef CONFIG_CRYPTO_SM4
+    [QCRYPTO_CIPHER_ALG_SM4] = 16,
+#endif
 };
 
 static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
@@ -53,6 +56,9 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 16,
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
+#ifdef CONFIG_CRYPTO_SM4
+    [QCRYPTO_CIPHER_ALG_SM4] = 16,
+#endif
 };
 
 static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
diff --git a/meson.build b/meson.build
index ec01f8b138..256d3257bb 100644
--- a/meson.build
+++ b/meson.build
@@ -1480,6 +1480,7 @@ endif
 gcrypt = not_found
 nettle = not_found
 hogweed = not_found
+crypto_sm4 = not_found
 xts = 'none'
 
 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
@@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()
       xts = 'private'
     endif
   endif
+  if get_option('crypto_sm4').enabled()
+    if get_option('gcrypt').enabled()
+      # SM4 ALG is available in libgcrypt >= 1.9
+      crypto_sm4 = dependency('libgcrypt', version: '>=1.9',
+                              method: 'config-tool',
+                              required: get_option('gcrypt'))
+      # SM4 ALG static compilation
+      if crypto_sm4.found() and get_option('prefer_static')
+        crypto_sm4 = declare_dependency(dependencies: [
+          crypto_sm4,
+          cc.find_library('gpg-error', required: true)],
+          version: crypto_sm4.version())
+      endif
+    else
+      # SM4 ALG is available in nettle >= 3.9
+      crypto_sm4 = dependency('nettle', version: '>=3.9',
+                              method: 'pkg-config',
+                              required: get_option('nettle'))
+    endif
+  endif
 endif
 
 gmp = dependency('gmp', required: false, method: 'pkg-config')
@@ -2199,6 +2220,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
+config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
@@ -4273,6 +4295,7 @@ summary_info += {'nettle':            nettle}
 if nettle.found()
    summary_info += {'  XTS':             xts != 'private'}
 endif
+summary_info += {'SM4 ALG support':   crypto_sm4}
 summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
diff --git a/meson_options.txt b/meson_options.txt
index c9baeda639..db8de4ec5b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -172,6 +172,8 @@ option('nettle', type : 'feature', value : 'auto',
        description: 'nettle cryptography support')
 option('gcrypt', type : 'feature', value : 'auto',
        description: 'libgcrypt cryptography support')
+option('crypto_sm4', type : 'feature', value : 'auto',
+       description: 'SM4 symmetric cipher algorithm support')
 option('crypto_afalg', type : 'feature', value : 'disabled',
        description: 'Linux AF_ALG crypto backend driver')
 option('libdaxctl', type : 'feature', value : 'auto',
diff --git a/qapi/crypto.json b/qapi/crypto.json
index fd3d46ebd1..2f2aeff5fd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -94,6 +94,8 @@
 #
 # @twofish-256: Twofish with 256 bit / 32 byte keys
 #
+# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)
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
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..f189f34829 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -106,6 +106,7 @@ meson_options_help() {
   printf "%s\n" '  colo-proxy      colo-proxy support'
   printf "%s\n" '  coreaudio       CoreAudio sound support'
   printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
+  printf "%s\n" '  crypto-sm4      SM4 symmetric cipher algorithm support'
   printf "%s\n" '  curl            CURL block device driver'
   printf "%s\n" '  curses          curses UI'
   printf "%s\n" '  dbus-display    -display dbus support'
@@ -282,6 +283,8 @@ _meson_option_parse() {
     --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=false ;;
     --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=enabled ;;
     --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=disabled ;;
+    --enable-crypto-sm4) printf "%s" -Dcrypto_sm4=enabled ;;
+    --disable-crypto-sm4) printf "%s" -Dcrypto_sm4=disabled ;;
     --enable-curl) printf "%s" -Dcurl=enabled ;;
     --disable-curl) printf "%s" -Dcurl=disabled ;;
     --enable-curses) printf "%s" -Dcurses=enabled ;;
diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index d9d9d078ff..11ab1a54fc 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -382,6 +382,19 @@ static QCryptoCipherTestData test_data[] = {
         .plaintext = "90afe91bb288544f2c32dc239b2635e6",
         .ciphertext = "6cb4561c40bf0a9705931cb6d408e7fa",
     },
+#ifdef CONFIG_CRYPTO_SM4
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
+#endif
     {
         /* #1 32 byte key, 32 byte PTX */
         .path = "/crypto/cipher/aes-xts-128-1",
-- 
2.39.1


