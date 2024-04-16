Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3628A6EB6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Apr 2024 16:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk3z-0005vS-40; Tue, 16 Apr 2024 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3C-0005mr-3V
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:47 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3A-0002M6-Mc
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:44:45 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk33-0002hJ-Fs; Tue, 16 Apr 2024 16:44:37 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 16/26] migration: Add save_live_complete_precopy_async{,
 wait} handlers
Date: Tue, 16 Apr 2024 16:42:55 +0200
Message-ID: <5a11fbbd197f08d45e61da40124c86ae8f761a27.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

These SaveVMHandlers allow device to provide its own asynchronous
transmission of the remaining data at the end of a precopy phase.

The save_live_complete_precopy_async handler is supposed to start such
transmission (for example, by launching appropriate threads) while the
save_live_complete_precopy_async_wait handler is supposed to wait until
such transfer has finished (for example, until the sending threads
have exited).

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/migration/register.h | 31 +++++++++++++++++++++++++++++++
 migration/savevm.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index d7b70a8be68c..9d36e35bd612 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -102,6 +102,37 @@ typedef struct SaveVMHandlers {
      */
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
+    /**
+     * @save_live_complete_precopy_async
+     *
+     * Arranges for handler-specific asynchronous transmission of the
+     * remaining data at the end of a precopy phase. When postcopy is
+     * enabled, devices that support postcopy will skip this step.
+     *
+     * @f: QEMUFile where the handler can synchronously send data before returning
+     * @idstr: this device section idstr
+     * @instance_id: this device section instance_id
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*save_live_complete_precopy_async)(QEMUFile *f,
+                                            char *idstr, uint32_t instance_id,
+                                            void *opaque);
+    /**
+     * @save_live_complete_precopy_async_wait
+     *
+     * Waits for the asynchronous transmission started by the of the
+     * @save_live_complete_precopy_async handler to complete.
+     * When postcopy is enabled, devices that support postcopy will skip this step.
+     *
+     * @f: QEMUFile where the handler can synchronously send data before returning
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*save_live_complete_precopy_async_wait)(QEMUFile *f, void *opaque);
+
     /* This runs both outside and inside the BQL.  */
 
     /**
diff --git a/migration/savevm.c b/migration/savevm.c
index 388d7af7cdd8..fa35504678bf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1497,6 +1497,27 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     SaveStateEntry *se;
     int ret;
 
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            !se->ops->save_live_complete_precopy_async) {
+            continue;
+        }
+
+        save_section_header(f, se, QEMU_VM_SECTION_END);
+
+        ret = se->ops->save_live_complete_precopy_async(f,
+                                                        se->idstr, se->instance_id,
+                                                        se->opaque);
+
+        save_section_footer(f, se);
+
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
@@ -1528,6 +1549,20 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
                                     end_ts_each - start_ts_each);
     }
 
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            !se->ops->save_live_complete_precopy_async_wait) {
+            continue;
+        }
+
+        ret = se->ops->save_live_complete_precopy_async_wait(f, se->opaque);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
     trace_vmstate_downtime_checkpoint("src-iterable-saved");
 
     return 0;

