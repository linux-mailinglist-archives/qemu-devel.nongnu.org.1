Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB578039BB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABV1-0006i8-Tr; Mon, 04 Dec 2023 11:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABUy-0006fs-Hu
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:44 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABUw-0005H0-9b
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:44 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6cbe716b511so3482859b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706000; x=1702310800;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mU32fUdqbOP78qIBgbT8+B9YhjVGKgxYqP5o3Z/rxlM=;
 b=YJvREbR4LGD8E2B9rcSGjavqB2CySTxtInb/+LBL17jYZF64Zs1rx5fn3o0mq8XJg4
 eEQAkkYzka7TshEevHqKMjcG1oPz2c5HgS+ikZvkplM/jfgJIwSR01THYJflNbCPI5Ro
 8ogwlbQbtUd8ysRmJiB0qm01rSts/Bumy6sWR0ITOhqLtR6pXfaGiL3HGzglyYe1YMr9
 0E/NtOp2isf0oyrhmSgKKVTOFQCvcuH6it9KsiPPEVJ/NrvIj+oZvGrYVymreE7EBBfp
 K2SsI4JDlB2RSgSuH3FQ3oDmqgYaQTWfZE3mG4RxxY+Ll9G7NLCcm8tbMPN2sRqS5OFU
 yHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706000; x=1702310800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mU32fUdqbOP78qIBgbT8+B9YhjVGKgxYqP5o3Z/rxlM=;
 b=RNEUGzlYthLNQ4/ZIrLOvpC/ZX1Cehk80kfnQkwO/A6SgTb0RjFlammd72ZzGnwyKk
 h1IXx6q7CRy2oUn3b5hUlPe9UULzsTv8qvc1pE0aj7MhxhHFwzIc9TONVpsV1Ef1W7RF
 h4mUkuacMv7nPrtRqmIUhgFzV7MJ85VNZQxVtSumW0kfzZykJcVfwjB8A+6AuVyMgh24
 GjthhAnVsb/tcVQHlNL3JMSGCapdWrPdqjIAnCiJM2B+Ly78BVoRqd92Fy3gGybT7G7d
 iblaIva9X7pQTxMfeiVJ3631/p18JlnIJYh3LU5oq4qC5uRwuUmSIHDqUysxJfLf4kf7
 Sr2w==
X-Gm-Message-State: AOJu0YwNdqVIlYIrYzdldgKG3QLUndlamM3GfloZ2hdyGAksW0FK0XUy
 TKLbFhboRWztdpR8yxHc+E5WhZiasD17zwP7sK6jkR83
X-Google-Smtp-Source: AGHT+IG1BaMexBswks70YdFD62Y1bkRyYevOfk91XEQlhbBfsDFETnfo7CVxFcuHrwOh6YszZ98eaw==
X-Received: by 2002:a05:6a20:2694:b0:18f:97c:8272 with SMTP id
 h20-20020a056a20269400b0018f097c8272mr1631670pze.124.1701705999775; 
 Mon, 04 Dec 2023 08:06:39 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:39 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 1/8] crypto: Export util functions and structures
Date: Tue,  5 Dec 2023 00:06:18 +0800
Message-Id: <028c7b2b533b76a729b123170d6109a9d1b7ced9.1701705003.git.yong.huang@smartx.com>
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

Luks driver logic is primarily reused by Gluk, which,
therefore, exports several pre-existing functions and
structures.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 block/crypto.c | 16 ++++------------
 block/crypto.h | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 921933a5e5..6afae1de2e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -34,14 +34,6 @@
 #include "qemu/memalign.h"
 #include "crypto.h"
 
-typedef struct BlockCrypto BlockCrypto;
-
-struct BlockCrypto {
-    QCryptoBlock *block;
-    bool updating_keys;
-};
-
-
 static int block_crypto_probe_generic(QCryptoBlockFormat format,
                                       const uint8_t *buf,
                                       int buf_size,
@@ -321,7 +313,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 }
 
 
-static int coroutine_fn GRAPH_UNLOCKED
+int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                QCryptoBlockCreateOptions *opts,
                                PreallocMode prealloc, Error **errp)
@@ -385,7 +377,7 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
     return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
 }
 
-static void block_crypto_close(BlockDriverState *bs)
+void block_crypto_close(BlockDriverState *bs)
 {
     BlockCrypto *crypto = bs->opaque;
     qcrypto_block_free(crypto->block);
@@ -404,7 +396,7 @@ static int block_crypto_reopen_prepare(BDRVReopenState *state,
  */
 #define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
 
-static int coroutine_fn GRAPH_RDLOCK
+int coroutine_fn GRAPH_RDLOCK
 block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                        QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
@@ -466,7 +458,7 @@ block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 
-static int coroutine_fn GRAPH_RDLOCK
+int coroutine_fn GRAPH_RDLOCK
 block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                         QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
diff --git a/block/crypto.h b/block/crypto.h
index 72e792c9af..06465009f0 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -21,6 +21,8 @@
 #ifndef BLOCK_CRYPTO_H
 #define BLOCK_CRYPTO_H
 
+#include "crypto/block.h"
+
 #define BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix, helpstr)                \
     {                                                                   \
         .name = prefix BLOCK_CRYPTO_OPT_QCOW_KEY_SECRET,                \
@@ -131,4 +133,25 @@ block_crypto_amend_opts_init(QDict *opts, Error **errp);
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
 
+typedef struct BlockCrypto BlockCrypto;
+
+struct BlockCrypto {
+    QCryptoBlock *block;
+    bool updating_keys;
+};
+
+int coroutine_fn GRAPH_UNLOCKED
+block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
+                               QCryptoBlockCreateOptions *opts,
+                               PreallocMode prealloc, Error **errp);
+
+int coroutine_fn GRAPH_RDLOCK
+block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                       QEMUIOVector *qiov, BdrvRequestFlags flags);
+
+int coroutine_fn GRAPH_RDLOCK
+block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                        QEMUIOVector *qiov, BdrvRequestFlags flags);
+
+void block_crypto_close(BlockDriverState *bs);
 #endif /* BLOCK_CRYPTO_H */
-- 
2.39.1


