Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E6703DFB
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeKa-0008TY-B8; Mon, 15 May 2023 15:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKX-0008NO-M0
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKW-0005QE-4l
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETJF60hxjmKnJX+sqEumgfInbHjCRkAKUrzHn6nnpNQ=;
 b=EdLabVCM4A+9s5qsSlBtkaAM8779alfaDEnbWQ3LFdWjkTchIizToFNF1jGi2OUn5ldOz+
 TBab6IT1sdalclFEM8PvodqyvkLlc94RYV/QRxp+GcjkcO6baFRTAdRMNu7IpbZAhrNWww
 uMeUWLx8/QqC6w/4/NVYB2vHCHcRcco=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-IRhQcHelPXCaaKmtw0perg-1; Mon, 15 May 2023 15:57:55 -0400
X-MC-Unique: IRhQcHelPXCaaKmtw0perg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65C352999B28;
 Mon, 15 May 2023 19:57:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B923492B00;
 Mon, 15 May 2023 19:57:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 08/16] migration: Use migration_transferred_bytes() to
 calculate rate_limit
Date: Mon, 15 May 2023 21:57:01 +0200
Message-Id: <20230515195709.63843-9-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 migration/migration-stats.h | 8 +++++++-
 migration/migration-stats.c | 7 +++++--
 migration/migration.c       | 2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 91fda378d3..f1465c2ebe 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -81,6 +81,10 @@ typedef struct {
      * Number of bytes sent during precopy stage.
      */
     Stat64 precopy_bytes;
+    /*
+     * Amount of transferred data at the start of current cycle.
+     */
+    Stat64 rate_limit_start;
     /*
      * Maximum amount of data we can send in a cycle.
      */
@@ -136,8 +140,10 @@ uint64_t migration_rate_get(void);
  * migration_rate_reset: Reset the rate limit counter.
  *
  * This is called when we know we start a new transfer cycle.
+ *
+ * @f: QEMUFile used for main migration channel
  */
-void migration_rate_reset(void);
+void migration_rate_reset(QEMUFile *f);
 
 /**
  * migration_rate_set: Set the maximum amount that can be transferred.
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 301392d208..da2bb69a15 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -31,7 +31,9 @@ bool migration_rate_exceeded(QEMUFile *f)
         return true;
     }
 
-    uint64_t rate_limit_used = stat64_get(&mig_stats.rate_limit_used);
+    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
+    uint64_t rate_limit_current = migration_transferred_bytes(f);
+    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
     uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);
 
     if (rate_limit_max == RATE_LIMIT_MAX) {
@@ -58,9 +60,10 @@ void migration_rate_set(uint64_t limit)
     stat64_set(&mig_stats.rate_limit_max, limit / XFER_LIMIT_RATIO);
 }
 
-void migration_rate_reset(void)
+void migration_rate_reset(QEMUFile *f)
 {
     stat64_set(&mig_stats.rate_limit_used, 0);
+    stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes(f));
 }
 
 void migration_rate_account(uint64_t len)
diff --git a/migration/migration.c b/migration/migration.c
index 39ff538046..e48dd593ed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2691,7 +2691,7 @@ static void migration_update_counters(MigrationState *s,
             stat64_get(&mig_stats.dirty_bytes_last_sync) / bandwidth;
     }
 
-    migration_rate_reset();
+    migration_rate_reset(s->to_dst_file);
 
     update_iteration_initial_status(s);
 
-- 
2.40.1


