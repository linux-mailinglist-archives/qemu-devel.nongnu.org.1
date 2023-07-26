Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B3763616
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdQY-0006J1-5h; Wed, 26 Jul 2023 08:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQA-0006IF-L7
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOdQ5-00040b-1f
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690373708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyedKh1dNtVU/WHKU4Zp18V/WTgaYdHAH48231Q1C1Q=;
 b=OTcBoUVWhWlqS7M95hN4J2oxeroJbYprbOdQkZvTabbaGw8PyzCixDwoFLdgtqlJHAqffy
 v1zVRzmVDtbJMocVpKaeo8H6pj4GMq6VRuwjju01O9UhOwFwooJxGJZwMb3o+hqgM0ubpB
 wG9o99+fd5gh0dVVX0Dm5dyY22QTcbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-jDJH2vJ_Mf-qSipeWKULZw-1; Wed, 26 Jul 2023 08:15:06 -0400
X-MC-Unique: jDJH2vJ_Mf-qSipeWKULZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1031B185A78F;
 Wed, 26 Jul 2023 12:15:06 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1844040C206F;
 Wed, 26 Jul 2023 12:15:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/25] migration/multifd: Rename threadinfo.c functions
Date: Wed, 26 Jul 2023 14:14:35 +0200
Message-Id: <20230726121459.1837-2-quintela@redhat.com>
In-Reply-To: <20230726121459.1837-1-quintela@redhat.com>
References: <20230726121459.1837-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

We're about to add more functions to this file so make it use the same
coding style as the rest of the code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230607161306.31425-2-farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/threadinfo.h | 5 ++---
 migration/migration.c  | 4 ++--
 migration/multifd.c    | 4 ++--
 migration/threadinfo.c | 4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 4d69423c0a..8aa6999d58 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -23,6 +23,5 @@ struct MigrationThread {
     QLIST_ENTRY(MigrationThread) node;
 };
 
-MigrationThread *MigrationThreadAdd(const char *name, int thread_id);
-
-void MigrationThreadDel(MigrationThread *info);
+MigrationThread *migration_threads_add(const char *name, int thread_id);
+void migration_threads_remove(MigrationThread *info);
diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..ae49d42eab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2953,7 +2953,7 @@ static void *migration_thread(void *opaque)
     MigThrError thr_error;
     bool urgent = false;
 
-    thread = MigrationThreadAdd("live_migration", qemu_get_thread_id());
+    thread = migration_threads_add("live_migration", qemu_get_thread_id());
 
     rcu_register_thread();
 
@@ -3031,7 +3031,7 @@ static void *migration_thread(void *opaque)
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    MigrationThreadDel(thread);
+    migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0e3ae87449..0f6b203877 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -651,7 +651,7 @@ static void *multifd_send_thread(void *opaque)
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
-    thread = MigrationThreadAdd(p->name, qemu_get_thread_id());
+    thread = migration_threads_add(p->name, qemu_get_thread_id());
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
@@ -767,7 +767,7 @@ out:
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    MigrationThreadDel(thread);
+    migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 1de8b31855..3dd9b14ae6 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -14,7 +14,7 @@
 
 static QLIST_HEAD(, MigrationThread) migration_threads;
 
-MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
+MigrationThread *migration_threads_add(const char *name, int thread_id)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
     thread->name = name;
@@ -25,7 +25,7 @@ MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
     return thread;
 }
 
-void MigrationThreadDel(MigrationThread *thread)
+void migration_threads_remove(MigrationThread *thread)
 {
     if (thread) {
         QLIST_REMOVE(thread, node);
-- 
2.40.1


