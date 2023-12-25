Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5481DE37
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdXE-000565-1b; Mon, 25 Dec 2023 00:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXC-00055n-9m
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:50 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXA-0007K1-Ne
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:50 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6dbed9bb54eso157630a34.3
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482067; x=1704086867;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bld8BoqgmZ1DODtactYuR62piREfvI2piUdxD5IPPLM=;
 b=oEq3manE1MTZfKK5CSltZmAW73sgBnital4Hp4AO5p6LjlV9fvL/XmdptZuqMLLI1t
 ABLQWe5NUhoeqG6ZHTxvyILbMPNSN2CI/4zkfZUqzA6iscpgQBwuksRpbVkE5R/3J6G/
 zrruupa8E64WC3oncoYqGt22jOPkQxuhHljlnzKjsQoK//P1E4dPNeQcZOUMrpWu3OBP
 VxbPVmztGsVT1ldxElwN/NYHvVWO5uqbcwLsFiEa9BnkBtsbPT33gjZTn4UcWB5rj9E9
 gAzauzMZ9Gp66St7FIhPBb3Aa3ZCR9hWjG6RlkvOAPtd2P+FxVFOAMn5gWBZFZe/4UZQ
 yE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482067; x=1704086867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bld8BoqgmZ1DODtactYuR62piREfvI2piUdxD5IPPLM=;
 b=iQNMxIyRIoUxQ7mbM8tkgoW+t1XcgSxqVSAX6D2QFeMbDqYM/vWZA12ebmhpQBdCrc
 bQ9nHS5AJJ3gHcoLpib6ChI7qzt0DdA2Fu33Y0zL+wvdTR3uNGyEog9W12uHDI25q4dO
 Ii7PmyrQyFDwm1oTmjbfNgy1Hz1lKBCu6Hzz7P1Cm8jQJAlw3bu9FFK0LP7SrnP+8U4g
 W8tNWKP21YYzzNSMwn94rcMdHdfHrdUOyNdEdhfpCvUPYKIgvvofIa3/4AlV5IaAspiC
 BgeHNWYxm/7T2oFTHtKVUDO7C0VSoBsiiYLOBIdK6PUosnYJ6ac6N7KfLPxAijbun3Nn
 CJgg==
X-Gm-Message-State: AOJu0YyVGpboEUuohAU/QKyMSAQ76tYUgLdX9F+08ZN0FSV8Ea2EFUHP
 3bdOgE+MGD7E/+2J+r5AHp0d/lEpHO0ZQfDRAC+To5GGM3EZIA==
X-Google-Smtp-Source: AGHT+IFqsOQZrHXQTnPAowZ0lbrQKWsFf7FgGEmoDaYo4eCOVYL8D4kYNcX8icIrTFA/FXfQ0kfQIw==
X-Received: by 2002:a05:6830:2701:b0:6d9:d3dc:231e with SMTP id
 j1-20020a056830270100b006d9d3dc231emr3647119otu.66.1703482066989; 
 Sun, 24 Dec 2023 21:27:46 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:46 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 07/10] block: Support detached LUKS header creation using qemu-img
Date: Mon, 25 Dec 2023 13:26:57 +0800
Message-Id: <3179dbd4232303c64906eeffa2912d09a0fdcbeb.1703481380.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32c.google.com
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


