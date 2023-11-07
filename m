Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B307E48A9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6J-0004aM-0q; Tue, 07 Nov 2023 13:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5m-0003zP-Hk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0001VL-Ic
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcuOf9Rl0aKadUvT8nleBmaG7Y6sOaD9QAYnICflMR0=;
 b=gDqsOVsKnFJUwvHRLRFz3++2nnzsXV/MLuarlcBF0Po1zLUYoEiaNjZF412mVXd+3hZDR8
 QETiKVmV+ZbEiSJLOJqawNnPwl8HU+7fx+ZdG9GZkfn1vM95XWjtbpQEOP/dzRgEoy4PiL
 ZUmnLRz/tFnaAXgkqgBwpjm2n6x+MJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-C8YesaxwOROfZaud8W5whw-1; Tue,
 07 Nov 2023 13:46:17 -0500
X-MC-Unique: C8YesaxwOROfZaud8W5whw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B62C3C1CC2C
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:17 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 264EFC1290F;
 Tue,  7 Nov 2023 18:46:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 13/25] block: Mark bdrv_set_backing_hd_drained() GRAPH_WRLOCK
Date: Tue,  7 Nov 2023 19:45:53 +0100
Message-ID: <20231107184605.236540-14-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_set_backing_hd_drained(). Basically everthing
in the function needs the lock and its callers may already want to hold
the graph lock and so wouldn't be able to call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-14-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 7 ++++---
 block.c                            | 4 ++--
 block/stream.c                     | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9a33bd7ef9..a1fd70ec97 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -101,9 +101,10 @@ bdrv_co_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 
 int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                         Error **errp);
-int bdrv_set_backing_hd_drained(BlockDriverState *bs,
-                                BlockDriverState *backing_hd,
-                                Error **errp);
+int GRAPH_WRLOCK
+bdrv_set_backing_hd_drained(BlockDriverState *bs, BlockDriverState *backing_hd,
+                            Error **errp);
+
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 
diff --git a/block.c b/block.c
index 499b147315..d79a6f41f9 100644
--- a/block.c
+++ b/block.c
@@ -3557,7 +3557,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
     if (bs->backing) {
         assert(bs->backing->bs->quiesce_counter > 0);
     }
-    bdrv_graph_wrlock(backing_hd);
 
     ret = bdrv_set_backing_noperm(bs, backing_hd, tran, errp);
     if (ret < 0) {
@@ -3567,7 +3566,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
     tran_finalize(tran, ret);
-    bdrv_graph_wrunlock();
     return ret;
 }
 
@@ -3580,7 +3578,9 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
 
     bdrv_ref(drain_bs);
     bdrv_drained_begin(drain_bs);
+    bdrv_graph_wrlock(backing_hd);
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
+    bdrv_graph_wrunlock();
     bdrv_drained_end(drain_bs);
     bdrv_unref(drain_bs);
 
diff --git a/block/stream.c b/block/stream.c
index 3f5d773535..0b92410c00 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -99,7 +99,9 @@ static int stream_prepare(Job *job)
             }
         }
 
+        bdrv_graph_wrlock(base);
         bdrv_set_backing_hd_drained(unfiltered_bs, base, &local_err);
+        bdrv_graph_wrunlock();
 
         /*
          * This call will do I/O, so the graph can change again from here on.
-- 
2.41.0


