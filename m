Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1062823B70
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:34:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQf-00049j-Ke; Wed, 03 Jan 2024 23:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQd-000451-BX
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQX-0006g8-0l
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdgknPaPIQRAT3aoK1JFpcg7tOfhi2KNrc0fRj1JKyE=;
 b=KAOlu5v4lULiZuLRMewNirEnv3wsUJcoB20nOtyQLC/Pr3R9XgLhNGIzppL483eUw0NTGJ
 b87RDOfBIet01VI79+lN4KYCWkNg3xR8lCrSznAd59qpDKWXwSnezwbK3qluM1EyRCgyo/
 BZ4S2zr+RYW897tMxVhsQiDj611RtfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-gtMyQl9kNZ-MY0aobIYGLg-1; Wed, 03 Jan 2024 23:33:49 -0500
X-MC-Unique: gtMyQl9kNZ-MY0aobIYGLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9673F848C02;
 Thu,  4 Jan 2024 04:33:48 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B93BC15968;
 Thu,  4 Jan 2024 04:33:44 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 18/26] migration: Remove errp parameter in
 migration_fd_process_incoming()
Date: Thu,  4 Jan 2024 12:32:03 +0800
Message-ID: <20240104043213.431566-19-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Errp parameter in migration_fd_process_incoming() is unused.
Remove it.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20231231093016.14204-5-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 2 +-
 migration/migration.c | 2 +-
 migration/rdma.c      | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b3c9288c38..17972dac34 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -474,7 +474,7 @@ struct MigrationState {
 
 void migrate_set_state(int *state, int old_state, int new_state);
 
-void migration_fd_process_incoming(QEMUFile *f, Error **errp);
+void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index e7d342ab59..8bb1a8134e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -774,7 +774,7 @@ static bool postcopy_try_recover(void)
     return false;
 }
 
-void migration_fd_process_incoming(QEMUFile *f, Error **errp)
+void migration_fd_process_incoming(QEMUFile *f)
 {
     migration_incoming_setup(f);
     if (postcopy_try_recover()) {
diff --git a/migration/rdma.c b/migration/rdma.c
index 04debab5d9..94c0f871f0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4035,7 +4035,6 @@ static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma = opaque;
     QEMUFile *f;
-    Error *local_err = NULL;
 
     trace_qemu_rdma_accept_incoming_migration();
     if (qemu_rdma_accept(rdma) < 0) {
@@ -4057,10 +4056,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 
     rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f, &local_err);
-    if (local_err) {
-        error_reportf_err(local_err, "RDMA ERROR:");
-    }
+    migration_fd_process_incoming(f);
 }
 
 void rdma_start_incoming_migration(InetSocketAddress *host_port,
-- 
2.41.0


