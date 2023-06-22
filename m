Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7738173A6BB
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:57:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbw-0008PD-A7; Thu, 22 Jun 2023 12:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbu-0008L5-0g
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbs-00011e-FP
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjS5IFyqEQRzXQMIiiaiZNodUT68pKhyOYOrJhA5FC4=;
 b=RPKJ1zdod6gRs2jP3NhhebF+iFGPwO7U1wX6htPh+WHvDrS7gDShXWwHzqp0yACWAiz8CS
 YF9yjvtfrxGujebFYo6vEq6ec0FLsOnyL9kLFrEuCD1IKwwZ5vd/f2CzPCj4wTrvuUlacg
 mDuRdiAqWS890wENslGI3NtqT7FQJkc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-u6rf5DTqP0eiKvSVNmJQxA-1; Thu, 22 Jun 2023 12:56:32 -0400
X-MC-Unique: u6rf5DTqP0eiKvSVNmJQxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5784185A7A7;
 Thu, 22 Jun 2023 16:56:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F61CC00049;
 Thu, 22 Jun 2023 16:56:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Tejus GK <tejus.gk@nutanix.com>
Subject: [PULL 20/30] migration: Update error description whenever migration
 fails
Date: Thu, 22 Jun 2023 18:55:17 +0200
Message-Id: <20230622165527.2417-21-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tejus GK <tejus.gk@nutanix.com>

There are places in migration.c where the migration is marked failed with
MIGRATION_STATUS_FAILED, but the failure reason is never updated. Hence
libvirt doesn't know why the migration failed when it queries for it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Message-ID: <20230621130940.178659-2-tejus.gk@nutanix.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 719f91573f..e6bff2e848 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1679,7 +1679,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
@@ -2066,7 +2066,7 @@ migration_wait_main_channel(MigrationState *ms)
  * Switch from normal iteration to postcopy
  * Returns non-0 on error
  */
-static int postcopy_start(MigrationState *ms)
+static int postcopy_start(MigrationState *ms, Error **errp)
 {
     int ret;
     QIOChannelBuffer *bioc;
@@ -2176,7 +2176,7 @@ static int postcopy_start(MigrationState *ms)
      */
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored (pre package)");
+        error_setg(errp, "postcopy_start: Migration stream errored (pre package)");
         goto fail_closefb;
     }
 
@@ -2213,7 +2213,7 @@ static int postcopy_start(MigrationState *ms)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored");
+        error_setg(errp, "postcopy_start: Migration stream errored");
         migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                               MIGRATION_STATUS_FAILED);
     }
@@ -2720,6 +2720,7 @@ typedef enum {
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
+    Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
@@ -2742,8 +2743,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     /* Still a significant amount to transfer */
     if (!in_postcopy && must_precopy <= s->threshold_size &&
         qatomic_read(&s->start_postcopy)) {
-        if (postcopy_start(s)) {
-            error_report("%s: postcopy failed to start", __func__);
+        if (postcopy_start(s, &local_err)) {
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
         }
         return MIG_ITERATE_SKIP;
     }
@@ -3234,8 +3236,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s, !resume)) {
-            error_report("Unable to open return-path for postcopy");
+            error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
             migrate_fd_cleanup(s);
             return;
         }
@@ -3259,6 +3263,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
+        migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-- 
2.40.1


