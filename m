Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47679A6EB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVI-0005p7-Rv; Mon, 11 Sep 2023 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVG-0005nz-R1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVC-0004f4-6b
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gqQcdvKag/x5W/lID6cIRmWGEc5fwpToKUsRPfkans=;
 b=HR5+SdS+x1Dg0AuNACZVDWw5Fm2qx6nz8AwpUWrwdISbTx1aGUomqwzWt3uukdQGEFwJC9
 OHGMKlS+cQ4jhuY8m4l0Y5exQSHcKnCRcTddpv3bsue/PlsgFLB9AFR+iaMTeNms7UwC/o
 x3ngyqNXi33qpCYGERFnlqBT9p7UKyw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-MMUuNMNvP9eYJatSQg0NVg-1; Mon, 11 Sep 2023 05:46:38 -0400
X-MC-Unique: MMUuNMNvP9eYJatSQg0NVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C598429ABA0E;
 Mon, 11 Sep 2023 09:46:37 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 678DE40C6EA8;
 Mon, 11 Sep 2023 09:46:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 04/21] block: Take AioContext lock for bdrv_append() more
 consistently
Date: Mon, 11 Sep 2023 11:46:03 +0200
Message-ID: <20230911094620.45040-5-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


