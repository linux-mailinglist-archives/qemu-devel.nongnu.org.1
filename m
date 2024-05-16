Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6798C76DE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 May 2024 14:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7aWI-00031W-KT; Thu, 16 May 2024 08:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW1-0002tv-Lu
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW0-0001B3-0w
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715863637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4r6NvMRtBa9ip4se4XRJhDxpJUe5VTrGdtQp8spYZ4=;
 b=gJ25xCXTNlMtoHGlXYmVJa8t+KM17VSgm5N6IFKr3v1NHFlchd+b6e4Z2XKM801zA2e2Mv
 hW9mnebcYMmdXnPb37uZEIZ/vV4GaDFEBS/cDT4yCvHtYrabx7xUE5Kjy7KFBIsu+5A2jy
 jNADvppVd0qwYvKM6LVIe9xeO9wZtzs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-iTe2phKUPe69zioLqbbrUA-1; Thu, 16 May 2024 08:47:15 -0400
X-MC-Unique: iTe2phKUPe69zioLqbbrUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3D08001F7;
 Thu, 16 May 2024 12:47:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2985C200A707;
 Thu, 16 May 2024 12:47:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 3/9] migration: Extend migration_file_set_error() with
 Error* argument
Date: Thu, 16 May 2024 14:46:52 +0200
Message-ID: <20240516124658.850504-4-clg@redhat.com>
In-Reply-To: <20240516124658.850504-1-clg@redhat.com>
References: <20240516124658.850504-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

Use it to update the current error of the migration stream if
available and if not, simply print out the error. Next changes will
update with an error to report.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v7:

 - vfio_set_migration_error() err -> ret rename (Eric)
 
 include/migration/misc.h | 2 +-
 hw/vfio/common.c         | 4 ++--
 hw/vfio/migration.c      | 4 ++--
 migration/migration.c    | 6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bf7339cc1e6430226127fb6a878d06b458170858..bfadc5613bac614a316e5aed7da95d8c7845cf42 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -97,7 +97,7 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
 
 void migration_remove_notifier(NotifierWithReturn *notify);
 bool migration_is_running(void);
-void migration_file_set_error(int err);
+void migration_file_set_error(int ret, Error *err);
 
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b5102f54a6474a50c6366e8fbce23812d55e384e..2c97de6c730d963d961bf81c0831326c0e25afa7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -147,10 +147,10 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
     return vbasedev->bcontainer->space->as != &address_space_memory;
 }
 
-static void vfio_set_migration_error(int err)
+static void vfio_set_migration_error(int ret)
 {
     if (migration_is_setup_or_active()) {
-        migration_file_set_error(err);
+        migration_file_set_error(ret, NULL);
     }
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 06ae40969b6c19037e190008e14f28be646278cd..bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -726,7 +726,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        migration_file_set_error(ret);
+        migration_file_set_error(ret, NULL);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -756,7 +756,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        migration_file_set_error(ret);
+        migration_file_set_error(ret, NULL);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
diff --git a/migration/migration.c b/migration/migration.c
index e88b24f1e6cbe82dad3f890c00e264d2ab6ad355..70d66a441bf04761decf91dbe57ce52c57fde58f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2994,13 +2994,15 @@ static MigThrError postcopy_pause(MigrationState *s)
     }
 }
 
-void migration_file_set_error(int err)
+void migration_file_set_error(int ret, Error *err)
 {
     MigrationState *s = current_migration;
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-            qemu_file_set_error(s->to_dst_file, err);
+            qemu_file_set_error_obj(s->to_dst_file, ret, err);
+        } else if (err) {
+            error_report_err(err);
         }
     }
 }
-- 
2.45.0


