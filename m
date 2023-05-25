Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDA710C56
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AO4-0008NR-Pw; Thu, 25 May 2023 08:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANt-00087Z-2X
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANU-00020Q-AO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3qjAqClO90U/CNeVD+Ipc2N7sAsydoXmUm4UwjsvtI=;
 b=cf5jZty+rpdijq/daGBw8+bQOJn+7wH6rK4dU5X3LC+3tcOqaXr+5ZiBaZGv0f6RhBD/Kz
 5Xk2XjHKZuh1onIYVP/CSNvqso6jRqzV67Ubs5lEAtk3KJPqfxhnYjoVft+wva3ugc514Q
 q61Zub9e9LdH5jCw0l98shAnTdnRey4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-d-Kav6EROx26NGPyuRCAJA-1; Thu, 25 May 2023 08:47:32 -0400
X-MC-Unique: d-Kav6EROx26NGPyuRCAJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF283800141;
 Thu, 25 May 2023 12:47:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C70519E63;
 Thu, 25 May 2023 12:47:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 07/12] raw-format: Fix open with 'file' in iothread
Date: Thu, 25 May 2023 14:47:08 +0200
Message-Id: <20230525124713.401149-8-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When opening the 'file' child moves bs to an iothread, we need to hold
the AioContext lock of it before we can call raw_apply_options() (and
more specifically, bdrv_getlength() inside of it).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/raw-format.c               | 5 +++++
 tests/unit/test-block-iothread.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 918fe4fb7e..e4f35268e6 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -468,6 +468,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
     BDRVRawState *s = bs->opaque;
+    AioContext *ctx;
     bool has_size;
     uint64_t offset, size;
     BdrvChildRole file_role;
@@ -515,7 +516,11 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                 bs->file->bs->filename);
     }
 
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
     ret = raw_apply_options(bs, s, offset, has_size, size, errp);
+    aio_context_release(ctx);
+
     if (ret < 0) {
         return ret;
     }
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 1b40e65bad..f081c09729 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -833,12 +833,9 @@ static void test_attach_second_node(void)
     qdict_put_str(options, "driver", "raw");
     qdict_put_str(options, "file", "base");
 
-    /* FIXME raw_open() should take ctx's lock internally */
-    aio_context_acquire(ctx);
     aio_context_acquire(main_ctx);
     filter = bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
     aio_context_release(main_ctx);
-    aio_context_release(ctx);
 
     g_assert(blk_get_aio_context(blk) == ctx);
     g_assert(bdrv_get_aio_context(bs) == ctx);
-- 
2.40.1


