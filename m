Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832B7CBDB7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfTy-0005Ff-0J; Tue, 17 Oct 2023 04:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTr-00055E-SG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTn-0005Mq-1S
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFM+KxjY0FRTwXEN9vOUxGgshX0DnR8Xi/mjhsGnXh0=;
 b=IDJUVxah5xjpX8oNonqlKQFkD3DGT/tsRpMcFQ5MBHTQXjfLCGULf3QjlO6k1IvC2K8Y6+
 G1I+eWUzmpS8aIaGK+yx430NRgb9s+6EgO7KO5WX3BEag3lr7ZzZvc+B4xumf2deNvWxRD
 Z1Zv3my/lZztm5pJUDkmSCBRRLbLFck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-FMlfsTlAOAyFiHpG0RGs0w-1; Tue, 17 Oct 2023 04:30:51 -0400
X-MC-Unique: FMlfsTlAOAyFiHpG0RGs0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 819348F15C2;
 Tue, 17 Oct 2023 08:30:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB5341C060AE;
 Tue, 17 Oct 2023 08:30:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 14/38] migration: Create migrate_rdma()
Date: Tue, 17 Oct 2023 10:29:39 +0200
Message-ID: <20231017083003.15951-15-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Helper to say if we are doing a migration over rdma.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011203527.9061-2-quintela@redhat.com>
---
 migration/migration.h | 2 ++
 migration/options.h   | 1 +
 migration/migration.c | 1 +
 migration/options.c   | 7 +++++++
 migration/rdma.c      | 4 +++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 974897a8d0..ae82004892 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -469,6 +469,8 @@ struct MigrationState {
      * switchover has been received.
      */
     bool switchover_acked;
+    /* Is this a rdma migration */
+    bool rdma_migration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/options.h b/migration/options.h
index 93ee938ab8..237f2d6b4a 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -56,6 +56,7 @@ bool migrate_zero_copy_send(void);
 
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
+bool migrate_rdma(void);
 bool migrate_tls(void);
 
 /* capabilities helpers */
diff --git a/migration/migration.c b/migration/migration.c
index 79fa11e3f6..6ba5e145ac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1452,6 +1452,7 @@ int migrate_init(MigrationState *s, Error **errp)
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
     s->switchover_acked = false;
+    s->rdma_migration = false;
     /*
      * set mig_stats compression_counters memory to zero for a
      * new migration
diff --git a/migration/options.c b/migration/options.c
index 546cbe3106..42fb818956 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -378,6 +378,13 @@ bool migrate_postcopy(void)
     return migrate_postcopy_ram() || migrate_dirty_bitmaps();
 }
 
+bool migrate_rdma(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->rdma_migration;
+}
+
 bool migrate_tls(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/rdma.c b/migration/rdma.c
index f6fc226c9b..f155f3e1c8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4113,6 +4113,7 @@ static void rdma_accept_incoming_migration(void *opaque)
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
+    MigrationState *s = migrate_get_current();
     int ret;
     RDMAContext *rdma;
 
@@ -4144,7 +4145,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     trace_rdma_start_incoming_migration_after_rdma_listen();
-
+    s->rdma_migration = true;
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -4220,6 +4221,7 @@ void rdma_start_outgoing_migration(void *opaque,
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
     s->to_dst_file = rdma_new_output(rdma);
+    s->rdma_migration = true;
     migrate_fd_connect(s, NULL);
     return;
 return_path_err:
-- 
2.41.0


