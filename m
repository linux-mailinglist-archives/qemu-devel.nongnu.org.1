Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA67DF18E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:45:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW7G-0007fH-PF; Thu, 02 Nov 2023 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW77-0006bY-Bp
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW74-0005yT-3g
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrn4sanShClOlIiSikoqTAj7uLvyWROkN4mIZVT/0o4=;
 b=XoTwP/EFoOmMuMFIAn0IkopFg9KNJlCTiClnLyNTZyNcEEHJzV4/IuKBwlEH1XqMYdtSBy
 P2/M8aAK8aWDItmoKdZDk+KOMYbQI4WSdn+N4DKpsUjDO8X9FZ7tbd+FWGoDf8Fl5VZGnz
 UidPVy0rWAWVmNzyBsEJd1Mzis0FW0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-qHmvaO63MTScDgTNJpg9Iw-1; Thu, 02 Nov 2023 07:43:46 -0400
X-MC-Unique: qHmvaO63MTScDgTNJpg9Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7360F101A529;
 Thu,  2 Nov 2023 11:43:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9EC2026D4C;
 Thu,  2 Nov 2023 11:43:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 21/40] migration: per-mode blockers
Date: Thu,  2 Nov 2023 12:40:35 +0100
Message-ID: <20231102114054.44360-22-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Extend the blocker interface so that a blocker can be registered for
one or more migration modes.  The existing interfaces register a
blocker for all modes, and the new interfaces take a varargs list
of modes.

Internally, maintain a separate blocker list per mode.  The same Error
object may be added to multiple lists.  When a block is deleted, it is
removed from every list, and the Error is freed.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <1698263069-406971-3-git-send-email-steven.sistare@oracle.com>
---
 include/migration/blocker.h | 44 +++++++++++++++--
 migration/migration.c       | 95 ++++++++++++++++++++++++++++++++-----
 stubs/migr-blocker.c        | 10 ++++
 3 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/include/migration/blocker.h b/include/migration/blocker.h
index b048f301b4..a687ac0efe 100644
--- a/include/migration/blocker.h
+++ b/include/migration/blocker.h
@@ -14,8 +14,12 @@
 #ifndef MIGRATION_BLOCKER_H
 #define MIGRATION_BLOCKER_H
 
+#include "qapi/qapi-types-migration.h"
+
+#define MIG_MODE_ALL MIG_MODE__MAX
+
 /**
- * @migrate_add_blocker - prevent migration from proceeding
+ * @migrate_add_blocker - prevent all modes of migration from proceeding
  *
  * @reasonp - address of an error to be returned whenever migration is attempted
  *
@@ -30,8 +34,8 @@
 int migrate_add_blocker(Error **reasonp, Error **errp);
 
 /**
- * @migrate_add_blocker_internal - prevent migration from proceeding without
- *                                 only-migrate implications
+ * @migrate_add_blocker_internal - prevent all modes of migration from
+ *                                 proceeding, but ignore -only-migratable
  *
  * @reasonp - address of an error to be returned whenever migration is attempted
  *
@@ -50,7 +54,7 @@ int migrate_add_blocker(Error **reasonp, Error **errp);
 int migrate_add_blocker_internal(Error **reasonp, Error **errp);
 
 /**
- * @migrate_del_blocker - remove a blocking error from migration and free it.
+ * @migrate_del_blocker - remove a migration blocker from all modes and free it.
  *
  * @reasonp - address of the error blocking migration
  *
@@ -58,4 +62,36 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp);
  */
 void migrate_del_blocker(Error **reasonp);
 
+/**
+ * @migrate_add_blocker_normal - prevent normal migration mode from proceeding
+ *
+ * @reasonp - address of an error to be returned whenever migration is attempted
+ *
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
+ *
+ * *@reasonp is freed and set to NULL if failure is returned.
+ * On success, the caller must not free @reasonp, except by
+ *   calling migrate_del_blocker.
+ */
+int migrate_add_blocker_normal(Error **reasonp, Error **errp);
+
+/**
+ * @migrate_add_blocker_modes - prevent some modes of migration from proceeding
+ *
+ * @reasonp - address of an error to be returned whenever migration is attempted
+ *
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @mode - one or more migration modes to be blocked.  The list is terminated
+ *         by -1 or MIG_MODE_ALL.  For the latter, all modes are blocked.
+ *
+ * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
+ *
+ * *@reasonp is freed and set to NULL if failure is returned.
+ * On success, the caller must not free *@reasonp before the blocker is removed.
+ */
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index c334b9effd..11c1490090 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -92,7 +92,7 @@ enum mig_rp_message_type {
 static MigrationState *current_migration;
 static MigrationIncomingState *current_incoming;
 
-static GSList *migration_blockers;
+static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
@@ -1043,7 +1043,7 @@ static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
     int state = qatomic_read(&s->state);
-    GSList *cur_blocker = migration_blockers;
+    GSList *cur_blocker = migration_blockers[migrate_mode()];
 
     info->blocked_reasons = NULL;
 
@@ -1507,38 +1507,105 @@ int migrate_init(MigrationState *s, Error **errp)
     return 0;
 }
 
-int migrate_add_blocker_internal(Error **reasonp, Error **errp)
+static bool is_busy(Error **reasonp, Error **errp)
 {
+    ERRP_GUARD();
+
     /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
     if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(migration/snapshot in progress) for: ");
         *reasonp = NULL;
-        return -EBUSY;
+        return true;
     }
-
-    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
-    return 0;
+    return false;
 }
 
-int migrate_add_blocker(Error **reasonp, Error **errp)
+static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
 {
-    if (only_migratable) {
+    ERRP_GUARD();
+
+    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(--only-migratable) for: ");
         *reasonp = NULL;
+        return true;
+    }
+    return false;
+}
+
+static int get_modes(MigMode mode, va_list ap)
+{
+    int modes = 0;
+
+    while (mode != -1 && mode != MIG_MODE_ALL) {
+        assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
+        modes |= BIT(mode);
+        mode = va_arg(ap, MigMode);
+    }
+    if (mode == MIG_MODE_ALL) {
+        modes = BIT(MIG_MODE__MAX) - 1;
+    }
+    return modes;
+}
+
+static int add_blockers(Error **reasonp, Error **errp, int modes)
+{
+    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (modes & BIT(mode)) {
+            migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
+                                                       *reasonp);
+        }
+    }
+    return 0;
+}
+
+int migrate_add_blocker(Error **reasonp, Error **errp)
+{
+    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_ALL);
+}
+
+int migrate_add_blocker_normal(Error **reasonp, Error **errp)
+{
+    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
+}
+
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+{
+    int modes;
+    va_list ap;
+
+    va_start(ap, mode);
+    modes = get_modes(mode, ap);
+    va_end(ap);
+
+    if (is_only_migratable(reasonp, errp, modes)) {
         return -EACCES;
+    } else if (is_busy(reasonp, errp)) {
+        return -EBUSY;
     }
+    return add_blockers(reasonp, errp, modes);
+}
 
-    return migrate_add_blocker_internal(reasonp, errp);
+int migrate_add_blocker_internal(Error **reasonp, Error **errp)
+{
+    int modes = BIT(MIG_MODE__MAX) - 1;
+
+    if (is_busy(reasonp, errp)) {
+        return -EBUSY;
+    }
+    return add_blockers(reasonp, errp, modes);
 }
 
 void migrate_del_blocker(Error **reasonp)
 {
     if (*reasonp) {
-        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
+        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+            migration_blockers[mode] = g_slist_remove(migration_blockers[mode],
+                                                      *reasonp);
+        }
         error_free(*reasonp);
         *reasonp = NULL;
     }
@@ -1634,12 +1701,14 @@ void qmp_migrate_pause(Error **errp)
 
 bool migration_is_blocked(Error **errp)
 {
+    GSList *blockers = migration_blockers[migrate_mode()];
+
     if (qemu_savevm_state_blocked(errp)) {
         return true;
     }
 
-    if (migration_blockers) {
-        error_propagate(errp, error_copy(migration_blockers->data));
+    if (blockers) {
+        error_propagate(errp, error_copy(blockers->data));
         return true;
     }
 
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 17a5dbf87b..11cbff268f 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -6,6 +6,16 @@ int migrate_add_blocker(Error **reasonp, Error **errp)
     return 0;
 }
 
+int migrate_add_blocker_normal(Error **reasonp, Error **errp)
+{
+    return 0;
+}
+
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+{
+    return 0;
+}
+
 void migrate_del_blocker(Error **reasonp)
 {
 }
-- 
2.41.0


