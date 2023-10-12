Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C97C7266
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySk-0003Vx-M7; Thu, 12 Oct 2023 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0003V4-SZ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySQ-0000ZJ-Ef
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6Bs8MIL1VR6WC0PYIRlqYWz8luW1P57myroUR9lSIk=;
 b=bi2AU5wM89H/I+95BhLhQhPCgJ7XD71pqNZkeSz6zupcPma+pldRDLcRplEzOcPQABWXQn
 eP+5WdtmDQPkN5vYN6znF8zlu4iIqNPQOvQPd3tYBsbfrAkUu5ngRZFNWeecycewDjNZS/
 UCQo4ejKzqgP8HTBVW9XOgScQu9uTT8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297--MelyAi3NDiOr9_udiOLyQ-1; Thu, 12 Oct 2023 12:22:40 -0400
X-MC-Unique: -MelyAi3NDiOr9_udiOLyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0E3838107A1;
 Thu, 12 Oct 2023 16:22:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20CB520296DB;
 Thu, 12 Oct 2023 16:22:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/26] test-bdrv-drain: Don't call bdrv_graph_wrlock() in
 coroutine context
Date: Thu, 12 Oct 2023 18:22:03 +0200
Message-ID: <20231012162224.240535-6-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
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

AIO callbacks are effectively coroutine_mixed_fn. If AIO requests don't
return immediately, their callback is called from the request coroutine.
This means that in AIO callbacks, we can't call no_coroutine_fns such as
bdrv_graph_wrlock(). Unfortunately test-bdrv-drain does so.

Change the test to use a BH to drop out of coroutine context, and add
coroutine_mixed_fn and no_coroutine_fn markers to clarify the context
each function runs in.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-2-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-bdrv-drain.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 0b603e7c57..bdd3757615 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1168,7 +1168,7 @@ struct detach_by_parent_data {
 };
 static struct detach_by_parent_data detach_by_parent_data;
 
-static void detach_indirect_bh(void *opaque)
+static void no_coroutine_fn detach_indirect_bh(void *opaque)
 {
     struct detach_by_parent_data *data = opaque;
 
@@ -1184,14 +1184,15 @@ static void detach_indirect_bh(void *opaque)
     bdrv_graph_wrunlock();
 }
 
-static void detach_by_parent_aio_cb(void *opaque, int ret)
+static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
 {
     struct detach_by_parent_data *data = &detach_by_parent_data;
 
     g_assert_cmpint(ret, ==, 0);
     if (data->by_parent_cb) {
         bdrv_inc_in_flight(data->child_b->bs);
-        detach_indirect_bh(data);
+        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
+                                detach_indirect_bh, &detach_by_parent_data);
     }
 }
 
-- 
2.41.0


