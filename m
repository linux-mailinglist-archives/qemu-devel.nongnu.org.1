Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EB9D0581
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Nov 2024 20:24:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkrU-0005oN-KP; Sun, 17 Nov 2024 14:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrI-0005J7-Ra
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:58 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrH-0005yc-DD
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:56 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrD-00000002GWO-2nNh; Sun, 17 Nov 2024 20:22:51 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 20/24] vfio/migration: Add load_device_config_state_start
 trace event
Date: Sun, 17 Nov 2024 20:20:15 +0100
Message-ID: <9c6f1db39fd6e8e12cfb8946cd4d2a39ad77564c.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

And rename existing load_device_config_state trace event to
load_device_config_state_end for consistency since it is triggered at the
end of loading of the VFIO device config state.

This way both the start and end points of particular device config
loading operation (a long, BQL-serialized operation) are known.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c  | 4 +++-
 hw/vfio/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 9e2657073012..4b2b06b45195 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -285,6 +285,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     uint64_t data;
 
+    trace_vfio_load_device_config_state_start(vbasedev->name);
+
     if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
         int ret;
 
@@ -303,7 +305,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
         return -EINVAL;
     }
 
-    trace_vfio_load_device_config_state(vbasedev->name);
+    trace_vfio_load_device_config_state_end(vbasedev->name);
     return qemu_file_get_error(f);
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cab1cf1de0a2..1bebe9877d88 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -149,7 +149,8 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_load_cleanup(const char *name) " (%s)"
-vfio_load_device_config_state(const char *name) " (%s)"
+vfio_load_device_config_state_start(const char *name) " (%s)"
+vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"

