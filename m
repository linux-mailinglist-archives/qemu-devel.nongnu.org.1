Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667998039CA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:10:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABVK-0006sF-BQ; Mon, 04 Dec 2023 11:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVH-0006pa-MV
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:03 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABV8-0005Hm-RB
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:03 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce3efb78e2so1773994b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706013; x=1702310813;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1QeiOhFy3aR8sUUfQkgHk63IJyiyAt+CbeADuDdbL0=;
 b=jabphSQR0piJnaKvIWeDcDtPxMEZAHMSDJ09P8H0NK9MCghtkuuxDl3Ri3JvPjjlUn
 r93GXvBjOGWASBZG8KlDfxGH59SMwHDA12KT9eIzHEHhUjGLdR3UBsymwtkqkHEzMrc+
 NgZZM+QoHjaUqhV12LrbEK6XAUrddxMaGC3+G3QGieisF2TilBNGk4tRaMZ5uXNKvL9v
 MhiZIxnbTU9E/ukQcyY+aq05/ZI36pDbfhMKyzSXRQDC3XgGfj3yxAcSaDsGYrvE14UP
 A7tkTwSbJ8krlrqeTL9AyJ0zOvuqimC/VmNaqFP/SDnibU1Zae2LXSy0aEvlMPkNMs+U
 n9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706013; x=1702310813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1QeiOhFy3aR8sUUfQkgHk63IJyiyAt+CbeADuDdbL0=;
 b=U+/LqBGoLCqcDVWJ81Hk241Gfppvppt4s1VpFJeuwR+mOG5oov+Nt0KC7Fo5fJBfqC
 p7rryXwmTdA16TcVScC3R/r1XQgRdz4iJ3QNRZ1rOTc34wiXFCvR/AdpEaOleEUaN1IL
 B428aKUCvsMO1wQFgkcoVC157plPlwu7agVC6EvijyDiidCbYX99n4EoUp8yvc/iLxWd
 skgLkPbrtWAvTlVROsoyZJjhHEh2sb9HA9xWV23B+KFnN4BLMio52MOQcsiM/NRviajo
 wi75+Kdee57JNGXmBOdAZWKmeRepDtgEV65PdkfLa3PmxmxpoNfIHNllqzKNoWk/7YRx
 qPbw==
X-Gm-Message-State: AOJu0YzbZOmekhvITh8b9kblFUDkqjcOy2dyLMPU9t/2GmLfS5PRKkZX
 flSTktwK6e9oYvgsVxFZcA04n0WmmB7MDno4nV8rLsaL
X-Google-Smtp-Source: AGHT+IGdBS90NTg8Ug8m0G305HsVDpnrwP4uMHSmgOGJGA2h6QwXbx9fykdVNFp8Y0lJbZ5Xi8qP9Q==
X-Received: by 2002:a05:6a00:1150:b0:6ce:2732:583 with SMTP id
 b16-20020a056a00115000b006ce27320583mr5056556pfm.52.1701706012830; 
 Mon, 04 Dec 2023 08:06:52 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:52 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 4/8] Gluks: Introduce Gluks options
Date: Tue,  5 Dec 2023 00:06:21 +0800
Message-Id: <b11dab3ce45427d8beb8ddf5afd60a3419965aab.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Similar to Luks, the Gluks format primarily recycles the
Luks choices with the exception of the "size" option.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c       |  4 ++--
 block/generic-luks.c | 18 ++++++++++++++++++
 block/generic-luks.h |  3 +++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6afae1de2e..6f8528dccc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -150,7 +150,7 @@ error:
 }
 
 
-static QemuOptsList block_crypto_runtime_opts_luks = {
+QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
@@ -181,7 +181,7 @@ static QemuOptsList block_crypto_create_opts_luks = {
 };
 
 
-static QemuOptsList block_crypto_amend_opts_luks = {
+QemuOptsList block_crypto_amend_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_create_opts_luks.head),
     .desc = {
diff --git a/block/generic-luks.c b/block/generic-luks.c
index f23e202991..ebc0365d40 100644
--- a/block/generic-luks.c
+++ b/block/generic-luks.c
@@ -35,6 +35,21 @@ typedef struct BDRVGLUKSState {
     uint64_t header_size;   /* In bytes */
 } BDRVGLUKSState;
 
+static QemuOptsList gluks_create_opts_luks = {
+    .name = "crypto",
+    .head = QTAILQ_HEAD_INITIALIZER(gluks_create_opts_luks.head),
+    .desc = {
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        { /* end of list */ }
+    },
+};
+
 static int gluks_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
@@ -71,6 +86,9 @@ static BlockDriver bdrv_generic_luks = {
     .bdrv_co_create_opts    = gluks_co_create_opts,
     .bdrv_child_perm        = gluks_child_perms,
     .bdrv_co_getlength      = gluks_co_getlength,
+
+    .create_opts            = &gluks_create_opts_luks,
+    .amend_opts             = &block_crypto_amend_opts_luks,
 };
 
 static void block_generic_luks_init(void)
diff --git a/block/generic-luks.h b/block/generic-luks.h
index 2aae866fa4..f18adf41ea 100644
--- a/block/generic-luks.h
+++ b/block/generic-luks.h
@@ -23,4 +23,7 @@
 #ifndef GENERIC_LUKS_H
 #define GENERIC_LUKS_H
 
+extern QemuOptsList block_crypto_runtime_opts_luks;
+extern QemuOptsList block_crypto_amend_opts_luks;
+
 #endif /* GENERIC_LUKS_H */
-- 
2.39.1


