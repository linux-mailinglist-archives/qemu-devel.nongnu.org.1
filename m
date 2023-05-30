Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F5715F65
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:30:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yTK-0001gu-5G; Tue, 30 May 2023 08:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySy-0001T6-93
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySv-0000kx-Eo
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cL/0U57kkRIgivtOFW7jOzbBjF+YL+aWLufgO6oHXKQ=;
 b=hLWtnmbqkcLh4lIF2ZlW7iuh95tKaEH2flQWi3yzCVKJ54ZIeau0hB7IFdqmztKKzGzSdM
 Z3ejANA1Ru70CvY9YG79ccxQVGUVDJ2RpqiCD6l/mS6UwlCtiP98Rp06MuwnnmSlObZBzT
 Ky6ceenPu4GRvdgJoJtyKYXNGrLUKkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-2p9NOXE_N42jYYln0v0P1w-1; Tue, 30 May 2023 08:28:36 -0400
X-MC-Unique: 2p9NOXE_N42jYYln0v0P1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEA27800969;
 Tue, 30 May 2023 12:28:35 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4912740CFD45;
 Tue, 30 May 2023 12:28:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 11/16] migration: migration_transferred_bytes() don't need the
 QEMUFile
Date: Tue, 30 May 2023 14:28:08 +0200
Message-Id: <20230530122813.2674-12-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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
index 1696185694..a5f3fcc5ae 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -25,7 +25,7 @@ bool migration_rate_exceeded(QEMUFile *f)
     }
 
     uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
-    uint64_t rate_limit_current = migration_transferred_bytes(f);
+    uint64_t rate_limit_current = migration_transferred_bytes();
     uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
     uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
 
@@ -55,10 +55,10 @@ void migration_rate_set(uint64_t limit)
 
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
index 31d30a2ac5..24e55c5bf3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2628,7 +2628,7 @@ static MigThrError migration_detect_error(MigrationState *s)
 
 static void migration_calculate_complete(MigrationState *s)
 {
-    uint64_t bytes = migration_transferred_bytes(s->to_dst_file);
+    uint64_t bytes = migration_transferred_bytes();
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
@@ -2654,7 +2654,7 @@ static void update_iteration_initial_status(MigrationState *s)
      * wrong speed calculation.
      */
     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    s->iteration_initial_bytes = migration_transferred_bytes(s->to_dst_file);
+    s->iteration_initial_bytes = migration_transferred_bytes();
     s->iteration_initial_pages = ram_get_total_transferred_pages();
 }
 
@@ -2669,7 +2669,7 @@ static void migration_update_counters(MigrationState *s,
         return;
     }
 
-    current_bytes = migration_transferred_bytes(s->to_dst_file);
+    current_bytes = migration_transferred_bytes();
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-- 
2.40.1


