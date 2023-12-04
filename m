Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A130A8039BE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABV9-0006kn-H1; Mon, 04 Dec 2023 11:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABV5-0006kB-Js
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABV3-0005HY-R9
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ce3efb78e2so1773900b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706008; x=1702310808;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Paa1v9lX7auJnjKurBVZBYxHkzxsBjXqa29SVbISB48=;
 b=U7YsT0RBX94pAoDNw18ebKp9J1sSCGVz7EmkDPxGljVSAt/eqD2+GZnZ2KhxtLPR6b
 bu3+vxT2wVaqAkW9IRTdrRTXPmZULePUMPOaVMocMqpUh6fWdeiOs3UML4ck1ybca5Mf
 54uhOorcCv8VawcJh62fq3oDW0Dha95gTgQxysaJEWsEqFQP1366Z3UxmUQhR1BpyGFW
 SHbYcjDP4ZMHUb3l7CHR0eNkiU3EHlPNlxEf6V4nl0UNUJqo4A5601tw12BO2E6BsPfP
 uDfp5eHtDLbTB5MDINc8K1kApEhu7PapiD9Q4iX7ljXtfBsmLtYvWTL1rYy2hD7GQn6G
 jB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706008; x=1702310808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Paa1v9lX7auJnjKurBVZBYxHkzxsBjXqa29SVbISB48=;
 b=tzyx04TUxwITKIDBLlrgQyr3FO/2zwf5/cy0tvRL+dxODu/eOJoztQ6eBnW5aviqwQ
 2Ah/nPAqyWJb1nwlyeWcI/KKTCeokrC0BxyMNCNuyW80tBJa/f0NcWhMuphMRi1/wrVg
 Vzl77Pa2njdyL6LKXKiV0Rjp0Xu+4KtD1P+0iX1NIJMrwIvkVTo/RcJzISUDeK0I6r2K
 6dXPgmBPRE5XLbc8QjkiaZIZ0qzlE0ubKOhfG9mu2+/7Ou2pJWtrSHuZxaO8GRULYP0d
 9h/lPaGWPp0q178tvuLlt3yGYS2LboMQDJIgWIXyLux28NOyocoFasZjP9lPK1lPUaSB
 qLNw==
X-Gm-Message-State: AOJu0YwHgP+PS2+YXzKQqob6gwrLpSNybM+c3pI4EPCZDIArgO/kSktU
 1mu51YjkMAIWfb+y+EkOpeS2gFI9KYKdE/9n3m8j/jKD
X-Google-Smtp-Source: AGHT+IGtjxyGHy5eOaXkwD5tMHenm76xoijZUWzR3057CdomPVltOfsQFLGSwMDhG15BOi4S0+GXyw==
X-Received: by 2002:a05:6a21:9981:b0:18f:97c:9766 with SMTP id
 ve1-20020a056a21998100b0018f097c9766mr6194014pzb.78.1701706007923; 
 Mon, 04 Dec 2023 08:06:47 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:47 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 3/8] Gluks: Add the basic framework
Date: Tue,  5 Dec 2023 00:06:20 +0800
Message-Id: <86633da8871fc0aceb1d0667ad05e15494585a70.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x433.google.com
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

Gluks would be a built-in format in the QEMU block layer.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/generic-luks.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 block/generic-luks.h | 26 ++++++++++++++
 block/meson.build    |  1 +
 3 files changed, 108 insertions(+)
 create mode 100644 block/generic-luks.c
 create mode 100644 block/generic-luks.h

diff --git a/block/generic-luks.c b/block/generic-luks.c
new file mode 100644
index 0000000000..f23e202991
--- /dev/null
+++ b/block/generic-luks.c
@@ -0,0 +1,81 @@
+/*
+ * QEMU block driver for the generic luks encryption
+ *
+ * Copyright (c) 2024 SmartX Inc
+ *
+ * Author: Hyman Huang <yong.huang@smartx.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "block/block_int.h"
+#include "block/crypto.h"
+#include "crypto/block.h"
+
+#include "generic-luks.h"
+
+/* BDRVGLUKSState holds the state of one generic LUKS instance */
+typedef struct BDRVGLUKSState {
+    BlockCrypto crypto;
+    BdrvChild *header;      /* LUKS header node */
+    uint64_t header_size;   /* In bytes */
+} BDRVGLUKSState;
+
+static int gluks_open(BlockDriverState *bs, QDict *options, int flags,
+                      Error **errp)
+{
+    return 0;
+}
+
+static int coroutine_fn GRAPH_UNLOCKED
+gluks_co_create_opts(BlockDriver *drv, const char *filename,
+                     QemuOpts *opts, Error **errp)
+{
+    return 0;
+}
+
+static void
+gluks_child_perms(BlockDriverState *bs, BdrvChild *c,
+                  const BdrvChildRole role,
+                  BlockReopenQueue *reopen_queue,
+                  uint64_t perm, uint64_t shared,
+                  uint64_t *nperm, uint64_t *nshared)
+{
+
+}
+
+static int64_t coroutine_fn GRAPH_RDLOCK
+gluks_co_getlength(BlockDriverState *bs)
+{
+    return 0;
+}
+
+static BlockDriver bdrv_generic_luks = {
+    .format_name            = "gluks",
+    .instance_size          = sizeof(BDRVGLUKSState),
+    .bdrv_open              = gluks_open,
+    .bdrv_co_create_opts    = gluks_co_create_opts,
+    .bdrv_child_perm        = gluks_child_perms,
+    .bdrv_co_getlength      = gluks_co_getlength,
+};
+
+static void block_generic_luks_init(void)
+{
+    bdrv_register(&bdrv_generic_luks);
+}
+
+block_init(block_generic_luks_init);
diff --git a/block/generic-luks.h b/block/generic-luks.h
new file mode 100644
index 0000000000..2aae866fa4
--- /dev/null
+++ b/block/generic-luks.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU block driver for the generic luks encryption
+ *
+ * Copyright (c) 2024 SmartX Inc
+ *
+ * Author: Hyman Huang <yong.huang@smartx.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef GENERIC_LUKS_H
+#define GENERIC_LUKS_H
+
+#endif /* GENERIC_LUKS_H */
diff --git a/block/meson.build b/block/meson.build
index 59ff6d380c..74f2da7bed 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -39,6 +39,7 @@ block_ss.add(files(
   'throttle.c',
   'throttle-groups.c',
   'write-threshold.c',
+  'generic-luks.c',
 ), zstd, zlib, gnutls)
 
 system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
-- 
2.39.1


