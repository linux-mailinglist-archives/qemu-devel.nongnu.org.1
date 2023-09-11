Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70879A6F1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVY-0005z3-15; Mon, 11 Sep 2023 05:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVW-0005xx-0c
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVT-0004jp-Vx
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFwqVni2BYToSGSmwjOc1Olf1klz577rtvhcTqSBmAw=;
 b=EH6Yw7TnzN87QXnSCUOdqwJs8S2m8hAtPDWDtuz55kxFj6byYkQjzwcC5myN9hXTCEEw0N
 tM3M2V3go9kB/JnsqrxHBXvyKK9Bu7kUeBb6xZ1oA3f2WNVQPok1QE7pW7QzfdAfNJmg47
 QhydxRJNcW/1TMgi2oskooT/xBp/VXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-iZ5_J1LSP-SBWjxhcx8EEQ-1; Mon, 11 Sep 2023 05:46:55 -0400
X-MC-Unique: iZ5_J1LSP-SBWjxhcx8EEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A66DD181A6E3;
 Mon, 11 Sep 2023 09:46:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 784AF40C6EA8;
 Mon, 11 Sep 2023 09:46:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 16/21] block: Mark bdrv_parent_cb_change_media()
 GRAPH_RDLOCK
Date: Mon, 11 Sep 2023 11:46:15 +0200
Message-ID: <20230911094620.45040-17-kwolf@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The function reads the parents list, so it needs to hold the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 0f7f78f8de..06d2a1b256 100644
--- a/block.c
+++ b/block.c
@@ -3371,7 +3371,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
 }
 
 
-static void bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
+static void GRAPH_RDLOCK
+bdrv_parent_cb_change_media(BlockDriverState *bs, bool load)
 {
     BdrvChild *c;
     GLOBAL_STATE_CODE();
@@ -3969,6 +3970,9 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     GLOBAL_STATE_CODE();
     assert(!qemu_in_coroutine());
 
+    /* TODO We'll eventually have to take a writer lock in this function */
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (reference) {
         bool options_non_empty = options ? qdict_size(options) : false;
         qobject_unref(options);
-- 
2.41.0


