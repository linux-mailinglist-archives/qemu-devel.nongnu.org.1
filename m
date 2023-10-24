Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F77D54F1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJ4C-00050s-9X; Tue, 24 Oct 2023 11:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3x-0004uZ-RO
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3r-0000qA-45
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698160273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/ucJK2zT45JBiS6fomF1EfQzVgKI9ahmergmnxzdfw=;
 b=eyEljb4qtrrDCjEU/C2b/0x6sB9+d3+dLlwXbNsZJx0GwU82I6+zZDkosOU2ttKZeCVatQ
 c79hUyd2pk46+VoU6mu6eENi/IVE0e2jErEjXeKnZfrRvIjJigt+zfj+SpHR7FrToUGdfY
 H41x3bgbhKWtlpl1WG3RCh1Y6sfDfFQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-pzJdIBKcMOS78fnfWT5Fig-1; Tue,
 24 Oct 2023 11:11:08 -0400
X-MC-Unique: pzJdIBKcMOS78fnfWT5Fig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45BA91C0519D;
 Tue, 24 Oct 2023 15:11:07 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 627DC2026D4C;
 Tue, 24 Oct 2023 15:11:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 10/12] migration: Use migration_transferred_bytes()
Date: Tue, 24 Oct 2023 17:10:40 +0200
Message-ID: <20231024151042.90349-11-quintela@redhat.com>
In-Reply-To: <20231024151042.90349-1-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

There are only two differnces with the old value:

- the amount of QEMUFile that hasn't yet been flushed.  It can be
  discussed what is more exact, the new or the old one.
- the amount of transferred bytes that we forgot to account for (the
  newer is better, i.e. exact).

Notice that this two values are used to:
a - present to the user
b - calculate the rate_limit

So a few KB here and there is not going to make a difference.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 +-
 migration/ram.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bb62244288..a6cde985a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -942,7 +942,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     size_t page_size = qemu_target_page_size();
 
     info->ram = g_malloc0(sizeof(*info->ram));
-    info->ram->transferred = stat64_get(&mig_stats.transferred);
+    info->ram->transferred = migration_transferred_bytes();
     info->ram->total = ram_bytes_total();
     info->ram->duplicate = stat64_get(&mig_stats.zero_pages);
     /* legacy value.  It is not used anymore */
diff --git a/migration/ram.c b/migration/ram.c
index 92769902bb..5ccf70333a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -564,7 +564,7 @@ void mig_throttle_counter_reset(void)
 
     rs->time_last_bitmap_sync = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     rs->num_dirty_pages_period = 0;
-    rs->bytes_xfer_prev = stat64_get(&mig_stats.transferred);
+    rs->bytes_xfer_prev = migration_transferred_bytes();
 }
 
 /**
@@ -1030,7 +1030,7 @@ static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold = migrate_throttle_trigger_threshold();
     uint64_t bytes_xfer_period =
-        stat64_get(&mig_stats.transferred) - rs->bytes_xfer_prev;
+        migration_transferred_bytes() - rs->bytes_xfer_prev;
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
 
@@ -1100,7 +1100,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
         /* reset period counters */
         rs->time_last_bitmap_sync = end_time;
         rs->num_dirty_pages_period = 0;
-        rs->bytes_xfer_prev = stat64_get(&mig_stats.transferred);
+        rs->bytes_xfer_prev = migration_transferred_bytes();
     }
     if (migrate_events()) {
         uint64_t generation = stat64_get(&mig_stats.dirty_sync_count);
-- 
2.41.0


