Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C024A81DE59
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdoe-0004kr-02; Mon, 25 Dec 2023 00:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdob-0004ka-MM
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:49 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdoZ-000263-Jw
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:47:49 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6dbf0561f8bso72724a34.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703483146; x=1704087946;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3ApTkAuvEEyKhHkfQqZ7GJ+q36mBNZFj8dE6xUr2+E=;
 b=OcCze2SSguuFK+ppbRmWJzrUwihKy94CwLan7Rbz3x56wowM8ao+WkK36gUUHn2kAm
 bmaYCdTXWVqljh9UPdkf5kV4ZC2y2OwA/eDnvuSnP/7O47FHRIXvpB+OPGOMt0cYhs8I
 wtjCYXq+XbfYruZgDbVxiLVCA3NlRfPphDBYAGKObOB9TyvokaLyvsUk/brIhIpRBMio
 +HzT4W/VCIPzxbuFsux2izZxZEcYJ7lSgMls5HI/7uofJZ8gJA5Sfz5KI8PPwzEvKSgE
 n0ShKsJf28lA4f82ta5HBA1HvtQF7mMw2ikWpyG0nZ0p86cS1Oa5SFnq5f47JX96qRcA
 FJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703483146; x=1704087946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3ApTkAuvEEyKhHkfQqZ7GJ+q36mBNZFj8dE6xUr2+E=;
 b=ESEmXDmu0GpTk7a3W2W5IOI9BBkNGJ50XvcRJukBpAn2qMFhmhnAA6OdccQCsctbmj
 NPiptrGQxbzPPZCf37OhjJENgCZJrEv5EDHPS7A1k0LeskaRs1TpGfUhqP7IjNF+cez0
 1tT4mobTmQ1jk+iRiFu7cGUdD+ZdOsycUeHNVbbLnpo0pJQdeuh9SySi332KY14ZMi+9
 eECirzVrJDKEqnPV5fb3r5HClp92YuYNZXRkarxmcGX6C08TN01IOS4P4ExZy5vsEKEU
 u7PEgE9CUU229wNpNka1+YgVeKpwJjHR5OkPe7/Ms0TuEL4vfyp/O0KuwYYUchpGmNeD
 IeCA==
X-Gm-Message-State: AOJu0YwNGygG8hfywPZa5HVOcdESpaLZW0nPt2UD89NMYshP+YlrEXJP
 0aQ34mu55tBA7VdkUJKywlbEeBaUCPxKXQ0OPfXDQax1tVotbQ==
X-Google-Smtp-Source: AGHT+IHeuKnwFrDANsHUX35HsKcroE3SYkcAFePM06XJmrn99p6MR9rw+/KxujMXUumLLGE/1VZGQQ==
X-Received: by 2002:a9d:7cc9:0:b0:6db:dbdf:727f with SMTP id
 r9-20020a9d7cc9000000b006dbdbdf727fmr991400otn.0.1703483145837; 
 Sun, 24 Dec 2023 21:45:45 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a056a00191600b006cef521b151sm7342415pfi.168.2023.12.24.21.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:45:45 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH RESEND v3 06/10] block: Support detached LUKS header creation
 using blockdev-create
Date: Mon, 25 Dec 2023 13:45:08 +0800
Message-Id: <20ab47b728492cedb7ea671239f0397a141c3f5a.1703482349.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703482349.git.yong.huang@smartx.com>
References: <cover.1703482349.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x332.google.com
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

The LUKS disk with detached header consists of a separate LUKS
header and payload. This LUKS disk type should be formatted
as follows:

1. add the secret to lock/unlock the cipher stored in the
   detached LUKS header
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type": "secret", "id": "sec0", "data": "foo"}}'

2. create a header img with 0 size
$ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> "arguments":{"job-id":"job0", "options":{"driver":"file",
> "filename":"/path/to/detached_luks_header.img", "size":0 }}}'

3. add protocol blockdev node for header
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments": {"driver":"file", "filename":
> "/path/to/detached_luks_header.img", "node-name":
> "detached-luks-header-storage"}}'

4. create a payload img with 0 size
$ virsh qemu-monitor-command vm '{"execute":"blockdev-create",
> "arguments":{"job-id":"job1", "options":{"driver":"file",
> "filename":"/path/to/detached_luks_payload_raw.img", "size":0}}}'

5. add protocol blockdev node for payload
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments": {"driver":"file", "filename":
> "/path/to/detached_luks_payload_raw.img", "node-name":
> "luks-payload-raw-storage"}}'

6. do the formatting with 128M size
$ virsh qemu-monitor-command c81_node1 '{"execute":"blockdev-create",
> "arguments":{"job-id":"job2", "options":{"driver":"luks", "header":
> "detached-luks-header-storage", "file":"luks-payload-raw-storage",
> "size":134217728, "preallocation":"full", "key-secret":"sec0" }}}'

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c      | 109 ++++++++++++++++++++++++++++++++++++++++----
 crypto/block-luks.c |   6 ++-
 crypto/block.c      |   1 +
 3 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 78fbe79c95..76cc8bda49 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -160,6 +160,48 @@ error:
     return ret;
 }
 
+static int coroutine_fn GRAPH_UNLOCKED
+block_crypto_co_format_luks_payload(BlockdevCreateOptionsLUKS *luks_opts,
+                                    Error **errp)
+{
+    BlockDriverState *bs = NULL;
+    BlockBackend *blk = NULL;
+    Error *local_error = NULL;
+    int ret;
+
+    if (luks_opts->size > INT64_MAX) {
+        return -EFBIG;
+    }
+
+    bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
+    if (bs == NULL) {
+        return -EIO;
+    }
+
+    blk = blk_co_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                             BLK_PERM_ALL, errp);
+    if (!blk) {
+        ret = -EPERM;
+        goto fail;
+    }
+
+    ret = blk_truncate(blk, luks_opts->size, true,
+                       luks_opts->preallocation, 0, &local_error);
+    if (ret < 0) {
+        if (ret == -EFBIG) {
+            /* Replace the error message with a better one */
+            error_free(local_error);
+            error_setg(errp, "The requested file size is too large");
+        }
+        goto fail;
+    }
+
+    ret = 0;
+
+fail:
+    bdrv_co_unref(bs);
+    return ret;
+}
 
 static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
@@ -651,6 +693,7 @@ static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsLUKS *luks_opts;
+    BlockDriverState *hdr_bs = NULL;
     BlockDriverState *bs = NULL;
     QCryptoBlockCreateOptions create_opts;
     PreallocMode preallocation = PREALLOC_MODE_OFF;
@@ -659,8 +702,22 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
     luks_opts = &create_options->u.luks;
 
-    if (luks_opts->file == NULL) {
-        error_setg(errp, "Formatting LUKS disk requires parameter 'file'");
+    if (luks_opts->header == NULL && luks_opts->file == NULL) {
+        error_setg(errp, "Either the parameter 'header' or 'file' should "
+                   "be specified");
+        return -EINVAL;
+    }
+
+    if (luks_opts->detached_header && luks_opts->header == NULL) {
+        error_setg(errp, "Formatting a detached LUKS disk requries "
+                   "'header' to be specified");
+        return -EINVAL;
+    }
+
+    if ((luks_opts->preallocation != PREALLOC_MODE_OFF) &&
+        (luks_opts->file == NULL)) {
+        error_setg(errp, "Parameter 'preallocation' requries 'file' to be "
+                   "specified for formatting LUKS disk");
         return -EINVAL;
     }
 
@@ -673,7 +730,40 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         preallocation = luks_opts->preallocation;
     }
 
-    if (luks_opts->file) {
+    if (luks_opts->header) {
+        hdr_bs = bdrv_co_open_blockdev_ref(luks_opts->header, errp);
+        if (hdr_bs == NULL) {
+            return -EIO;
+        }
+
+        /*
+         * If blockdev reference of header is specified,
+         * detached_header default to true
+         */
+        create_opts.u.luks.detached_header = true;
+
+        /* Format the LUKS header node */
+        ret = block_crypto_co_create_generic(hdr_bs, 0, &create_opts,
+                                             PREALLOC_MODE_OFF, errp);
+        if (ret < 0) {
+            goto hdr_bs_failed;
+        }
+
+        /* Format the LUKS payload node */
+        if (luks_opts->file) {
+            ret = block_crypto_co_format_luks_payload(luks_opts, errp);
+            if (ret < 0) {
+                goto hdr_bs_failed;
+            }
+        }
+
+        ret = 0;
+
+hdr_bs_failed:
+        bdrv_co_unref(hdr_bs);
+        return ret;
+    } else if (luks_opts->file) {
+        /* None detached LUKS header path */
         bs = bdrv_co_open_blockdev_ref(luks_opts->file, errp);
         if (bs == NULL) {
             return -EIO;
@@ -682,14 +772,15 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
         ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
                                              preallocation, errp);
         if (ret < 0) {
-            goto fail;
+            goto bs_failed;
         }
-    }
 
-    ret = 0;
-fail:
-    bdrv_co_unref(bs);
-    return ret;
+        ret = 0;
+
+bs_failed:
+        bdrv_co_unref(bs);
+        return ret;
+    }
 }
 
 static int coroutine_fn GRAPH_UNLOCKED
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 48443ffcae..474c7aee2e 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1561,8 +1561,12 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     block->payload_offset =
         qcrypto_block_luks_payload_offset(luks->header.payload_offset_sector);
 
+    block->detached_header_size =
+        (header_sectors + QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS *
+         split_key_sectors) * block->sector_size;
+
     /* Reserve header space to match payload offset */
-    initfunc(block, block->payload_offset, opaque, &local_err);
+    initfunc(block, block->detached_header_size, opaque, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
diff --git a/crypto/block.c b/crypto/block.c
index 7bb4b74a37..ea493f056e 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -102,6 +102,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
     }
 
     block->driver = qcrypto_block_drivers[options->format];
+    block->detached_header = options->u.luks.detached_header;
 
     if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
-- 
2.39.1


