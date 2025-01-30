Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025AA22B65
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 11:12:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRWK-0007SS-ER; Thu, 30 Jan 2025 05:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWE-00078C-Mq
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:30 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWC-0007O3-Sv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:30 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRVy-00000006U0r-2D3i; Thu, 30 Jan 2025 11:11:14 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 24/33] vfio/migration: Multifd device state transfer
 support - VFIOStateBuffer(s)
Date: Thu, 30 Jan 2025 11:08:45 +0100
Message-ID: <656c5005405aa875c79a190dd0a671993b2408c6.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add VFIOStateBuffer(s) types and the associated methods.

These store received device state buffers and config state waiting to get
loaded into the device.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 715182c4f810..40cbe1be687d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -289,6 +289,60 @@ static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
 #endif
 }
 
+/* type safety */
+typedef struct VFIOStateBuffers {
+    GArray *array;
+} VFIOStateBuffers;
+
+typedef struct VFIOStateBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} VFIOStateBuffer;
+
+static void vfio_state_buffer_clear(gpointer data)
+{
+    VFIOStateBuffer *lb = data;
+
+    if (!lb->is_present) {
+        return;
+    }
+
+    g_clear_pointer(&lb->data, g_free);
+    lb->is_present = false;
+}
+
+static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
+{
+    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
+    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
+}
+
+static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
+{
+    g_clear_pointer(&bufs->array, g_array_unref);
+}
+
+static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
+{
+    assert(bufs->array);
+}
+
+static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
+{
+    return bufs->array->len;
+}
+
+static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
+{
+    g_array_set_size(bufs->array, size);
+}
+
+static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
+{
+    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {

