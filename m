Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDDD7CC20B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsidD-0004BC-Kp; Tue, 17 Oct 2023 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsidB-0004AI-IX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsid9-0004zN-A9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697543578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+cJc4h59iJvLcHk0gasNlshSNApwgXPsu3ucraHrtM=;
 b=Ypx1SlZ4FmAN1OeJM1MJHqF86OJsTBlECG6c2doMnrWVvZFNzwohCXg/fe7WwGRzjW9/yN
 UFY+gCgLmJsgJvNfFOoXrj2+lDEDK2eldFKXluIZFa6VZhTppvwX90KBE0IHZzDXYpB9ft
 I/8da/bL/tBsUHOCgkFNkFNJpmBWmro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-uUqQc4mjOJS5M04ggyCNeQ-1; Tue, 17 Oct 2023 07:52:55 -0400
X-MC-Unique: uUqQc4mjOJS5M04ggyCNeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2150328EA6FA;
 Tue, 17 Oct 2023 11:52:55 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F077492BFA;
 Tue, 17 Oct 2023 11:52:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 6/7] [RFC] migration: Make -i/-b an error for hmp and qmp
Date: Tue, 17 Oct 2023 13:52:37 +0200
Message-ID: <20231017115238.18309-7-quintela@redhat.com>
In-Reply-To: <20231017115238.18309-1-quintela@redhat.com>
References: <20231017115238.18309-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[DON'T MERGE]

Block migration is obsolete, users should use blockdev-mirror
instead.
Make it one error to set them.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration-hmp-cmds.c | 13 +++++++------
 migration/migration.c          | 33 ++++++---------------------------
 2 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index bfeb1a476a..0acc866c79 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -746,16 +746,17 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
 
     if (inc) {
-        warn_report("option '-i' is deprecated.  Use 'blockdev-mirror + NBD'"
-                    " instead.");
+        monitor_printf(mon, "option '-i' is deprecated.  Use"
+                       " 'blockdev-mirror + NBD' instead.");
+        return;
     }
 
     if (blk) {
-        warn_report("option '-b' is deprecated.  Use 'blockdev-mirror + NBD'"
-                    " instead.");
+        monitor_printf(mon, "option '-b' is deprecated.  Use"
+                       " 'blockdev-mirror + NBD' instead.");
+        return;
     }
-
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
+    qmp_migrate(uri, false, false, false, false,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
diff --git a/migration/migration.c b/migration/migration.c
index 4da7fcfe0f..9a695299ba 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1601,16 +1601,16 @@ bool migration_is_blocked(Error **errp)
 static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                             bool resume, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (blk_inc) {
-        warn_report("parameter 'inc' is deprecated.  Use blockdev-mirror with"
-                    " NBD instead");
+        error_setg(errp, "parameter 'inc' is deprecated.  Use blockdev-mirror"
+                   " with NBD instead");
+        return false;
     }
 
     if (blk) {
-        warn_report("capability 'blk is deprecated.  Use blockdev-mirror with"
-                    " NBD instead");
+        error_setg(errp, "capability 'blk is deprecated.  Use blockdev-mirror"
+                   " with NBD instead");
+        return false;
     }
 
     if (resume) {
@@ -1662,27 +1662,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
-    if (blk || blk_inc) {
-        if (migrate_colo()) {
-            error_setg(errp, "No disk migration is required in COLO mode");
-            return false;
-        }
-        if (migrate_block() || migrate_block_incremental()) {
-            error_setg(errp, "Command options are incompatible with "
-                       "current migration capabilities");
-            return false;
-        }
-        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, &local_err)) {
-            error_propagate(errp, local_err);
-            return false;
-        }
-        s->must_remove_block_options = true;
-    }
-
-    if (blk_inc) {
-        migrate_set_block_incremental(true);
-    }
-
     if (migrate_init(s, errp)) {
         return false;
     }
-- 
2.41.0


