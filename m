Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9081DE5C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoj-0004lK-0f; Mon, 25 Dec 2023 00:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdog-0004lA-0t
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:54 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdod-00027A-W6
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:53 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bb8f3d9f98so2295822b6e.3
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483150; x=1704087950;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bld8BoqgmZ1DODtactYuR62piREfvI2piUdxD5IPPLM=;
 b=bxLx4wV+hrUyJNTTVuQ+jE2uOwLl2VKMCANbqmwVj1caPFvPKJo5MQyAyyQF/tpIVq
 7fTkwh8cj1y4eK9DEFtSzd1GkDr0lJnDeT3BfHn9l3AfWR78vlerTNcWrKGu1be8XB+4
 4P1P5G4ivv7jKADlph0Bbu8cg2die+1LI+q1yNs7W8Ec5V33Wnn0PeClpowUj6VFGmI3
 Qv+ISWAo5u1iPOO2wT0TxZocTc4j2sfsoLti/LO1Yi2q3N4adFKS412/BJFJU2NXHzhQ
 9kJEWyBaMOT6ZAfWsmMTLfDRtXjSPplOJnCUaQiDYItq+o2j+EPwOCIACPolU1q8SDuC
 V6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483150; x=1704087950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bld8BoqgmZ1DODtactYuR62piREfvI2piUdxD5IPPLM=;
 b=YMmS37uVsfx6wO699yp5uxjogVJ96m+n7vt4G64CmPF2ozlKS7ptLc3R4iaxGe3Lzr
 Jh9le7k7bqdZlSqKDntkxPxyvUkd+dIM4M472K7FLx/FfIdE5EAFGs87rJo+LUhR7Z0u
 aFUloZl3yh72k/7d4snb6G6UWGKyflD78KeLszvh2OPDTRG3KXssFBkhQzmwzkeNyRbe
 HSNBuuiAhp0Sqers4MujwjtapqrxRu4naCIiBb/rd/EcMMtnyMtameqTBkkdJHrV2CrD
 0Sxb/CGIYm3jugq0z8ST3MQxBDMdJZtepjtmVvl8N2WbfacRy5P95GCMVjDwEak4tmNm
 dc+A==
X-Gm-Message-State: AOJu0YxiuME8hjNv+stqUcqkZ/j5vNV+BOTKQbLLL5HoWTm20yxlZf8N
 iV33jANiWLaVNW3UlSebx7t8SEut846JSfLtBulk9QY2VsR8nQ==
X-Google-Smtp-Source: AGHT+IFcbXY3bURXyeTcMUtuYPKTGcVQM5AkR06OiHR5XLFiv3ULzd1DLMaJF1/KucajAb4yDaYQTA==
X-Received: by 2002:a05:6808:1820:b0:3bb:73d6:f8b9 with SMTP id
 bh32-20020a056808182000b003bb73d6f8b9mr6919991oib.31.1703483150146; 
 Sun, 24 Dec 2023 21:45:50 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:49 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 07/10] block: Support detached LUKS header creation
 using qemu-img
Date: Mon, 25 Dec 2023 13:45:09 +0800
Message-Id: <3179dbd4232303c64906eeffa2912d09a0fdcbeb.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22c.google.com
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

Add the 'detached-mode' option to specify the creation of
a detached LUKS header. This is how it is used:
$ qemu-img create --object secret,id=sec0,data=abc123 -f luks
> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
> -o detached-mode=true header.luks

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block.c          | 5 ++++-
 block/crypto.c   | 9 ++++++++-
 block/crypto.h   | 8 ++++++++
 qapi/crypto.json | 5 ++++-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index bfb0861ec6..fa9ce36928 100644
--- a/block.c
+++ b/block.c
@@ -7517,7 +7517,10 @@ void bdrv_img_create(const char *filename, const char *fmt,
         goto out;
     }
 
-    if (size == -1) {
+    /* Parameter 'size' is not needed for detached LUKS header */
+    if (size == -1 &&
+        !(!strcmp(fmt, "luks") &&
+          qemu_opt_get_bool(opts, "detached-mode", false))) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 76cc8bda49..812c3c28f5 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -229,6 +229,7 @@ static QemuOptsList block_crypto_create_opts_luks = {
         BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
         BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_MODE(""),
         { /* end of list */ }
     },
 };
@@ -793,6 +794,8 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     PreallocMode prealloc;
     char *buf = NULL;
     int64_t size;
+    bool detached_mode =
+        qemu_opt_get_bool(opts, "detached-mode", false);
     int ret;
     Error *local_err = NULL;
 
@@ -832,8 +835,12 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
         goto fail;
     }
 
+   /* The detached_header default to true if detached-mode is specified */
+    create_opts->u.luks.detached_header = detached_mode ? true : false;
+
     /* Create format layer */
-    ret = block_crypto_co_create_generic(bs, size, create_opts, prealloc, errp);
+    ret = block_crypto_co_create_generic(bs, detached_mode ? 0 : size,
+                                         create_opts, prealloc, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/crypto.h b/block/crypto.h
index 72e792c9af..bceefd45bd 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -41,6 +41,7 @@
 #define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#define BLOCK_CRYPTO_OPT_LUKS_DETACHED_MODE "detached-mode"
 #define BLOCK_CRYPTO_OPT_LUKS_KEYSLOT "keyslot"
 #define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
 #define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
@@ -100,6 +101,13 @@
         .help = "Select new state of affected keyslots (active/inactive)",\
     }
 
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_DETACHED_MODE(prefix)     \
+    {                                                         \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_DETACHED_MODE, \
+        .type = QEMU_OPT_BOOL,                                \
+        .help = "Create a detached LUKS header",              \
+    }
+
 #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEYSLOT(prefix)              \
     {                                                          \
         .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEYSLOT,          \
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b4e86cb81..8e81aa8454 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -226,6 +226,8 @@
 # @iter-time: number of milliseconds to spend in PBKDF passphrase
 #     processing.  Currently defaults to 2000. (since 2.8)
 #
+# @detached-mode: create a detached LUKS header. (since 9.0)
+#
 # Since: 2.6
 ##
 { 'struct': 'QCryptoBlockCreateOptionsLUKS',
@@ -235,7 +237,8 @@
             '*ivgen-alg': 'QCryptoIVGenAlgorithm',
             '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
             '*hash-alg': 'QCryptoHashAlgorithm',
-            '*iter-time': 'int'}}
+            '*iter-time': 'int',
+            '*detached-mode': 'bool'}}
 
 ##
 # @QCryptoBlockOpenOptions:
-- 
2.39.1


