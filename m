Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5D7C4ED6
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQK-0007Ci-2j; Wed, 11 Oct 2023 05:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQG-0007BT-6e
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQD-0004sC-P6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aThOZR6aKdrOJa9Ku+YAnHK3Nu7k9Gi45I70ti2rbiA=;
 b=M2MmsakuoyLRDYng5RsrztiHg+OMiyB2qrO8L2m7X27P+QR7/iQd7qs3yLe7z6A1J1wEm4
 SAAYrXlcpP8RyLiB6c2X5OC3vLKsuBGidOQ4EQh6LSURRnZgVwt8rJGRMr/9B1w+CYuYo8
 CHsdY9FszT2aO7SPORnGSMjprhCdRKg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-QaJrle17OfWTd1GCQG7Ynw-1; Wed, 11 Oct 2023 05:22:17 -0400
X-MC-Unique: QaJrle17OfWTd1GCQG7Ynw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B464B887E45;
 Wed, 11 Oct 2023 09:22:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04C8B1C060AE;
 Wed, 11 Oct 2023 09:22:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 05/65] migration: Set migration status early in incoming side
Date: Wed, 11 Oct 2023 11:21:03 +0200
Message-ID: <20231011092203.1266-6-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

We are sending a migration event of MIGRATION_STATUS_SETUP at
qemu_start_incoming_migration but never actually setting the state.

This creates a window between qmp_migrate_incoming and
process_incoming_migration_co where the migration status is still
MIGRATION_STATUS_NONE. Calling query-migrate during this time will
return an empty response even though the incoming migration command
has already been issued.

Commit 7cf1fe6d68 ("migration: Add migration events on target side")
has added support to the 'events' capability to the incoming part of
migration, but chose to send the SETUP event without setting the
state. I'm assuming this was a mistake.

This introduces a change in behavior, any QMP client waiting for the
SETUP event will hang, unless it has previously enabled the 'events'
capability. Having the capability enabled is sufficient to continue to
receive the event.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230712190742.22294-5-farosas@suse.de>
---
 migration/migration.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..2057e42134 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -431,13 +431,16 @@ void migrate_add_address(SocketAddress *address)
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
-    qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
+                      MIGRATION_STATUS_SETUP);
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
@@ -531,7 +534,7 @@ process_incoming_migration_co(void *opaque)
 
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
-    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
+    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-- 
2.41.0


