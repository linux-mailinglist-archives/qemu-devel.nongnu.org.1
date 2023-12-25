Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9381DE3D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdWw-000526-UM; Mon, 25 Dec 2023 00:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWv-00051h-I1
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:33 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWu-0007Hr-2g
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:33 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6dbbef36fe0so1939064a34.2
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482050; x=1704086850;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdL9uW9EvZjhGBTaXUAVF2PzM+GCkP3v2dbTBdBWS6M=;
 b=HrP3ywen1hcVnhJ4VqhHAHGfvRJmjCi/o5J4U8rzDspk4xc69JPXgm9dCmU29mTMwX
 w6FrguwPplYXd5S2ZOhaRuGe9up9toGlq2l+BHqRTtAMic82kaRR1EnR3iklV2wdWZIN
 AApDJa6wCrE8p8QJI8MMQoSJldvSXvb0iJPz83VIhcmRcZqoFzTwDs5MlUnbK3iFi7oY
 6QDSuVdHSjbI7iaJl9EfJd8/N1TG/i2WVE1X7ivUsThuxI5shypao291qHTdYtRiJ01i
 mL8Y9AYHLjXIE0cEzhP9KLeD5bW3g7ghhb9hmnrdeor0k6Idn099cvlt2WR/snoGvgTL
 h+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482050; x=1704086850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdL9uW9EvZjhGBTaXUAVF2PzM+GCkP3v2dbTBdBWS6M=;
 b=mq0R6+6kCh7DQEDcM+b+1R04HqmSxf6XBXsk+zGPt6frvLNDEbyhq4bR6u8RkTl+1l
 SDRHPl4Lh4NKD2u7elIh+9c/TMu0lQTx7qPoxXVneXAyCYYPJ3oNCZ4Bl37Z3+TYxp0t
 HNnq7LtH76QmBNB46uuT+W/hCoIvDhUiY09akHzZhqou3eW2roKo62RSH/AYk0ii/dGD
 5i05XnCpskdvM8wvJHMHq382wC6CV+O6iYLVb4KQUjsFsUeO/Jz2QRXM7BzdZhLQXYqL
 fHDJG+nKSBOSM/QuN/Xc6mXc1nhaR2ZBE4FeCabeSGr9UajsZQEYacJ6AtUrlqz8hPUX
 6Kgg==
X-Gm-Message-State: AOJu0Yw5S/K+kt8RYBTHAZ8vqEe0RYICc2lrNFbUxja9AGhYkvuhnQET
 /RjrQrOc1zOR6tFZTGlLAMibLpzBFq8L/9ygJPeY67P3sD79mw==
X-Google-Smtp-Source: AGHT+IGWceJBTn9b+2C4Qcv6L783T9lDBBSJ3YpX/1c2H5jHCtxEMG24PSY2ksplNpFaVI5SzoKUjw==
X-Received: by 2002:a9d:62d9:0:b0:6da:2edf:30de with SMTP id
 z25-20020a9d62d9000000b006da2edf30demr3670315otk.40.1703482050372; 
 Sun, 24 Dec 2023 21:27:30 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:29 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 03/10] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
Date: Mon, 25 Dec 2023 13:26:53 +0800
Message-Id: <720f901d0df6ecb2da94c48c38b0abde933c3429.1703481380.git.yong.huang@smartx.com>
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

To support detached LUKS header creation, make the existing 'file'
filed in BlockdevCreateOptionsLUKS optional, while also adding an
extra optional 'header' field in the next commit.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c       | 21 ++++++++++++++-------
 qapi/block-core.json |  5 +++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6063879bac..78fbe79c95 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -659,9 +659,9 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
-    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
-    if (bs == NULL) {
-        return -EIO;
+    if (luks_opts->file == NULL) {
+        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
+        return -EINVAL;
     }
 
     create_opts = (QCryptoBlockCreateOptions) {
@@ -673,10 +673,17 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
-                                         preallocation, errp);
-    if (ret < 0) {
-        goto fail;
+    if (luks_opts->file) {
+        bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
+        if (bs == NULL) {
+            return -EIO;
+        }
+
+        ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
+                                             preallocation, errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     ret = 0;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 10be08d08f..9ac256c489 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4945,7 +4945,8 @@
 #
 # Driver specific image creation options for LUKS.
 #
-# @file: Node to create the image format on
+# @file: Node to create the image format on, mandatory except when
+#        'preallocation' is not requested
 #
 # @size: Size of the virtual disk in bytes
 #
@@ -4956,7 +4957,7 @@
 ##
 { 'struct': 'BlockdevCreateOptionsLUKS',
   'base': 'QCryptoBlockCreateOptionsLUKS',
-  'data': { 'file':             'BlockdevRef',
+  'data': { '*file':            'BlockdevRef',
             'size':             'size',
             '*preallocation':   'PreallocMode' } }
 
-- 
2.39.1


