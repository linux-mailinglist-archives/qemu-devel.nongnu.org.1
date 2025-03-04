Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E6EA4F007
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Mar 2025 23:20:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaPM-0002Y6-ED; Tue, 04 Mar 2025 17:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPG-0002Ko-FN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:30 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPE-0001Mi-OT
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:06:30 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPA-00000000LZU-2syA; Tue, 04 Mar 2025 23:06:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 19/36] vfio/migration: Convert bytes_transferred counter to
 atomic
Date: Tue,  4 Mar 2025 23:03:46 +0100
Message-ID: <dc391771d2d9ad0f311994f0cb9e666da564aeaf.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

So it can be safety accessed from multiple threads.

This variable type needs to be changed to unsigned long since
32-bit host platforms lack the necessary addition atomics on 64-bit
variables.

Using 32-bit counters on 32-bit host platforms should not be a problem
in practice since they can't realistically address more memory anyway.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 03890eaa48a9..5532787be63b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -55,7 +55,7 @@
  */
 #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
 
-static int64_t bytes_transferred;
+static unsigned long bytes_transferred;
 
 static const char *mig_state_to_str(enum vfio_device_mig_state state)
 {
@@ -391,7 +391,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
     qemu_put_be64(f, data_size);
     qemu_put_buffer(f, migration->data_buffer, data_size);
-    bytes_transferred += data_size;
+    qatomic_add(&bytes_transferred, data_size);
 
     trace_vfio_save_block(migration->vbasedev->name, data_size);
 
@@ -1013,12 +1013,12 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
 
 int64_t vfio_mig_bytes_transferred(void)
 {
-    return bytes_transferred;
+    return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
 }
 
 void vfio_reset_bytes_transferred(void)
 {
-    bytes_transferred = 0;
+    qatomic_set(&bytes_transferred, 0);
 }
 
 /*

