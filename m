Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6B84D83C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Feb 2024 04:12:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulM-0000UZ-A0; Wed, 07 Feb 2024 22:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukp-0007Fd-2Q
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukm-0004SS-LL
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ghuKxeFZpBanNogPdnPaumsPzZ5xJQiFLT94YYQw2kw=;
 b=IrIeLtrFlfCnMrejpPDb+7lfvJxUnd4tWZDuIyz9P2ELIe1KvhJAXVrT6QkUYsWyqx3T7T
 ltaPkdZ9WYRCzqMy3OjYPs2rOeIeU+pJJIQuSP4jy6GabI4SqJLObvPSdXIjqq9lWoCG1o
 290qINeUk5D3Tl7hQM40lU1fYtWFO2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-I4BFMWgDMiqFfPVzTr1ToA-1; Wed, 07 Feb 2024 22:07:06 -0500
X-MC-Unique: I4BFMWgDMiqFfPVzTr1ToA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33EF2859552;
 Thu,  8 Feb 2024 03:07:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3592492BC7;
 Thu,  8 Feb 2024 03:07:03 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 29/34] migration/multifd: Move multifd_send_setup into
 migration thread
Date: Thu,  8 Feb 2024 11:05:23 +0800
Message-ID: <20240208030528.368214-30-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We currently have an unfavorable situation around multifd channels
creation and the migration thread execution.

We create the multifd channels with qio_channel_socket_connect_async
-> qio_task_run_in_thread, but only connect them at the
multifd_new_send_channel_async callback, called from
qio_task_complete, which is registered as a glib event.

So at multifd_send_setup() we create the channels, but they will only
be actually usable after the whole multifd_send_setup() calling stack
returns back to the main loop. Which means that the migration thread
is already up and running without any possibility for the multifd
channels to be ready on time.

We currently rely on the channels-ready semaphore blocking
multifd_send_sync_main() until channels start to come up and release
it. However there have been bugs recently found when a channel's
creation fails and multifd_send_cleanup() is allowed to run while
other channels are still being created.

Let's start to organize this situation by moving the
multifd_send_setup() call into the migration thread. That way we
unblock the main-loop to dispatch the completion callbacks and
actually have a chance of getting the multifd channels ready for when
the migration thread needs them.

The next patches will deal with the synchronization aspects.

Note that this takes multifd_send_setup() out of the BQL.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6432a81e8b..ab21de2cad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3327,6 +3327,10 @@ static void *migration_thread(void *opaque)
     object_ref(OBJECT(s));
     update_iteration_initial_status(s);
 
+    if (!multifd_send_setup()) {
+        goto out;
+    }
+
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
     bql_unlock();
@@ -3398,6 +3402,7 @@ static void *migration_thread(void *opaque)
         urgent = migration_rate_limit();
     }
 
+out:
     trace_migration_thread_after_loop();
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
@@ -3635,11 +3640,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (!multifd_send_setup()) {
-        migrate_fd_cleanup(s);
-        return;
-    }
-
     if (migrate_background_snapshot()) {
         qemu_thread_create(&s->thread, "bg_snapshot",
                 bg_migration_thread, s, QEMU_THREAD_JOINABLE);
-- 
2.43.0


