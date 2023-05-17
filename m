Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF0706EC6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:54:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNK-00042Y-UX; Wed, 17 May 2023 12:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNJ-00041b-7n
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNH-0001TR-CG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IxlrbCsJ6QGGIw5uAuyCW2NhGqKdohEzjYBCgpT0EQ=;
 b=RZw7Vax0B0pX2F9T7g+P9o+vW1WLdOMlOLSs34W1bvbO0JksXfjzJ+niuOHYm6I9tyLFwp
 w2xC1xpLwr3eqGK7qeo9RYAldTGNnrOpdPYee9CvSVDV0qcPKE+KYnaHDZ7u9F8CoC45Tf
 44q9AmlVxTvV1MQZxP1M0o7w/AmGkII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-sg4OjQndOmWauYZ7M0R5tQ-1; Wed, 17 May 2023 12:51:35 -0400
X-MC-Unique: sg4OjQndOmWauYZ7M0R5tQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C0C800047;
 Wed, 17 May 2023 16:51:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B49540C6EC4;
 Wed, 17 May 2023 16:51:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/18] test-bdrv-drain: Take graph lock more selectively
Date: Wed, 17 May 2023 18:51:10 +0200
Message-Id: <20230517165116.475123-13-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

If we take a reader lock, we can't call any functions that take a writer
lock internally without causing deadlocks once the reader lock is
actually enforced in the main thread, too. Take the reader lock only
where it is actually needed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-6-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-bdrv-drain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 9a4c5e59d6..ae4299ccfa 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1004,8 +1004,6 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
     void *buffer = g_malloc(65536);
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buffer, 65536);
 
-    GRAPH_RDLOCK_GUARD();
-
     /* Pretend some internal write operation from parent to child.
      * Important: We have to read from the child, not from the parent!
      * Draining works by first propagating it all up the tree to the
@@ -1014,7 +1012,9 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
      * everything will be drained before we go back down the tree, but
      * we do not want that.  We want to be in the middle of draining
      * when this following requests returns. */
+    bdrv_graph_co_rdlock();
     bdrv_co_preadv(tts->wait_child, 0, 65536, &qiov, 0);
+    bdrv_graph_co_rdunlock();
 
     g_assert_cmpint(bs->refcnt, ==, 1);
 
-- 
2.40.1


