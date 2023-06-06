Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EC7246AD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xwh-0007np-Pj; Tue, 06 Jun 2023 10:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwf-0007mk-LN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:01 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6Xwd-0004Qb-Kc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:46:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D9EF1FD75;
 Tue,  6 Jun 2023 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686062758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIRpTkn+q/xWzKR1cEEDLTMEBE0D2WGQJOTHjKeR4x0=;
 b=PH2LR4k0YWEX9Xb5gd1roHjVm1/JYW/i8B4qe17vkyCHcJrmoF9Z9iUS4gjB18VUy/ye0S
 YJ47ZhpzETXnu1wG76opP+t/qRE34Osoh384+h39ddVYtleL1ptwQ8hSG/mrUT+SNNFLn9
 r5j7EcLj08smCMQ0aATVob1DcXfUjyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686062758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIRpTkn+q/xWzKR1cEEDLTMEBE0D2WGQJOTHjKeR4x0=;
 b=Els+Nm+2zM+SqfuBikmDv6cl6tEkhyb8pHk5eOz0uquK0veNMhogCB2buuzq12ugQKriXU
 YhqPYZmE5op/l0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 650C913519;
 Tue,  6 Jun 2023 14:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eF6rCqRGf2SRCAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 06 Jun 2023 14:45:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
Date: Tue,  6 Jun 2023 11:45:49 -0300
Message-Id: <20230606144551.24367-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230606144551.24367-1-farosas@suse.de>
References: <20230606144551.24367-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The code in threadinfo.c is only used for the QMP command
query-migrationthreads. Make it explicit that this is something
related to QMP.

The current names are also too generic for a piece of code that
doesn't affect the migration directly in any way.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  | 4 ++--
 migration/multifd.c    | 4 ++--
 migration/threadinfo.c | 4 ++--
 migration/threadinfo.h | 5 ++---
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea..e731fc98a1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2922,7 +2922,7 @@ static void *migration_thread(void *opaque)
     MigThrError thr_error;
     bool urgent = false;
 
-    thread = MigrationThreadAdd("live_migration", qemu_get_thread_id());
+    thread = qmp_migration_threads_add("live_migration", qemu_get_thread_id());
 
     rcu_register_thread();
 
@@ -3000,7 +3000,7 @@ static void *migration_thread(void *opaque)
     migration_iteration_finish(s);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-    MigrationThreadDel(thread);
+    qmp_migration_threads_remove(thread);
     return NULL;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 0bf5958a9c..5ec1ac5c64 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -651,7 +651,7 @@ static void *multifd_send_thread(void *opaque)
     int ret = 0;
     bool use_zero_copy_send = migrate_zero_copy_send();
 
-    thread = MigrationThreadAdd(p->name, qemu_get_thread_id());
+    thread = qmp_migration_threads_add(p->name, qemu_get_thread_id());
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
@@ -767,7 +767,7 @@ out:
     qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
-    MigrationThreadDel(thread);
+    qmp_migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
 
     return NULL;
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 1de8b31855..c3e85c33e8 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -14,7 +14,7 @@
 
 static QLIST_HEAD(, MigrationThread) migration_threads;
 
-MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
+MigrationThread *qmp_migration_threads_add(const char *name, int thread_id)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
     thread->name = name;
@@ -25,7 +25,7 @@ MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
     return thread;
 }
 
-void MigrationThreadDel(MigrationThread *thread)
+void qmp_migration_threads_remove(MigrationThread *thread)
 {
     if (thread) {
         QLIST_REMOVE(thread, node);
diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 4d69423c0a..61b990f5e3 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -23,6 +23,5 @@ struct MigrationThread {
     QLIST_ENTRY(MigrationThread) node;
 };
 
-MigrationThread *MigrationThreadAdd(const char *name, int thread_id);
-
-void MigrationThreadDel(MigrationThread *info);
+MigrationThread *qmp_migration_threads_add(const char *name, int thread_id);
+void qmp_migration_threads_remove(MigrationThread *info);
-- 
2.35.3


