Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C87B7F67
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1BN-0006Z4-2Y; Wed, 04 Oct 2023 08:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BL-0006Yn-En
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BG-0003Wv-V8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkc4p9NTCrNTuyySnqsqSgjPATLXIwaqZ0UvDEiuJzw=;
 b=cXf3NlHydtDK6+e0SCuiiHxBVW4LC94+dNdccsFyktiDdmpxtIco2LF2aCHR1nqREU7Ugl
 p1o7ISNd3DOHMwoHpyjYtpVibwVeEtyDSjdkY5NxwDaqInS/+ssrokR25EGoDUe+47M4WV
 279woKCcMrXrdIbcdGPOMSFcGgUxbJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-IaeeIka8N_KXnC75NUf-Tw-1; Wed, 04 Oct 2023 08:40:45 -0400
X-MC-Unique: IaeeIka8N_KXnC75NUf-Tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 862D63C23FC2;
 Wed,  4 Oct 2023 12:40:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 141002026D4B;
 Wed,  4 Oct 2023 12:40:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Tejus GK <tejus.gk@nutanix.com>
Subject: [PULL 02/11] migration: Update error description outside migration.c
Date: Wed,  4 Oct 2023 14:40:29 +0200
Message-ID: <20231004124038.16002-3-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

From: Tejus GK <tejus.gk@nutanix.com>

A few code paths exist in the source code,where a migration is
marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
outside	of migration.c

In such	cases, an error_report() call is made, however the current
MigrationState is never	updated	with the error description, and	hence
clients	like libvirt never know	the actual reason for the failure.

This patch covers such cases outside of	migration.c and	updates	the
error description at the appropriate places.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231003065538.244752-3-tejus.gk@nutanix.com>
---
 migration/savevm.c  | 17 ++++++++++++++---
 migration/vmstate.c |  7 ++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1f65294bf4..60eec7c31f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -979,6 +979,8 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
 {
     int ret;
+    Error *local_err = NULL;
+    MigrationState *s = migrate_get_current();
 
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
@@ -1002,6 +1004,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     } else {
         ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
         if (ret) {
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -1068,10 +1072,14 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 {
     uint32_t tmp;
+    MigrationState *ms = migrate_get_current();
+    Error *local_err = NULL;
 
     if (len > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("%s: Unreasonably large packaged state: %zu",
+        error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
                      __func__, len);
+        migrate_set_error(ms, local_err);
+        error_report_err(local_err);
         return -1;
     }
 
@@ -1499,8 +1507,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
          * bdrv_activate_all() on the other end won't fail. */
         ret = bdrv_inactivate_all();
         if (ret) {
-            error_report("%s: bdrv_inactivate_all() failed (%d)",
-                         __func__, ret);
+            Error *local_err = NULL;
+            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
+                       __func__, ret);
+            migrate_set_error(ms, local_err);
+            error_report_err(local_err);
             qemu_file_set_error(f, ret);
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index dd9c76dbeb..4cde30bf2d 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -14,6 +14,7 @@
 #include "migration.h"
 #include "migration/vmstate.h"
 #include "savevm.h"
+#include "qapi/error.h"
 #include "qapi/qmp/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
@@ -336,7 +337,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
-            error_report("pre-save failed: %s", vmsd->name);
+            error_setg(errp, "pre-save failed: %s", vmsd->name);
             return ret;
         }
     }
@@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                      vmdesc_loop);
                 }
                 if (ret) {
-                    error_report("Save of field %s/%s failed",
-                                 vmsd->name, field->name);
+                    error_setg(errp, "Save of field %s/%s failed",
+                                vmsd->name, field->name);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-- 
2.41.0


