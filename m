Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBAD7A2150
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3H-0000EK-QC; Fri, 15 Sep 2023 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA33-0008Rf-PJ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA31-0004rK-S6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZjo0TQlAn5nA9xn4q9Pe0dipzzSsyaiWh1CV/mTbU0=;
 b=aGgodFcGYQF2+LDO0gjrcoMTiQi0ZVSp6G536DiAZOt5G5WPOMyxfu98tlIT34zDh1Tf5I
 aETlpTH/UVzKHdtok4SMB6kEypID2MhLuSC759fqDpkcyGwRmaZO7tHlRYSXHZLmwwDlC0
 oiyrEQKLrr9ngzK+AW5D3T9hIh++wvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-nDzAH6jhOlCLQ9Yk2oTm1g-1; Fri, 15 Sep 2023 10:43:52 -0400
X-MC-Unique: nDzAH6jhOlCLQ9Yk2oTm1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17969101B041;
 Fri, 15 Sep 2023 14:43:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79C022026D68;
 Fri, 15 Sep 2023 14:43:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/28] block: Take AioContext lock for bdrv_append() more
 consistently
Date: Fri, 15 Sep 2023 16:43:20 +0200
Message-ID: <20230915144344.238596-5-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The documentation for bdrv_append() says that the caller must hold the
AioContext lock for bs_top. Change all callers to actually adhere to the
contract.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-5-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-bdrv-drain.c     | 3 +++
 tests/unit/test-bdrv-graph-mod.c | 6 ++++++
 tests/unit/test-block-iothread.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index ccc453c29e..89c8fa6780 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1359,7 +1359,10 @@ static void test_append_to_drained(void)
     g_assert_cmpint(base_s->drain_count, ==, 1);
     g_assert_cmpint(base->in_flight, ==, 0);
 
+    aio_context_acquire(qemu_get_aio_context());
     bdrv_append(overlay, base, &error_abort);
+    aio_context_release(qemu_get_aio_context());
+
     g_assert_cmpint(base->in_flight, ==, 0);
     g_assert_cmpint(overlay->in_flight, ==, 0);
 
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 36eed4b464..d8503165b3 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -140,8 +140,10 @@ static void test_update_perm_tree(void)
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
 
+    aio_context_acquire(qemu_get_aio_context());
     ret = bdrv_append(filter, bs, NULL);
     g_assert_cmpint(ret, <, 0);
+    aio_context_release(qemu_get_aio_context());
 
     bdrv_unref(filter);
     blk_unref(root);
@@ -205,7 +207,9 @@ static void test_should_update_child(void)
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
+    aio_context_acquire(qemu_get_aio_context());
     bdrv_append(filter, bs, &error_abort);
+    aio_context_release(qemu_get_aio_context());
     g_assert(target->backing->bs == bs);
 
     bdrv_unref(filter);
@@ -410,7 +414,9 @@ static void test_append_greedy_filter(void)
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
 
+    aio_context_acquire(qemu_get_aio_context());
     bdrv_append(fl, base, &error_abort);
+    aio_context_release(qemu_get_aio_context());
     bdrv_unref(fl);
     bdrv_unref(top);
 }
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index d727a5fee8..9155547313 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -756,11 +756,14 @@ static void test_propagate_mirror(void)
                                   &error_abort);
 
     /* Start a mirror job */
+    aio_context_acquire(main_ctx);
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
                  MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
+    aio_context_release(main_ctx);
+
     WITH_JOB_LOCK_GUARD() {
         job = job_get_locked("job0");
     }
-- 
2.41.0


