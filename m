Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC775F7F6
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:13:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvHX-0004AQ-9L; Mon, 24 Jul 2023 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHM-00046l-T9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qNvHK-0002ac-26
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690204028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6NDPnkzHlHMJ2E96BT2L8DNXWr8MPzQrE/ZuIz1ThM=;
 b=XeyOUwa1NRfBiYtUJdgixOnBitxnLvMv6UT2q4JKGr91UZXwctf4VuyUojleZVWs/SEpDn
 H024Qh2CED4RvXu/NKXM47MYkhdqeSTwLnerhOjK4WdVq38Gkmr7PjG7ANQ3haowUYwAgx
 IjhYNfPbyfZeb5NNWZfc+a5M5k1guM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-qYq6qj0gPKad8U-KUuThcA-1; Mon, 24 Jul 2023 09:07:01 -0400
X-MC-Unique: qYq6qj0gPKad8U-KUuThcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D8810504BD;
 Mon, 24 Jul 2023 13:07:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08C65F782E;
 Mon, 24 Jul 2023 13:06:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PATCH 08/26] migration: Put the detection logic before auto-converge
 checking
Date: Mon, 24 Jul 2023 15:06:21 +0200
Message-Id: <20230724130639.93135-9-quintela@redhat.com>
In-Reply-To: <20230724130639.93135-1-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

This commit is prepared for the implementation of dirty-limit
convergence algo.

The detection logic of throttling condition can apply to both
auto-converge and dirty-limit algo, putting it's position
before the checking logic for auto-converge feature.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-ID: <168733225273.5845.15871826788879741674-6@git.sr.ht>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f31de47a47..1d9300f4c5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -999,17 +999,18 @@ static void migration_trigger_throttle(RAMState *rs)
         return;
     }
 
-    if (migrate_auto_converge()) {
-        /* The following detection logic can be refined later. For now:
-           Check to see if the ratio between dirtied bytes and the approx.
-           amount of bytes that just got transferred since the last time
-           we were in this routine reaches the threshold. If that happens
-           twice, start or increase throttling. */
-
-        if ((bytes_dirty_period > bytes_dirty_threshold) &&
-            (++rs->dirty_rate_high_cnt >= 2)) {
+    /*
+     * The following detection logic can be refined later. For now:
+     * Check to see if the ratio between dirtied bytes and the approx.
+     * amount of bytes that just got transferred since the last time
+     * we were in this routine reaches the threshold. If that happens
+     * twice, start or increase throttling.
+     */
+    if ((bytes_dirty_period > bytes_dirty_threshold) &&
+        (++rs->dirty_rate_high_cnt >= 2)) {
+        rs->dirty_rate_high_cnt = 0;
+        if (migrate_auto_converge()) {
             trace_migration_throttle();
-            rs->dirty_rate_high_cnt = 0;
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
         }
-- 
2.40.1


