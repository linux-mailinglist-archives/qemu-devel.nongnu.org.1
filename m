Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DE81DE5A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoS-0004gv-Re; Mon, 25 Dec 2023 00:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoQ-0004gk-BR
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:38 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoO-00023U-Um
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:38 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bb82a52002so3157178b6e.2
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483134; x=1704087934;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdL9uW9EvZjhGBTaXUAVF2PzM+GCkP3v2dbTBdBWS6M=;
 b=aoIfUzjeNZCRR3pD0vqOaROkbrqNFbpjgHRl4i7FJ9XJAMmFIINlSD5Q+O4bBDx15F
 yWklm21IMGPvHfsapYmaFhyC770AFUJcnTrHsEclCjt5pPysEzwDg98yV3ZE5Rmiox6j
 6qogHm7XNnYrFLN/WMOiqOyJxTdsYxHqaL0xCr3yxAMPUuijNiLGGjfrWNimsA+uAq3D
 eGCSYOb6uwvasCF42Bti0wNtmsSGihFY6zRltTUfwqrqVkpOHvQtOXrfuV9Z/rNm13lX
 F7iaMn1P1P4AR146qQl5h9H7yJ4N18D/SISktyuuADqHA0JLXA1PGf61G7PTvQfJMAHI
 U97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483134; x=1704087934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdL9uW9EvZjhGBTaXUAVF2PzM+GCkP3v2dbTBdBWS6M=;
 b=PWo7ahgNHr4yr9/y1h983LgoyabCfP8NLSqRlOPVhQoyIcFNrwZ+TpG5cL89PRVx9e
 YLXnkIMCE0ej7bMbXd7kvmsvaWjV0EzJvWCLflsG2WCuQJRx5S0v7vDBjg8buXJ9f6f8
 eG6zQAaIPb459wjI1qqynl6VtCG6BJTK3puZ3XLpXw5U4JiC1qi+7ISsax2jo2DPQ+dM
 rJd6vyr7VH9mU0ZVOq4RU9CENlCBzGxM85+PLKDmP1RmXxBip6LVGv5eo+1sI+UP1Zz5
 dXaCX4rApQV5XyVnbGq8wfpMPhj8sJnnMTF24b5tjO8T2DidipTO3qmB4IRnWD3ujive
 HsdA==
X-Gm-Message-State: AOJu0YxwNaKteKKeY4ckhqsKrU78Gywy14jqJOV/yb9539bqbBY+1Qwb
 VD3yO3264bV1ukL5VWd/jDLih3R2Q3etTeIb1j9D4nCGd1MFgA==
X-Google-Smtp-Source: AGHT+IGXm0QUrJSRzkJKth00XkBg6Khj8uorx2qkm7s+1A5sZw+nDJVkS5BpjQNXThcrq2QQ6jBO4w==
X-Received: by 2002:a05:6808:1186:b0:3bb:6cf0:fce0 with SMTP id
 j6-20020a056808118600b003bb6cf0fce0mr7067688oil.34.1703483134042; 
 Sun, 24 Dec 2023 21:45:34 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:33 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 03/10] qapi: Make parameter 'file' optional for
 BlockdevCreateOptionsLUKS
Date: Mon, 25 Dec 2023 13:45:05 +0800
Message-Id: <720f901d0df6ecb2da94c48c38b0abde933c3429.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x229.google.com
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


