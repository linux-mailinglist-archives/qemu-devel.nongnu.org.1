Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A727D3E52
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quz4q-0004HW-Cr; Mon, 23 Oct 2023 13:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quz4k-0004HM-Qj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quz4j-0003eN-Dx
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 13:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698083447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NfTwcwrDaknOJXbBtSUF8EhgCzreZsdFPHMf0n/3vi4=;
 b=Fewo6pQoxQL0EDo4HfNdznQO+WP5e5sSQZX40kq1lK0C6xDq0ZNjDAk+hkoAkBdHxO6LGg
 sL3lKAvqK0ph0m6Pk6JN5Hw9hTUewCtjHJawsovQnRHWUvrMzI3c/TaWnzmO59k7ZGBOrZ
 YLrMesJSG3fl9UECeIe6Ha+LhYwfAzw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-E1sF8XLuOZCZFfu-bBRrIw-1; Mon,
 23 Oct 2023 13:50:41 -0400
X-MC-Unique: E1sF8XLuOZCZFfu-bBRrIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 037E038476A9;
 Mon, 23 Oct 2023 17:50:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ABDD1C060AE;
 Mon, 23 Oct 2023 17:50:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Subject: [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=local
Date: Mon, 23 Oct 2023 19:50:38 +0200
Message-ID: <20231023175038.111607-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

No need to declare a new variable in the the inner code block
here, we can re-use the "ret" variable that has been declared
at the beginning of the function. With this change, the code
can now be successfully compiled with -Wshadow=local again.

Fixes: a32e781838 ("Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Assign "ret" only in one spot

 block/snapshot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 6e16eb803a..55974273ae 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -629,7 +629,6 @@ int bdrv_all_goto_snapshot(const char *name,
     while (iterbdrvs) {
         BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret = 0;
         bool all_snapshots_includes_bs;
 
         aio_context_acquire(ctx);
@@ -637,9 +636,8 @@ int bdrv_all_goto_snapshot(const char *name,
         all_snapshots_includes_bs = bdrv_all_snapshots_includes_bs(bs);
         bdrv_graph_rdunlock_main_loop();
 
-        if (devices || all_snapshots_includes_bs) {
-            ret = bdrv_snapshot_goto(bs, name, errp);
-        }
+        ret = (devices || all_snapshots_includes_bs) ?
+              bdrv_snapshot_goto(bs, name, errp) : 0;
         aio_context_release(ctx);
         if (ret < 0) {
             bdrv_graph_rdlock_main_loop();
-- 
2.41.0


