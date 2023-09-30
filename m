Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FA7B4356
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 21:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmfmr-0000JN-SR; Sat, 30 Sep 2023 15:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qmfmp-0000Ia-Rn; Sat, 30 Sep 2023 15:37:59 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qmfmo-00014x-9o; Sat, 30 Sep 2023 15:37:59 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50481a0eee7so2227506e87.0; 
 Sat, 30 Sep 2023 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696102675; x=1696707475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzEBDrUrC4CiagGCFHIhRpbawhUL+3dM8FL4PE/cdBk=;
 b=bK5/bWU9UmhVYXvmLnwaekrOcEXe0Zp4qvJUITotiAWQa+JzJ68YMDbkZLnZcdlKFB
 Q+/EYdD+dCZxHP+ajUKzi0z5gSLlFW0I/F1IbrQvPuktRmAGD1z9mTcKfEDErEpFEYwB
 tZob3DmXiXqIYQP58e4rdEB48u+vd5f9NTuc6GSFloTQa2In9Kk3RIXTxOUchUNgioc4
 1lgWrf72TgtAQzsv1OYcDXibPv77nBmBrvHxcEPYgKIStmtLS7lGLJMJ+BTMCMnOdDoO
 ZJt0cbM/vIYAcaPSV8g7nTWwUA4LLjYDkf/hyrYmik+SRI9zfnKCrhh7fG6t/VIpJtmK
 0z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696102675; x=1696707475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzEBDrUrC4CiagGCFHIhRpbawhUL+3dM8FL4PE/cdBk=;
 b=j049QjS7R2vqUmtYsoD3h7RPU3nMGNjJXKXn9qs+h3dy3GnhuT/NlYd5IqWzblmbqh
 5fHG7QalGZC1zMxEVv/ynyMRVZNzRvm+vE6q1rVHjYdNobJxaFI8L1+ZKyho3uWl1txV
 91abnU1qaSu4YimcKmciXSX80i8bww8CQlFrORfHqTVecVn9r3XwZC4G98sgPjNnaJ+S
 LBSTcSaznm27yb8aAwzT1dLw+ecfLcpG43bowvrmQn8nqGzDDDa6jnvJxxWl0BVtnADU
 yoABVpXpB5qdWxkhFWL+PoL7Kh04nbJbS6UIScZ2tkto58tTpxFtSfrMNDsUbXzByOyP
 LelQ==
X-Gm-Message-State: AOJu0YyyJVl8bAlJYXVTNpVnwucRMZ97BpgrgWyxPk+QDwZKqPySteXG
 SiQnlA+YRIry81zWVyhfqplHKDD1VkDKBn/I+SE=
X-Google-Smtp-Source: AGHT+IGp+em9obBLfpQ8AR51WVqWkkPyWAdj9n8cNU27PFogi2H3LEpGj5ftyWN+WrOVXd9v6omr4Q==
X-Received: by 2002:a05:6512:b20:b0:502:9672:48b8 with SMTP id
 w32-20020a0565120b2000b00502967248b8mr5243998lfu.5.1696102674407; 
 Sat, 30 Sep 2023 12:37:54 -0700 (PDT)
Received: from localhost.localdomain ([185.9.78.108])
 by smtp.gmail.com with ESMTPSA id
 b20-20020ac25634000000b00500b3157ec6sm4037479lff.143.2023.09.30.12.37.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 30 Sep 2023 12:37:54 -0700 (PDT)
From: Mike Maslenkin <mike.maslenkin@gmail.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, den@openvz.org,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 1/1] qemu-img: do not erase destination file in qemu-img dd
 command
Date: Sat, 30 Sep 2023 22:37:30 +0300
Message-Id: <20230930193730.84780-1-mike.maslenkin@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a check that destination file exists and do not call bdrv_create for
this case.

Currently `qemu-img dd` command destroys content of destination file.
Effectively this means that parameters (geometry) of destination image
file are changing. This can be undesirable behavior for user especially
if format of destination image does not support resizing.

Steps to reproduce:
  1. Create empty disk image with some non default size.
       `qemu-img  create -f qcow2 $DEST_IMG 3T`
     Remember that `qemu-img info $DEST_IMG` returns:
       virtual size: 3 TiB (3298534883328 bytes)
       disk size: 240 KiB
       cluster_size: 65536
  2. Run `qemu-img dd -O qcow2 of=$DEST_IMG if=$SRC_IMG bs=1M count=100`
  3. Check `qemu-img info $DEST_IMG` output:
       virtual size: 100 MiB (104857600 bytes)
       disk size: 112 MiB
       cluster_size: 65536

Parameters of $DEST_IMG were changed. Actually `qemu-img dd` has created
a new disk based on current default geometry for particular format.
For example for "parallels" format default BAT for 256GB disk is written
to empty file prior writing disk image data.

With this patch virtual disk metadata and geometry of a destination image
are preserved. As another visible change of `qemu-img dd` behavior is that
if destination image is less than source it can finish with error (similar
to "dd" utility):
  qemu-img: error while writing to output image file: Input/output error

Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
---
 qemu-img.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a48edb71015c..1a83c14212fb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5150,13 +5150,16 @@ static int img_dd(int argc, char **argv)
                             size - in.bsz * in.offset, &error_abort);
     }
 
-    ret = bdrv_create(drv, out.filename, opts, &local_err);
-    if (ret < 0) {
-        error_reportf_err(local_err,
-                          "%s: error while creating output image: ",
-                          out.filename);
-        ret = -1;
-        goto out;
+    if (!g_file_test(out.filename, G_FILE_TEST_EXISTS)) {
+        ret = bdrv_create(drv, out.filename, opts, &local_err);
+        fprintf (stderr, "Recreating image file\n");
+        if (ret < 0) {
+            error_reportf_err(local_err,
+                               "%s: error while creating output image: ",
+                               out.filename);
+            ret = -1;
+            goto out;
+        }
     }
 
     /* TODO, we can't honour --image-opts for the target,
-- 
2.32.0 (Apple Git-132)


