Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04B703DF7
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeK8-0007NR-9R; Mon, 15 May 2023 15:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeK2-0007Mq-1g
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeJx-0005Gi-Dq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeHm5dXsEgwrKffR59GDRBqQ+8zkfqjjN8hVgbkHBPE=;
 b=KUyt9OcLFODihTCcl9JuMT2apCJjiiedRgnXfw1/4bqavZoirV/brRlG79ChjXCinrxfEO
 nG6nM6kjALzUAf7rb/VyMKuede2DgErpfwf4HUejC/uEyh0xYbMOa8OeAfE/Ty/TDtP/Jj
 LHLji+EEkUPso4dVDALH7iVjhDi5fGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-vaAekEdaPG-1H9IUn4HgJg-1; Mon, 15 May 2023 15:57:19 -0400
X-MC-Unique: vaAekEdaPG-1H9IUn4HgJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82520101A557;
 Mon, 15 May 2023 19:57:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABD40492B00;
 Mon, 15 May 2023 19:57:14 +0000 (UTC)
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
Subject: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
Date: Mon, 15 May 2023 21:56:54 +0200
Message-Id: <20230515195709.63843-2-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Define and use RATE_LIMIT_MAX instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-stats.h | 6 ++++++
 migration/migration.c       | 4 ++--
 migration/qemu-file.c       | 6 +++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index cf8a4f0410..e782f1b0df 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -15,6 +15,12 @@
 
 #include "qemu/stats64.h"
 
+/*
+ * If rate_limit_max is 0, there is special code to remove the rate
+ * limit.
+ */
+#define RATE_LIMIT_MAX 0
+
 /*
  * These are the ram migration statistic counters.  It is loosely
  * based on MigrationStats.  We change to Stat64 any counter that
diff --git a/migration/migration.c b/migration/migration.c
index 039bba4804..c41c7491bb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2304,7 +2304,7 @@ static void migration_completion(MigrationState *s)
                  * them if migration fails or is cancelled.
                  */
                 s->block_inactive = !migrate_colo();
-                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
+                qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                                          s->block_inactive);
             }
@@ -3048,7 +3048,7 @@ static void *bg_migration_thread(void *opaque)
     rcu_register_thread();
     object_ref(OBJECT(s));
 
-    qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
+    qemu_file_set_rate_limit(s->to_dst_file, RATE_LIMIT_MAX);
 
     setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 597054759d..4bc875b452 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "migration.h"
+#include "migration-stats.h"
 #include "qemu-file.h"
 #include "trace.h"
 #include "options.h"
@@ -732,7 +733,10 @@ int qemu_file_rate_limit(QEMUFile *f)
     if (qemu_file_get_error(f)) {
         return 1;
     }
-    if (f->rate_limit_max > 0 && f->rate_limit_used > f->rate_limit_max) {
+    if (f->rate_limit_max == RATE_LIMIT_MAX) {
+        return 0;
+    }
+    if (f->rate_limit_used > f->rate_limit_max) {
         return 1;
     }
     return 0;
-- 
2.40.1


