Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9908039CB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:10:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABVP-0006uA-F4; Mon, 04 Dec 2023 11:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVN-0006tj-E3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:09 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVL-0005JB-JT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:09 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ce3534bf44so1281469b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706026; x=1702310826;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=curXvDp0ioN47tzvE2UhnUysHr4g1/8N1rFgo2OTs0o=;
 b=nZVR3CrGUjiZHaArqr/Un5P9d0LejVZJanFS3zsA0Qox6gTcOad5UVG2R1LUj3dEvj
 wQZFDkMPo2VCYH6ANULh097lT5okIJfi7vCFkrI95wDA0IttX8uKqzW2bQg0zGM0iXl+
 92dqEBkfl1kswHWb1kymu7QVqQTLS1JoKjQ6rMqCozeyj/vunc3wIH5v7Y5+iwD/CQR+
 BXlPcv/yUnmikKkIFX55jAex6fE6Ph1dlDTRl48vyTqF5IGygFBqNmYwSOng9y5ZFuJ6
 KW7zo5GbnTFALzr9xAu1FEIRW2ySw+HVkJFALaldUF8ixZ34x03dKSXLkkd/CnblNp0v
 VtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706026; x=1702310826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=curXvDp0ioN47tzvE2UhnUysHr4g1/8N1rFgo2OTs0o=;
 b=TPkSiJ8W/Gd3rc60dVlycr2mkObuu0kWt/m6fA29jtX1Z7qoU9KyYUpU/Zy1DTA3yg
 a5HLMsts8FXo4f5tlfQpz2ik45UkAJ2FjkVayD069DTm3P4Bc8MgbXuDhzlAUVmmGLig
 FHZZvLlVdCSbo8EI6LwZlcqDpd7b7eoZLLsPSu8Q3pdvQyHReAE0xuoDv7/t5jMutm3d
 +SPWDvThVoELN7ezXqHV5SMkMRj+AjKijv3EKkZklsm+ktwkESmSTas702WFx/ndDnD4
 tM4aDmK6QE/P/o65oRWqTiuUAfbSv78lznn908/mcVK/etq8uwlEnuz2fosHv9HAFBFU
 h/Jg==
X-Gm-Message-State: AOJu0YzjooYLhmr60AhnEOknObIB0wCI0nI6tTdSCY9OWSfnNZeBLXuv
 x7PaM63td2WkxwXmdM2ZJhGEnKN+e22YWxuKVbeXFUly
X-Google-Smtp-Source: AGHT+IGt4SNvnbcsvJibYv0gG/z0Pbgh7veSbdcdt4YsJ5Yapgp4n0b3xKIKzyTEEks9cfTC2n0eBA==
X-Received: by 2002:a05:6a20:3ca6:b0:18b:e5e6:576c with SMTP id
 b38-20020a056a203ca600b0018be5e6576cmr5046995pzj.3.1701706025666; 
 Mon, 04 Dec 2023 08:07:05 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:07:05 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 7/8] Gluks: Implement the fundamental block layer driver hooks
Date: Tue,  5 Dec 2023 00:06:24 +0800
Message-Id: <ce3c00e10d2a0218319373c107f3ca186bedfae1.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x432.google.com
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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/generic-luks.c | 104 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/block/generic-luks.c b/block/generic-luks.c
index ebc0365d40..32cbedc86f 100644
--- a/block/generic-luks.c
+++ b/block/generic-luks.c
@@ -23,8 +23,14 @@
 #include "qemu/osdep.h"
 
 #include "block/block_int.h"
+#include "block/block-io.h"
 #include "block/crypto.h"
+#include "block/qdict.h"
 #include "crypto/block.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
 
 #include "generic-luks.h"
 
@@ -50,10 +56,89 @@ static QemuOptsList gluks_create_opts_luks = {
     },
 };
 
+static int gluks_read_func(QCryptoBlock *block,
+                           size_t offset,
+                           uint8_t *buf,
+                           size_t buflen,
+                           void *opaque,
+                           Error **errp)
+{
+
+    BlockDriverState *bs = opaque;
+    BDRVGLUKSState *s = bs->opaque;
+    ssize_t ret;
+
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    ret = bdrv_pread(s->header, offset, buflen, buf, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not read generic luks header");
+        return ret;
+    }
+    return 0;
+}
+
 static int gluks_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
-    return 0;
+    BDRVGLUKSState *s = bs->opaque;
+    QemuOpts *opts = NULL;
+    QCryptoBlockOpenOptions *open_opts = NULL;
+    QDict *cryptoopts = NULL;
+    unsigned int cflags = 0;
+    int ret;
+
+    GLOBAL_STATE_CODE();
+
+    if (!bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                         (BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY), false, errp)) {
+        return -EINVAL;
+    }
+    s->header = bdrv_open_child(NULL, options, "header", bs,
+                                &child_of_bds, BDRV_CHILD_METADATA, false,
+                                errp);
+    if (!s->header) {
+        return -EINVAL;
+    }
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    opts = qemu_opts_create(&block_crypto_runtime_opts_luks,
+        NULL, 0, &error_abort);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
+        ret = -EINVAL;
+        goto cleanup;
+    }
+
+    cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format",
+        QCryptoBlockFormat_str(Q_CRYPTO_BLOCK_FORMAT_GLUKS));
+
+    open_opts = block_crypto_open_opts_init(cryptoopts, errp);
+    if (!open_opts) {
+        goto cleanup;
+    }
+
+    s->crypto.block = qcrypto_block_open(open_opts, NULL,
+                                         gluks_read_func,
+                                         bs,
+                                         cflags,
+                                         1,
+                                         errp);
+    if (!s->crypto.block) {
+        ret = -EIO;
+        goto cleanup;
+    }
+
+    s->header_size = qcrypto_block_get_payload_offset(s->crypto.block);
+    qcrypto_block_set_payload_offset(s->crypto.block, 0);
+
+    ret = 0;
+ cleanup:
+    qobject_unref(cryptoopts);
+    qapi_free_QCryptoBlockOpenOptions(open_opts);
+    return ret;
 }
 
 static int coroutine_fn GRAPH_UNLOCKED
@@ -70,13 +155,24 @@ gluks_child_perms(BlockDriverState *bs, BdrvChild *c,
                   uint64_t perm, uint64_t shared,
                   uint64_t *nperm, uint64_t *nshared)
 {
+    if (role & BDRV_CHILD_METADATA) {
+        /* assign read permission only */
+        perm |= BLK_PERM_CONSISTENT_READ;
+        /* share all permissions */
+        shared |= BLK_PERM_ALL;
 
+        *nperm = perm;
+        *nshared = shared;
+        return;
+    }
+
+    bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
 gluks_co_getlength(BlockDriverState *bs)
 {
-    return 0;
+    return bdrv_co_getlength(bs->file->bs);
 }
 
 static BlockDriver bdrv_generic_luks = {
@@ -87,8 +183,12 @@ static BlockDriver bdrv_generic_luks = {
     .bdrv_child_perm        = gluks_child_perms,
     .bdrv_co_getlength      = gluks_co_getlength,
 
+    .bdrv_close             = block_crypto_close,
+    .bdrv_co_preadv         = block_crypto_co_preadv,
+    .bdrv_co_pwritev        = block_crypto_co_pwritev,
     .create_opts            = &gluks_create_opts_luks,
     .amend_opts             = &block_crypto_amend_opts_luks,
+    .is_format              = false,
 };
 
 static void block_generic_luks_init(void)
-- 
2.39.1


