Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2A715E12
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xwd-0005ka-Qo; Tue, 30 May 2023 07:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwC-00059L-BC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwA-0000Ap-UI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TY2CO2Lcs363lXyY0wyAxUcLaDeBd8u1b0rResvmco=;
 b=UrSmkopdfkw33b1ZFpo1zHtA63tpaneSlj0vCSt7CqAg+vq2r+GzQDtCgwd0CBAzKlDiAe
 FnVJx5SQqH2VlM4HQfA/eDrLF6p/XegBZOtGUuDxmHcc6Hmrveo3gTAn7hybiNpqqf9TIA
 DHBLoM2wwn1zliWW8INe7zlhJxQqlN8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-PkJNvZLRNuGR4lkEdrIQkA-1; Tue, 30 May 2023 07:54:49 -0400
X-MC-Unique: PkJNvZLRNuGR4lkEdrIQkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEE553C0C88A
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:48 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD1740C6EC4;
 Tue, 30 May 2023 11:54:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 12/21] migration: Create migrate_rdma()
Date: Tue, 30 May 2023 13:54:20 +0200
Message-Id: <20230530115429.1998-13-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Helper to say if we are doing a migration over rdma.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230509120700.78359-2-quintela@redhat.com>
---
 migration/migration.h | 3 +++
 migration/options.h   | 1 +
 migration/migration.c | 1 +
 migration/options.c   | 7 +++++++
 migration/rdma.c      | 4 +++-
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97635..7359572012 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -440,6 +440,9 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
+
+    /* Is this a rdma migration */
+    bool rdma_migration;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/options.h b/migration/options.h
index 45991af3c2..33a6bae93c 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -54,6 +54,7 @@ bool migrate_zero_copy_send(void);
 
 bool migrate_multifd_flush_after_each_section(void);
 bool migrate_postcopy(void);
+bool migrate_rdma(void);
 bool migrate_tls(void);
 
 /* capabilities helpers */
diff --git a/migration/migration.c b/migration/migration.c
index 7c3425c6fe..31d30a2ac5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1405,6 +1405,7 @@ void migrate_init(MigrationState *s)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    s->rdma_migration = false;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..4b99811197 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -350,6 +350,13 @@ bool migrate_postcopy(void)
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
index 12d3c23fdc..c11863e614 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4122,6 +4122,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     int ret;
     RDMAContext *rdma;
     Error *local_err = NULL;
+    MigrationState *s = migrate_get_current();
 
     trace_rdma_start_incoming_migration();
 
@@ -4152,7 +4153,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     trace_rdma_start_incoming_migration_after_rdma_listen();
-
+    s->rdma_migration = true;
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migration,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -4228,6 +4229,7 @@ void rdma_start_outgoing_migration(void *opaque,
 
     trace_rdma_start_outgoing_migration_after_rdma_connect();
 
+    s->rdma_migration = true;
     s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
     migrate_fd_connect(s, NULL);
     return;
-- 
2.40.1


