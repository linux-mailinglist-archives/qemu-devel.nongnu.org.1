Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6AD973DA6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Sep 2024 18:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41l-00078Z-7k; Tue, 10 Sep 2024 12:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41Z-0006mG-0i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41U-0007Yz-Pf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7skFJZCEQ+/qGT73BeWIdkvXRnSdSNsKlxhz2l2CaQ=;
 b=fb44cXulWV2UArW1NQH4myhdEt8lmxmdvImGtQViAL2r+WrS8+n8mFOz0Q+9KrKee50eLC
 NqEEZV/ygHxRBtHs4f4o2aVMvPMqiD9Ep8j5sHMXK4Qrwf1yo//2vNCkkXztp/Ev61LCaO
 +37pYCIx+kRgSm00kaQA97Uzws6n4tE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-TfHpH4kNPP6ExrdaIus-Tw-1; Tue,
 10 Sep 2024 12:47:21 -0400
X-MC-Unique: TfHpH4kNPP6ExrdaIus-Tw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFC581953956; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 055B43000239; Tue, 10 Sep 2024 16:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 826C721E688F; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/19] qapi/crypto: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:47:00 +0200
Message-ID: <20240910164714.1993531-6-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added two temporary 'prefix' to delay changing the generated
code.

Revert them.  This improves QCryptoBlockFormat's generated enumeration
constant prefix from Q_CRYPTO_BLOCK_FORMAT to QCRYPTO_BLOCK_FORMAT,
and QCryptoBlockLUKSKeyslotState's from
Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE to QCRYPTO_BLOCK_LUKS_KEYSLOT_STATE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240904111836.3273842-6-armbru@redhat.com>
---
 qapi/crypto.json               |  2 --
 block/crypto.c                 | 10 +++++-----
 block/qcow.c                   |  2 +-
 block/qcow2.c                  | 10 +++++-----
 crypto/block-luks.c            |  4 ++--
 crypto/block.c                 |  4 ++--
 tests/unit/test-crypto-block.c | 14 +++++++-------
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index a192641a03..fb00c706b2 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -157,7 +157,6 @@
 # Since: 2.6
 ##
 { 'enum': 'QCryptoBlockFormat',
-  'prefix': 'Q_CRYPTO_BLOCK_FORMAT', # TODO drop
   'data': ['qcow', 'luks']}
 
 ##
@@ -360,7 +359,6 @@
 # Since: 5.1
 ##
 { 'enum': 'QCryptoBlockLUKSKeyslotState',
-  'prefix': 'Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE', # TODO drop
   'data': [ 'active', 'inactive' ] }
 
 ##
diff --git a/block/crypto.c b/block/crypto.c
index 4eed3ffa6a..80b2dba17a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -682,7 +682,7 @@ err:
 static int block_crypto_probe_luks(const uint8_t *buf,
                                    int buf_size,
                                    const char *filename) {
-    return block_crypto_probe_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    return block_crypto_probe_generic(QCRYPTO_BLOCK_FORMAT_LUKS,
                                       buf, buf_size, filename);
 }
 
@@ -691,7 +691,7 @@ static int block_crypto_open_luks(BlockDriverState *bs,
                                   int flags,
                                   Error **errp)
 {
-    return block_crypto_open_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    return block_crypto_open_generic(QCRYPTO_BLOCK_FORMAT_LUKS,
                                      &block_crypto_runtime_opts_luks,
                                      bs, options, flags, errp);
 }
@@ -724,7 +724,7 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     }
 
     create_opts = (QCryptoBlockCreateOptions) {
-        .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .format = QCRYPTO_BLOCK_FORMAT_LUKS,
         .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
     };
 
@@ -889,7 +889,7 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
     if (!info) {
         return NULL;
     }
-    assert(info->format == Q_CRYPTO_BLOCK_FORMAT_LUKS);
+    assert(info->format == QCRYPTO_BLOCK_FORMAT_LUKS);
 
     spec_info = g_new(ImageInfoSpecific, 1);
     spec_info->type = IMAGE_INFO_SPECIFIC_KIND_LUKS;
@@ -1002,7 +1002,7 @@ coroutine_fn block_crypto_co_amend_luks(BlockDriverState *bs,
     QCryptoBlockAmendOptions amend_opts;
 
     amend_opts = (QCryptoBlockAmendOptions) {
-        .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .format = QCRYPTO_BLOCK_FORMAT_LUKS,
         .u.luks = *qapi_BlockdevAmendOptionsLUKS_base(&opts->u.luks),
     };
     return block_crypto_amend_options_generic_luks(bs, &amend_opts,
diff --git a/block/qcow.c b/block/qcow.c
index c2f89db055..84d1cca296 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -831,7 +831,7 @@ qcow_co_create(BlockdevCreateOptions *opts, Error **errp)
     }
 
     if (qcow_opts->encrypt &&
-        qcow_opts->encrypt->format != Q_CRYPTO_BLOCK_FORMAT_QCOW)
+        qcow_opts->encrypt->format != QCRYPTO_BLOCK_FORMAT_QCOW)
     {
         error_setg(errp, "Unsupported encryption format");
         return -EINVAL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 70b19730a3..dd359d241b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3214,10 +3214,10 @@ qcow2_set_up_encryption(BlockDriverState *bs,
     int fmt, ret;
 
     switch (cryptoopts->format) {
-    case Q_CRYPTO_BLOCK_FORMAT_LUKS:
+    case QCRYPTO_BLOCK_FORMAT_LUKS:
         fmt = QCOW_CRYPT_LUKS;
         break;
-    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+    case QCRYPTO_BLOCK_FORMAT_QCOW:
         fmt = QCOW_CRYPT_AES;
         break;
     default:
@@ -5306,10 +5306,10 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
         ImageInfoSpecificQCow2Encryption *qencrypt =
             g_new(ImageInfoSpecificQCow2Encryption, 1);
         switch (encrypt_info->format) {
-        case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+        case QCRYPTO_BLOCK_FORMAT_QCOW:
             qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_AES;
             break;
-        case Q_CRYPTO_BLOCK_FORMAT_LUKS:
+        case QCRYPTO_BLOCK_FORMAT_LUKS:
             qencrypt->format = BLOCKDEV_QCOW2_ENCRYPTION_FORMAT_LUKS;
             qencrypt->u.luks = encrypt_info->u.luks;
             break;
@@ -5948,7 +5948,7 @@ static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
             return -EOPNOTSUPP;
         }
 
-        if (qopts->encrypt->format != Q_CRYPTO_BLOCK_FORMAT_LUKS) {
+        if (qopts->encrypt->format != QCRYPTO_BLOCK_FORMAT_LUKS) {
             error_setg(errp,
                        "Amend can't be used to change the qcow2 encryption format");
             return -EOPNOTSUPP;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 45347adeeb..7b9c7b292d 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1861,11 +1861,11 @@ qcrypto_block_luks_amend_options(QCryptoBlock *block,
     QCryptoBlockAmendOptionsLUKS *opts_luks = &options->u.luks;
 
     switch (opts_luks->state) {
-    case Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE_ACTIVE:
+    case QCRYPTO_BLOCK_LUKS_KEYSLOT_STATE_ACTIVE:
         return qcrypto_block_luks_amend_add_keyslot(block, readfunc,
                                                     writefunc, opaque,
                                                     opts_luks, force, errp);
-    case Q_CRYPTO_BLOCKLUKS_KEYSLOT_STATE_INACTIVE:
+    case QCRYPTO_BLOCK_LUKS_KEYSLOT_STATE_INACTIVE:
         return qcrypto_block_luks_amend_erase_keyslots(block, readfunc,
                                                        writefunc, opaque,
                                                        opts_luks, force, errp);
diff --git a/crypto/block.c b/crypto/block.c
index 3bcc4270c3..899561a080 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -26,8 +26,8 @@
 #include "block-luks.h"
 
 static const QCryptoBlockDriver *qcrypto_block_drivers[] = {
-    [Q_CRYPTO_BLOCK_FORMAT_QCOW] = &qcrypto_block_driver_qcow,
-    [Q_CRYPTO_BLOCK_FORMAT_LUKS] = &qcrypto_block_driver_luks,
+    [QCRYPTO_BLOCK_FORMAT_QCOW] = &qcrypto_block_driver_qcow,
+    [QCRYPTO_BLOCK_FORMAT_LUKS] = &qcrypto_block_driver_luks,
 };
 
 
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 42cfab6067..2a6c6e99e5 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -39,14 +39,14 @@
 #endif
 
 static QCryptoBlockCreateOptions qcow_create_opts = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_QCOW,
+    .format = QCRYPTO_BLOCK_FORMAT_QCOW,
     .u.qcow = {
         .key_secret = (char *)"sec0",
     },
 };
 
 static QCryptoBlockOpenOptions qcow_open_opts = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_QCOW,
+    .format = QCRYPTO_BLOCK_FORMAT_QCOW,
     .u.qcow = {
         .key_secret = (char *)"sec0",
     },
@@ -55,7 +55,7 @@ static QCryptoBlockOpenOptions qcow_open_opts = {
 
 #ifdef TEST_LUKS
 static QCryptoBlockOpenOptions luks_open_opts = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    .format = QCRYPTO_BLOCK_FORMAT_LUKS,
     .u.luks = {
         .key_secret = (char *)"sec0",
     },
@@ -64,7 +64,7 @@ static QCryptoBlockOpenOptions luks_open_opts = {
 
 /* Creation with all default values */
 static QCryptoBlockCreateOptions luks_create_opts_default = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    .format = QCRYPTO_BLOCK_FORMAT_LUKS,
     .u.luks = {
         .key_secret = (char *)"sec0",
     },
@@ -73,7 +73,7 @@ static QCryptoBlockCreateOptions luks_create_opts_default = {
 
 /* ...and with explicit values */
 static QCryptoBlockCreateOptions luks_create_opts_aes256_cbc_plain64 = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    .format = QCRYPTO_BLOCK_FORMAT_LUKS,
     .u.luks = {
         .key_secret = (char *)"sec0",
         .has_cipher_alg = true,
@@ -87,7 +87,7 @@ static QCryptoBlockCreateOptions luks_create_opts_aes256_cbc_plain64 = {
 
 
 static QCryptoBlockCreateOptions luks_create_opts_aes256_cbc_essiv = {
-    .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+    .format = QCRYPTO_BLOCK_FORMAT_LUKS,
     .u.luks = {
         .key_secret = (char *)"sec0",
         .has_cipher_alg = true,
@@ -572,7 +572,7 @@ int main(int argc, char **argv)
     g_assert(qcrypto_init(NULL) == 0);
 
     for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        if (test_data[i].open_opts->format == Q_CRYPTO_BLOCK_FORMAT_LUKS &&
+        if (test_data[i].open_opts->format == QCRYPTO_BLOCK_FORMAT_LUKS &&
             !qcrypto_hash_supports(test_data[i].hash_alg)) {
             continue;
         }
-- 
2.46.0


