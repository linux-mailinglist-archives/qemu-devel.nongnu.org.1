Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E357D54FD
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJ48-0004zj-0W; Tue, 24 Oct 2023 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3p-0004t4-CS
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3n-0000oV-7t
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698160264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIVUjfgNPP/9tFC7pb4+o2lGmeTolR/aIecHGLMCun8=;
 b=HQTlJWajOif+i9Sqf/Nh9jT1s98JLwf0Qlorit97xsAdvun0W/yxX+unEndc6UZZswuyjC
 W0G35YNYkV9kLyJsWQYXpYLFWB68TNpVfN44FwbHV+U9SCKohAEJRBQbFNr8SZtFWqHnzh
 xq+SG7PfsFo10xVbtc7+se+wyhfuPgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-UuCoGOSvN_C729eMZPRFog-1; Tue, 24 Oct 2023 11:11:00 -0400
X-MC-Unique: UuCoGOSvN_C729eMZPRFog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 052631869B63;
 Tue, 24 Oct 2023 15:11:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC742026D4C;
 Tue, 24 Oct 2023 15:10:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] migration: migration_transferred_bytes() don't need the
 QEMUFile
Date: Tue, 24 Oct 2023 17:10:37 +0200
Message-ID: <20231024151042.90349-8-quintela@redhat.com>
In-Reply-To: <20231024151042.90349-1-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 4 +---
 migration/migration-stats.c | 6 +++---
 migration/migration.c       | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index b7795e7914..e3863bf9bb 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -137,11 +137,9 @@ void migration_rate_set(uint64_t new_rate);
 /**
  * migration_transferred_bytes: Return number of bytes transferred
  *
- * @f: QEMUFile used for main migration channel
- *
  * Returns how many bytes have we transferred since the beginning of
  * the migration.  It accounts for bytes sent through any migration
  * channel, multifd, qemu_file, rdma, ....
  */
-uint64_t migration_transferred_bytes(QEMUFile *f);
+uint64_t migration_transferred_bytes(void);
 #endif
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 1d9197b4c3..4ae8c0c722 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -30,7 +30,7 @@ bool migration_rate_exceeded(QEMUFile *f)
     }
 
     uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
-    uint64_t rate_limit_current = migration_transferred_bytes(f);
+    uint64_t rate_limit_current = migration_transferred_bytes();
     uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
 
     if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
@@ -56,10 +56,10 @@ void migration_rate_set(uint64_t limit)
 
 void migration_rate_reset(QEMUFile *f)
 {
-    stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes(f));
+    stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes());
 }
 
-uint64_t migration_transferred_bytes(QEMUFile *f)
+uint64_t migration_transferred_bytes(void)
 {
     uint64_t multifd = stat64_get(&mig_stats.multifd_bytes);
     uint64_t rdma = stat64_get(&mig_stats.rdma_bytes);
diff --git a/migration/migration.c b/migration/migration.c
index 67547eb6a1..e199d2f50d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2694,7 +2694,7 @@ static MigThrError migration_detect_error(MigrationState *s)
 
 static void migration_calculate_complete(MigrationState *s)
 {
-    uint64_t bytes = migration_transferred_bytes(s->to_dst_file);
+    uint64_t bytes = migration_transferred_bytes();
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
@@ -2720,7 +2720,7 @@ static void update_iteration_initial_status(MigrationState *s)
      * wrong speed calculation.
      */
     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    s->iteration_initial_bytes = migration_transferred_bytes(s->to_dst_file);
+    s->iteration_initial_bytes = migration_transferred_bytes();
     s->iteration_initial_pages = ram_get_total_transferred_pages();
 }
 
@@ -2739,7 +2739,7 @@ static void migration_update_counters(MigrationState *s,
     }
 
     switchover_bw = migrate_avail_switchover_bandwidth();
-    current_bytes = migration_transferred_bytes(s->to_dst_file);
+    current_bytes = migration_transferred_bytes();
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-- 
2.41.0


