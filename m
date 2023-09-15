Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA97A2156
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3W-0000T1-4B; Fri, 15 Sep 2023 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3N-0000JF-S7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3L-000564-Ac
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgwjuQs66KEdGIm11DMMTMlc8crlJPcTVvRKzjSnFFs=;
 b=dRJGsdm01ONv0+vYrftl7UYYjf56xF95f5J8BY0m90a8Cyq9AzJaA4QMaWcqENOS6PX1s7
 Y9BbKhSK0DaYWQyY7zGlJcAl0stMRdNrrqHCY7y46LuOt556voGe+Y0O9r2bSa5Kfnstlh
 DH2FEOp7TQhjQZK2jANRfMmljrN6kTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-uSeTYJnyNU-rfRxLYWSagw-1; Fri, 15 Sep 2023 10:44:10 -0400
X-MC-Unique: uSeTYJnyNU-rfRxLYWSagw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1B2A803498;
 Fri, 15 Sep 2023 14:44:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63FA2026D4B;
 Fri, 15 Sep 2023 14:44:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/28] test-bdrv-drain: avoid race with BH in IOThread drain
 test
Date: Fri, 15 Sep 2023 16:43:41 +0200
Message-ID: <20230915144344.238596-26-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

This patch fixes a race condition in test-bdrv-drain that is difficult
to reproduce. test-bdrv-drain sometimes fails without an error message
on the block pull request sent by Kevin Wolf on Sep 4, 2023. I was able
to reproduce it locally and found that "block-backend: process I/O in
the current AioContext" (in this patch series) is the first commit where
it reproduces.

I do not know why "block-backend: process I/O in the current AioContext"
exposes this bug. It might be related to the fact that the test's preadv
request runs in the main thread instead of IOThread a after my commit.
That might simply change the timing of the test.

Now on to the race condition in test-bdrv-drain. The main thread
schedules a BH in IOThread a and then drains the BDS:

  aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);

  /* The request is running on the IOThread a. Draining its block device
   * will make sure that it has completed as far as the BDS is concerned,
   * but the drain in this thread can continue immediately after
   * bdrv_dec_in_flight() and aio_ret might be assigned only slightly
   * later. */
  do_drain_begin(drain_type, bs);

If the BH completes before do_drain_begin() then there is nothing to
worry about.

If the BH invokes bdrv_flush() before do_drain_begin(), then
do_drain_begin() waits for it to complete.

The problematic case is when do_drain_begin() runs before the BH enters
bdrv_flush(). Then do_drain_begin() misses the BH and the drain
mechanism has failed in quiescing I/O.

Fix this by incrementing the in_flight counter so that do_drain_begin()
waits for test_iothread_main_thread_bh().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230912231037.826804-3-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-bdrv-drain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index b040a73bb9..0b603e7c57 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -512,6 +512,7 @@ static void test_iothread_main_thread_bh(void *opaque)
      * executed during drain, otherwise this would deadlock. */
     aio_context_acquire(bdrv_get_aio_context(data->bs));
     bdrv_flush(data->bs);
+    bdrv_dec_in_flight(data->bs); /* incremented by test_iothread_common() */
     aio_context_release(bdrv_get_aio_context(data->bs));
 }
 
@@ -583,6 +584,13 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
             aio_context_acquire(ctx_a);
         }
 
+        /*
+         * Increment in_flight so that do_drain_begin() waits for
+         * test_iothread_main_thread_bh(). This prevents the race between
+         * test_iothread_main_thread_bh() in IOThread a and do_drain_begin() in
+         * this thread. test_iothread_main_thread_bh() decrements in_flight.
+         */
+        bdrv_inc_in_flight(bs);
         aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);
 
         /* The request is running on the IOThread a. Draining its block device
-- 
2.41.0


