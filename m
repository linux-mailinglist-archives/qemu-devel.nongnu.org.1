Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E32B743431
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bS-0008GV-DY; Fri, 30 Jun 2023 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b3-0008B7-RF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b1-0003rS-GL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskH76P99z4wp7;
 Fri, 30 Jun 2023 15:22:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskH52Vyqz4wZy;
 Fri, 30 Jun 2023 15:22:57 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, YangHang Liu <yanghliu@redhat.com>
Subject: [PULL 05/16] vfio/migration: Refactor vfio_save_block() to return
 saved data size
Date: Fri, 30 Jun 2023 07:22:24 +0200
Message-ID: <20230630052235.1934154-6-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Refactor vfio_save_block() to return the size of saved data on success
and -errno on error.

This will be used in next patch to implement VFIO migration pre-copy
support.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb8859..235978fd6805 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -241,8 +241,8 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev,
     return 0;
 }
 
-/* Returns 1 if end-of-stream is reached, 0 if more data and -errno if error */
-static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
+/* Returns the size of saved data on success and -errno on error */
+static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 {
     ssize_t data_size;
 
@@ -252,7 +252,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
         return -errno;
     }
     if (data_size == 0) {
-        return 1;
+        return 0;
     }
 
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
@@ -262,7 +262,7 @@ static int vfio_save_block(QEMUFile *f, VFIOMigration *migration)
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
 
-    return qemu_file_get_error(f);
+    return qemu_file_get_error(f) ?: data_size;
 }
 
 /* ---------------------------------------------------------------------- */
@@ -335,6 +335,7 @@ static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    ssize_t data_size;
     int ret;
 
     /* We reach here with device state STOP only */
@@ -345,11 +346,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     }
 
     do {
-        ret = vfio_save_block(f, vbasedev->migration);
-        if (ret < 0) {
-            return ret;
+        data_size = vfio_save_block(f, vbasedev->migration);
+        if (data_size < 0) {
+            return data_size;
         }
-    } while (!ret);
+    } while (data_size);
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     ret = qemu_file_get_error(f);
-- 
2.41.0


