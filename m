Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37243703E01
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:59:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeKi-0000cw-Gl; Mon, 15 May 2023 15:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKe-0000O0-HB
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKN-0005No-Gx
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghmx+kI9dt2gIdE/AzzkaNMrKaLWXjfyrkUNIMra0so=;
 b=AOAx2txNxOSKMmc5cF7Aio9M2CoyFGGeGtZGmn7xj5PJhNs7YqP6YmGCQ+EcmFmIAkc+Sb
 7q77k9TpOkOeWD22pwh3gDcqpnfaAA+d3/uBnZXV7DlBtivBMfTDhESMfZb3OysmNx5G7j
 tJvkWbQRX3r+vIzxMTHVueQYGFmlzCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-80JIUr_kM5-KmoZyNMLqWA-1; Mon, 15 May 2023 15:57:47 -0400
X-MC-Unique: 80JIUr_kM5-KmoZyNMLqWA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BC185A588;
 Mon, 15 May 2023 19:57:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E61F492B00;
 Mon, 15 May 2023 19:57:42 +0000 (UTC)
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
Subject: [PATCH v2 06/16] migration: Move migration_total_bytes() to
 migration-stats.c
Date: Mon, 15 May 2023 21:56:59 +0200
Message-Id: <20230515195709.63843-7-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Once there rename it to migration_transferred_bytes() and pass a
QEMUFile instead of a migration object.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 migration/migration-stats.h | 11 +++++++++++
 migration/migration-stats.c |  6 ++++++
 migration/migration.c       | 13 +++----------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index e39c083245..91fda378d3 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -147,4 +147,15 @@ void migration_rate_reset(void);
  * @new_rate: new maximum amount
  */
 void migration_rate_set(uint64_t new_rate);
+
+/**
+ * migration_transferred_bytes: Return number of bytes transferred
+ *
+ * @f: QEMUFile used for main migration channel
+ *
+ * Returns how many bytes have we transferred since the beginning of
+ * the migration.  It accounts for bytes sent through any migration
+ * channel, multifd, qemu_file, rdma, ....
+ */
+uint64_t migration_transferred_bytes(QEMUFile *f);
 #endif
diff --git a/migration/migration-stats.c b/migration/migration-stats.c
index 1b16edae7d..9bd97caa23 100644
--- a/migration/migration-stats.c
+++ b/migration/migration-stats.c
@@ -66,3 +66,9 @@ void migration_rate_account(uint64_t len)
 {
     stat64_add(&mig_stats.rate_limit_used, len);
 }
+
+uint64_t migration_transferred_bytes(QEMUFile *f)
+{
+    return qemu_file_transferred(f) + stat64_get(&mig_stats.multifd_bytes);
+}
+
diff --git a/migration/migration.c b/migration/migration.c
index 594709dbbc..39ff538046 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2624,16 +2624,9 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 }
 
-/* How many bytes have we transferred since the beginning of the migration */
-static uint64_t migration_total_bytes(MigrationState *s)
-{
-    return qemu_file_transferred(s->to_dst_file) +
-        stat64_get(&mig_stats.multifd_bytes);
-}
-
 static void migration_calculate_complete(MigrationState *s)
 {
-    uint64_t bytes = migration_total_bytes(s);
+    uint64_t bytes = migration_transferred_bytes(s->to_dst_file);
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
@@ -2659,7 +2652,7 @@ static void update_iteration_initial_status(MigrationState *s)
      * wrong speed calculation.
      */
     s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-    s->iteration_initial_bytes = migration_total_bytes(s);
+    s->iteration_initial_bytes = migration_transferred_bytes(s->to_dst_file);
     s->iteration_initial_pages = ram_get_total_transferred_pages();
 }
 
@@ -2674,7 +2667,7 @@ static void migration_update_counters(MigrationState *s,
         return;
     }
 
-    current_bytes = migration_total_bytes(s);
+    current_bytes = migration_transferred_bytes(s->to_dst_file);
     transferred = current_bytes - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
-- 
2.40.1


