Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038357169E3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42ID-0007jo-UR; Tue, 30 May 2023 12:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HO-0006Wr-GC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HK-0008GS-Fo
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unXlMObQwr/nXbipsntQnoRogAjP6neXdOKypzUgOjw=;
 b=hU1Mh+sJ4sDmj6TM9nnChxYftmDU1dh0RSoD8q7+anwVKvkVa4Ha5yfMTKHSxFTIdBe38+
 kMlz4x/uUMMHJi16bQmu9e0i1ifRD3ESdFJc/gc8rS/KVnAfpU9pqPaSLkKecmVulV9Azn
 icFe+BRib65XM3EzkNMQd1UweQwSd/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-t2DWfS0ANRWF2YyElO654g-1; Tue, 30 May 2023 12:32:53 -0400
X-MC-Unique: t2DWfS0ANRWF2YyElO654g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B805A8032FA;
 Tue, 30 May 2023 16:32:52 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09FFFC15612;
 Tue, 30 May 2023 16:32:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/32] qcow2: Fix open with 'file' in iothread
Date: Tue, 30 May 2023 18:32:13 +0200
Message-Id: <20230530163239.576632-7-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

qcow2_open() doesn't work correctly when opening the 'file' child moves
bs to an iothread, for several reasons:

- It uses BDRV_POLL_WHILE() to wait for the qcow2_open_entry()
  coroutine, which involves dropping the AioContext lock for bs when it
  is not in the main context - but we don't hold it, so this crashes.

- It runs the qcow2_open_entry() coroutine in the current thread instead
  of the new AioContext of bs.

- qcow2_open_entry() doesn't notify the main loop when it's done.

This patches fixes these issues around delegating work to a coroutine.
Temporarily dropping the main AioContext lock is not necessary because
we know we run in the main thread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-7-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c       | 6 ++++++
 block/qcow2.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index be9ae364fb..178ece2fa9 100644
--- a/block.c
+++ b/block.c
@@ -3646,6 +3646,9 @@ done:
  * BlockdevRef.
  *
  * The BlockdevRef will be removed from the options QDict.
+ *
+ * @parent can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
  */
 BdrvChild *bdrv_open_child(const char *filename,
                            QDict *options, const char *bdref_key,
@@ -3670,6 +3673,9 @@ BdrvChild *bdrv_open_child(const char *filename,
 
 /*
  * Wrapper on bdrv_open_child() for most popular case: open primary child of bs.
+ *
+ * @parent can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
  */
 int bdrv_open_file_child(const char *filename,
                          QDict *options, const char *bdref_key,
diff --git a/block/qcow2.c b/block/qcow2.c
index b00b4e7575..7f3948360d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1904,6 +1904,8 @@ static void coroutine_fn qcow2_open_entry(void *opaque)
     qoc->ret = qcow2_do_open(qoc->bs, qoc->options, qoc->flags, true,
                              qoc->errp);
     qemu_co_mutex_unlock(&s->lock);
+
+    aio_wait_kick();
 }
 
 static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
@@ -1929,8 +1931,10 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
 
     assert(!qemu_in_coroutine());
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
-    qemu_coroutine_enter(qemu_coroutine_create(qcow2_open_entry, &qoc));
-    BDRV_POLL_WHILE(bs, qoc.ret == -EINPROGRESS);
+
+    aio_co_enter(bdrv_get_aio_context(bs),
+                 qemu_coroutine_create(qcow2_open_entry, &qoc));
+    AIO_WAIT_WHILE_UNLOCKED(NULL, qoc.ret == -EINPROGRESS);
 
     return qoc.ret;
 }
-- 
2.40.1


