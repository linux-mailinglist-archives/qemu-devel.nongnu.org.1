Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA278039BC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABVi-0007AI-Gy; Mon, 04 Dec 2023 11:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVg-00071D-2N
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:28 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVV-0005Ji-KH
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:27 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ce3935ffedso1943381b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706034; x=1702310834;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K308th+gf/50+1Zu21hN3IC2Z/G4dmfKfM5g4fUEH6c=;
 b=vvEFX9KJEGQa9NSLLNW4h/OV7ImLt1XKllk/WjgmltHt06SgfSr9HgojXxYxTM6hee
 fzl31Qqa6SONgF/dC0IB/eqlc0RhQt+JqR2WePlL8dnuhAPEibQcN2E4Hfps2cKnSzZx
 7sPmtbIjwjilw6KS+EuAAthLtuASEj/rNNJo19sjCjNqflxwnSIfP/WnV6P0xvTr4cj9
 SzgZM2ZbYQfvwAaHu2P8cLX646682laEiGRipSAFBISCjhGJFKrDcedh4pt/GMXZCmuk
 u/+ocFAeo3/ry7D4Qv5yy7Z/kRDSvUz1+2pHDtsX7AEGInjEQxS2yIRGn1B5XV+d0Zbl
 HF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706034; x=1702310834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K308th+gf/50+1Zu21hN3IC2Z/G4dmfKfM5g4fUEH6c=;
 b=sqVqdr0GUvkvDAQwM+whTAYRgScAYPcH50FMqxNJUNR9F64xX+RKwiQIZadTSsqZs7
 aTXts9ynhxao4piR65wMugxS0hSwPl4akRsVDMOB44xtQm/1EjCuONjZvgC5Gc40OjNv
 0vOMLRfUWdzo/CKxv8PI7zwpHt70akdj8h/+1AVsSTE4Pf61vmMoW/0uKntdmckZEz0a
 c6dBkUomS8hk7t4xNK6m9vY9VqHYJwTEuMQLTwszqJuhqvdLerCupuVeJHTwAZBywkZM
 /fohLTZXr/VCO7G90R2zIptc8JGmNYgs9uar4XYZRCwSgQ5xUKRPvsK3HBwo8TW6TErC
 CSig==
X-Gm-Message-State: AOJu0YyK5Uk27Az+Wu6gIvV/k9mwq5lVE+UemjrO7gPeMVYiBKhGK9iH
 ArlRbgV5DkabFiEZ2crX8b8z2wMAWjGoi2AyP1ihMsF2
X-Google-Smtp-Source: AGHT+IFuoohNsIWLnbNkgzKWJKAg/syTxau9+Dpd5ZaHRmTXmnNWtVP3nlwNodGZVYm/qWmfExajsg==
X-Received: by 2002:a05:6a20:daa4:b0:18b:8475:410a with SMTP id
 iy36-20020a056a20daa400b0018b8475410amr5663958pzb.7.1701706033888; 
 Mon, 04 Dec 2023 08:07:13 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:07:13 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 8/8] block: Support Gluks format image creation using qemu-img
Date: Tue,  5 Dec 2023 00:06:25 +0800
Message-Id: <609e4a2182edc0e0ab3e5942de7dd0e9f16602e6.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
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

To create a Gluks header image, use the command as follows:
$ qemu-img create --object secret,id=sec0,data=abc123 -f gluks
> -o cipher-alg=aes-256,cipher-mode=xts -o key-secret=sec0
> cipher.gluks

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block.c              |  5 +++++
 block/generic-luks.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index bfb0861ec6..cc9a517a25 100644
--- a/block.c
+++ b/block.c
@@ -7517,6 +7517,11 @@ void bdrv_img_create(const char *filename, const char *fmt,
         goto out;
     }
 
+    if (!strcmp(fmt, "gluks")) {
+        qemu_opt_set(opts, "size", "0M", &local_err);
+        size = 0;
+    }
+
     if (size == -1) {
         error_setg(errp, "Image creation needs a size parameter");
         goto out;
diff --git a/block/generic-luks.c b/block/generic-luks.c
index 32cbedc86f..579f01c4b0 100644
--- a/block/generic-luks.c
+++ b/block/generic-luks.c
@@ -145,7 +145,58 @@ static int coroutine_fn GRAPH_UNLOCKED
 gluks_co_create_opts(BlockDriver *drv, const char *filename,
                      QemuOpts *opts, Error **errp)
 {
-    return 0;
+    QCryptoBlockCreateOptions *create_opts = NULL;
+    BlockDriverState *bs = NULL;
+    QDict *cryptoopts;
+    int ret;
+
+    if (qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0) != 0) {
+        info_report("gluks format image need not size parameter, ignore it");
+    }
+
+    cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
+                                             &gluks_create_opts_luks,
+                                             true);
+
+    qdict_put_str(cryptoopts, "format",
+        QCryptoBlockFormat_str(Q_CRYPTO_BLOCK_FORMAT_GLUKS));
+
+    create_opts = block_crypto_create_opts_init(cryptoopts, errp);
+    if (!create_opts) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Create protocol layer */
+    ret = bdrv_co_create_file(filename, opts, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    bs = bdrv_co_open(filename, NULL, NULL,
+                      BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (!bs) {
+        ret = -EINVAL;
+        goto fail;
+    }
+    /* Create format layer */
+    ret = block_crypto_co_create_generic(bs, 0, create_opts, 0, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = 0;
+fail:
+    /*
+     * If an error occurred, delete 'filename'. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret) {
+        bdrv_graph_co_rdlock();
+        bdrv_co_delete_file_noerr(bs);
+        bdrv_graph_co_rdunlock();
+    }
+    return ret;
 }
 
 static void
-- 
2.39.1


