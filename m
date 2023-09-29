Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDB7B362D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErW-0005zs-FG; Fri, 29 Sep 2023 10:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErU-0005yy-KK
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr1-0004mE-Vx
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcY7jHXI4rUDkVB3lSn5hImRkoKgWs/AqeuuXeuUEWM=;
 b=EjVTW1nXMphqDg7GK+u7EXls7t538BRBpVjjkneYGQT1LZVaE76xH0hqiFwNywRq5zpA68
 ilMJWX51Rzw9nKHQhak20v/aiFc+DdtWZsoAz/pgZqnAlud7HZyS87sGbOK3gmVS2HD8kR
 X2JU4ZIx8uOQbsN+8cRg679D4VIeuAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-BhSnz9NMNjmFmu1gESVt_Q-1; Fri, 29 Sep 2023 10:52:26 -0400
X-MC-Unique: BhSnz9NMNjmFmu1gESVt_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9992285A5A8;
 Fri, 29 Sep 2023 14:52:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ADF32026D4B;
 Fri, 29 Sep 2023 14:52:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 16/22] qcow2: Mark check_constraints_on_bitmap() GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:51 +0200
Message-ID: <20230929145157.45443-17-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
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

It still has an assume_graph_lock() call, but all of its callers are now
properly annotated to hold the graph lock. Update the function to be
GRAPH_RDLOCK as well and remove the assume_graph_lock().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-bitmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 80f3ecea62..9c1b5e3d00 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -156,18 +156,15 @@ static int64_t get_bitmap_bytes_needed(int64_t len, uint32_t granularity)
     return DIV_ROUND_UP(num_bits, 8);
 }
 
-static int check_constraints_on_bitmap(BlockDriverState *bs,
-                                       const char *name,
-                                       uint32_t granularity,
-                                       Error **errp)
+static int GRAPH_RDLOCK
+check_constraints_on_bitmap(BlockDriverState *bs, const char *name,
+                            uint32_t granularity, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int granularity_bits = ctz32(granularity);
     int64_t len = bdrv_getlength(bs);
     int64_t bitmap_bytes;
 
-    assume_graph_lock(); /* FIXME */
-
     assert(granularity > 0);
     assert((granularity & (granularity - 1)) == 0);
 
-- 
2.41.0


