Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA87C83A3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFiH-0003oE-Mb; Fri, 13 Oct 2023 06:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiF-0003mP-Ez
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiD-00078U-8v
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaXKjQStiMxeH8Qca/Gaj4ehRhjw572BlsYAjZ8vUms=;
 b=TqAusoZ+yRnDlftv2Gi6xOtrbzq4iLH6Wvd8ZAdbTvsa95mEu3vwtG+vsKaiE2qNqxP9CC
 fmUvmdRmfgBlSF5TC1erLhf9vZJ48onrkCzABt9yhjAX016scB5c/Pr0qd5Nn9wuw2gEgL
 8RO9mVWPg9plD3u3cli6YQ+QHgQZqVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-y2dTdXXPMEKIMBzCa70p9Q-1; Fri, 13 Oct 2023 06:48:04 -0400
X-MC-Unique: y2dTdXXPMEKIMBzCa70p9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C42181DA88;
 Fri, 13 Oct 2023 10:48:03 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA120215660D;
 Fri, 13 Oct 2023 10:48:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 07/10] [RFC] migration: Make -i/-b an error for hmp and qmp
Date: Fri, 13 Oct 2023 12:47:33 +0200
Message-ID: <20231013104736.31722-8-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
 migration/migration-hmp-cmds.c | 15 ++++++++++++++-
 migration/migration.c          | 35 +++++++---------------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e0e16afa34..582368926a 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -731,7 +731,20 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
+    if (inc) {
+        monitor_printf(mon, "-i migrate option is deprecated, set the"
+                       "'block-incremental' migration parameter to 'true'"
+                       " instead.\n");
+        return;
+    }
+
+    if (blk) {
+        monitor_printf(mon, "-b migrate option is deprecated, set the "
+                       "'block' capability to 'true' instead.\n");
+        return;
+    }
+
+    qmp_migrate(uri, false, false, false, false,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
diff --git a/migration/migration.c b/migration/migration.c
index 9e4ae6b772..50fc112e98 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1599,17 +1599,17 @@ bool migration_is_blocked(Error **errp)
 static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                             bool resume, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (blk_inc) {
-        warn_report("@inc/-i migrate option is deprecated, set the"
-                    "'block-incremental' migration parameter to 'true'"
-                    " instead.");
+        error_setg(errp, "@inc migrate option is deprecated, set the"
+                   "'block-incremental' migration parameter to 'true'"
+                   " instead.");
+        return false;
     }
 
     if (blk) {
-        warn_report("@blk/-i migrate option is deprecated, set the "
-                    "'block' capability to 'true' instead.");
+        error_setg(errp, "@blk/-i migrate option is deprecated, set the "
+                   "'block' capability to 'true' instead.");
+        return false;
     }
 
     if (resume) {
@@ -1661,27 +1661,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
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


