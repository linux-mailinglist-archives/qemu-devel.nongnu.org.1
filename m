Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C97B7FDC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:53:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Jh-0004Iq-Mo; Wed, 04 Oct 2023 08:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Jf-0004Hm-Ky
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Jd-0006li-QC
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9MU41DA6JfnvYM4B2zisrscwrZtuuap9bac0VUCHHY=;
 b=i/E2/cri5Cslmnsf/s9pCgwG5Z+Anvg95qUTout6m8K0pDx15gNo3n51F/PFaqk571hIG/
 oIK2cgtDyWYcIjNzmL+DEhVj5C3HsS9T7feXAkMH9zLUaxIN1XJDm8MYAt3toQh4LkHv9l
 dk/NBJdcisKtxw2ILVboSWw5B9B86GU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-fgnqabkjOGWUu0_n7yZQhQ-1; Wed, 04 Oct 2023 08:49:17 -0400
X-MC-Unique: fgnqabkjOGWUu0_n7yZQhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB35A1C0433F;
 Wed,  4 Oct 2023 12:49:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFE30C15BB8;
 Wed,  4 Oct 2023 12:49:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 01/10] migration: Create migrate_rdma()
Date: Wed,  4 Oct 2023 14:49:04 +0200
Message-ID: <20231004124913.16360-2-quintela@redhat.com>
In-Reply-To: <20231004124913.16360-1-quintela@redhat.com>
References: <20231004124913.16360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Helper to say if we are doing a migration over rdma.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h | 2 ++
 migration/options.h   | 1 +
 migration/migration.c | 1 +
 migration/options.c   | 7 +++++++
 migration/rdma.c      | 4 +++-
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 972597f4de..4543e36081 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -463,6 +463,8 @@ struct MigrationState {
      * switchover has been received.
      */
     bool switchover_acked;
+    /* Is this a rdma migration */
+    bool rdma_migration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/options.h b/migration/options.h
index 045e2a41a2..a26fd1680b 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -56,6 +56,7 @@ bool migrate_zero_copy_send(void);
 
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
+bool migrate_rdma(void);
 bool migrate_tls(void);
 
 /* capabilities helpers */
diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..1cb8898e6b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1439,6 +1439,7 @@ int migrate_init(MigrationState *s, Error **errp)
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
     s->switchover_acked = false;
+    s->rdma_migration = false;
     /*
      * set mig_stats compression_counters memory to zero for a
      * new migration
diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..0107d63b9b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -376,6 +376,13 @@ bool migrate_postcopy(void)
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
index cd5e1afe60..6219227915 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4126,6 +4126,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     int ret;
     RDMAContext *rdma;
     Error *local_err = NULL;
+    MigrationState *s = migrate_get_current();
 
     trace_rdma_start_incoming_migration();
 
@@ -4156,7 +4157,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     trace_rdma_start_incoming_migration_after_rdma_listen();
-
+    s->rdma_migration = true;
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -4233,6 +4234,7 @@ void rdma_start_outgoing_migration(void *opaque,
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
     s->to_dst_file = rdma_new_output(rdma);
+    s->rdma_migration = true;
     migrate_fd_connect(s, NULL);
     return;
 return_path_err:
-- 
2.41.0


