Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C40706EB8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNQ-00047B-24; Wed, 17 May 2023 12:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNM-00044T-IF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNK-0001XC-M2
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Av32Y6A1PHT9iibZFDzdKTmo58adQORDsDeRO0je8OY=;
 b=NSQdGU5+P3GZMLx9KgMYcgbyq6U7ZANs4inQhxVMKkccCmWDCB2/X3YMDe/lXYcJPJbvGG
 gEk7i9Zaez94ikPfrrT1+kFgx7/O4HZwE4+kCoM3XIgyRBy1vIzImIAxxMWcsw6LM4cSSl
 bqURH7fCl7oAqkEjvkMiw8jrkC7nuPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-iZ9C7nZMPCeJT5igbn01ag-1; Wed, 17 May 2023 12:51:38 -0400
X-MC-Unique: iZ9C7nZMPCeJT5igbn01ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6F4788B771;
 Wed, 17 May 2023 16:51:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B8964078908;
 Wed, 17 May 2023 16:51:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/18] graph-lock: Honour read locks even in the main thread
Date: Wed, 17 May 2023 18:51:13 +0200
Message-Id: <20230517165116.475123-16-kwolf@redhat.com>
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

There are some conditions under which we don't actually need to do
anything for taking a reader lock: Writing the graph is only possible
from the main context while holding the BQL. So if a reader is running
in the main context under the BQL and knows that it won't be interrupted
until the next writer runs, we don't actually need to do anything.

This is the case if the reader code neither has a nested event loop
(this is forbidden anyway while you hold the lock) nor is a coroutine
(because a writer could run when the coroutine has yielded).

These conditions are exactly what bdrv_graph_rdlock_main_loop() asserts.
They are not fulfilled in bdrv_graph_co_rdlock(), which always runs in a
coroutine.

This deletes the shortcuts in bdrv_graph_co_rdlock() that skip taking
the reader lock in the main thread.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-9-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/graph-lock.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index 377884c3a9..9c42bd9799 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -162,11 +162,6 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
-    /* Do not lock if in main thread */
-    if (qemu_in_main_thread()) {
-        return;
-    }
-
     for (;;) {
         qatomic_set(&bdrv_graph->reader_count,
                     bdrv_graph->reader_count + 1);
@@ -230,11 +225,6 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
-    /* Do not lock if in main thread */
-    if (qemu_in_main_thread()) {
-        return;
-    }
-
     qatomic_store_release(&bdrv_graph->reader_count,
                           bdrv_graph->reader_count - 1);
     /* make sure writer sees reader_count before we check has_writer */
-- 
2.40.1


