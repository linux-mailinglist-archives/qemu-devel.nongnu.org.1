Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84F715F52
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:29:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yTK-0001gy-5m; Tue, 30 May 2023 08:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySy-0001Tt-Ph
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySv-0000kv-Eg
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9n/azO1ejXnUZjh9UbQIWQFdiTsbqyKPWvih6P+jZM=;
 b=A6NanEMwVB/Wij4P/aSUSibSYQ/hJkrnitWF6WobyMGPMhz61+y8OEoHCXSKj3GN7R5ReS
 jfn/OULERqtm7DcxRqMASz7pjebvo7oRKox9A+lDrjj2/JAuT3MI7iOWtGu3UNyOgv3Hdy
 HAQNR4rqxaWMWks+TJjjNl1Nv0D8tWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-aiu-2T4_P7CYiErEfvvIOQ-1; Tue, 30 May 2023 08:28:37 -0400
X-MC-Unique: aiu-2T4_P7CYiErEfvvIOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ED52101A531;
 Tue, 30 May 2023 12:28:37 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04A0E40CFD45;
 Tue, 30 May 2023 12:28:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 12/16] migration: migration_rate_limit_reset() don't need the
 QEMUFile
Date: Tue, 30 May 2023 14:28:09 +0200
Message-Id: <20230530122813.2674-13-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 4 +---
 migration/migration-stats.c | 2 +-
 migration/migration.c       | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index e3863bf9bb..68f3939188 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -120,10 +120,8 @@ uint64_t migration_rate_get(void);
  * migration_rate_reset: Reset the rate limit counter.
  *
  * This is called when we know we start a new transfer cycle.
- *
- * @f: QEMUFile used for main migration channel
  */
-void migration_rate_reset(QEMUFile *f);
+void migration_rate_reset(void);
 
 /**
  * migration_rate_set: Set the maximum amount that can be transferred.
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index a5f3fcc5ae..df541fa904 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -53,7 +53,7 @@ void migration_rate_set(uint64_t limit)
     stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
 }
 
-void migration_rate_reset(QEMUFile *f)
+void migration_rate_reset(void)
 {
     stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes());
 }
diff --git a/migration/migration.c b/migration/migration.c
index 24e55c5bf3..ab8254e433 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2693,7 +2693,7 @@ static void migration_update_counters(MigrationState *s,
             stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
     }
 
-    migration_rate_reset(s->to_dst_file);
+    migration_rate_reset();
 
     update_iteration_initial_status(s);
 
-- 
2.40.1


