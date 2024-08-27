Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF896160C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Aug 2024 19:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0QJ-0006GJ-S8; Tue, 27 Aug 2024 13:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Q8-00060I-Hm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:57 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Q6-0001bu-I9
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:56 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Ps-0002No-Mb; Tue, 27 Aug 2024 19:55:40 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 09/17] migration/multifd: Device state transfer support -
 receive side
Date: Tue, 27 Aug 2024 19:54:28 +0200
Message-ID: <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a basic support for receiving device state via multifd channels -
channels that are shared with RAM transfers.

To differentiate between a device state and a RAM packet the packet
header is read first.

Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
packet header either device state (MultiFDPacketDeviceState_t) or RAM
data (existing MultiFDPacket_t) is then read.

The received device state data is provided to
qemu_loadvm_load_state_buffer() function for processing in the
device's load_state_buffer handler.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd.c | 127 +++++++++++++++++++++++++++++++++++++-------
 migration/multifd.h |  31 ++++++++++-
 2 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b06a9fab500e..d5a8e5a9c9b5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -21,6 +21,7 @@
 #include "file.h"
 #include "migration.h"
 #include "migration-stats.h"
+#include "savevm.h"
 #include "socket.h"
 #include "tls.h"
 #include "qemu-file.h"
@@ -209,10 +210,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 
     memset(packet, 0, p->packet_len);
 
-    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-    packet->version = cpu_to_be32(MULTIFD_VERSION);
+    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
+    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
 
-    packet->flags = cpu_to_be32(p->flags);
+    packet->hdr.flags = cpu_to_be32(p->flags);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
 
     packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
@@ -228,31 +229,49 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
                             p->flags, p->next_packet_size);
 }
 
-static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
+                                             MultiFDPacketHdr_t *hdr,
+                                             Error **errp)
 {
-    MultiFDPacket_t *packet = p->packet;
-    int ret = 0;
-
-    packet->magic = be32_to_cpu(packet->magic);
-    if (packet->magic != MULTIFD_MAGIC) {
+    hdr->magic = be32_to_cpu(hdr->magic);
+    if (hdr->magic != MULTIFD_MAGIC) {
         error_setg(errp, "multifd: received packet "
                    "magic %x and expected magic %x",
-                   packet->magic, MULTIFD_MAGIC);
+                   hdr->magic, MULTIFD_MAGIC);
         return -1;
     }
 
-    packet->version = be32_to_cpu(packet->version);
-    if (packet->version != MULTIFD_VERSION) {
+    hdr->version = be32_to_cpu(hdr->version);
+    if (hdr->version != MULTIFD_VERSION) {
         error_setg(errp, "multifd: received packet "
                    "version %u and expected version %u",
-                   packet->version, MULTIFD_VERSION);
+                   hdr->version, MULTIFD_VERSION);
         return -1;
     }
 
-    p->flags = be32_to_cpu(packet->flags);
+    p->flags = be32_to_cpu(hdr->flags);
+
+    return 0;
+}
+
+static int multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
+                                                   Error **errp)
+{
+    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
+
+    packet->instance_id = be32_to_cpu(packet->instance_id);
+    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
+
+    return 0;
+}
+
+static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
+{
+    MultiFDPacket_t *packet = p->packet;
+    int ret = 0;
+
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
-    p->packets_recved++;
 
     if (!(p->flags & MULTIFD_FLAG_SYNC)) {
         ret = multifd_ram_unfill_packet(p, errp);
@@ -264,6 +283,19 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     return ret;
 }
 
+static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
+{
+    p->packets_recved++;
+
+    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
+        return multifd_recv_unfill_packet_device_state(p, errp);
+    } else {
+        return multifd_recv_unfill_packet_ram(p, errp);
+    }
+
+    g_assert_not_reached();
+}
+
 static bool multifd_send_should_exit(void)
 {
     return qatomic_read(&multifd_send_state->exiting);
@@ -1014,6 +1046,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
+    g_clear_pointer(&p->packet_dev_state, g_free);
     g_free(p->normal);
     p->normal = NULL;
     g_free(p->zero);
@@ -1126,8 +1159,13 @@ static void *multifd_recv_thread(void *opaque)
     rcu_register_thread();
 
     while (true) {
+        MultiFDPacketHdr_t hdr;
         uint32_t flags = 0;
+        bool is_device_state = false;
         bool has_data = false;
+        uint8_t *pkt_buf;
+        size_t pkt_len;
+
         p->normal_num = 0;
 
         if (use_packets) {
@@ -1135,8 +1173,28 @@ static void *multifd_recv_thread(void *opaque)
                 break;
             }
 
-            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                           p->packet_len, &local_err);
+            ret = qio_channel_read_all_eof(p->c, (void *)&hdr,
+                                           sizeof(hdr), &local_err);
+            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
+                break;
+            }
+
+            ret = multifd_recv_unfill_packet_header(p, &hdr, &local_err);
+            if (ret) {
+                break;
+            }
+
+            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
+            if (is_device_state) {
+                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
+                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
+            } else {
+                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
+                pkt_len = p->packet_len - sizeof(hdr);
+            }
+
+            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
+                                           &local_err);
             if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
                 break;
             }
@@ -1181,8 +1239,33 @@ static void *multifd_recv_thread(void *opaque)
             has_data = !!p->data->size;
         }
 
-        if (has_data) {
-            ret = multifd_recv_state->ops->recv(p, &local_err);
+        if (!is_device_state) {
+            if (has_data) {
+                ret = multifd_recv_state->ops->recv(p, &local_err);
+                if (ret != 0) {
+                    break;
+                }
+            }
+        } else {
+            g_autofree char *idstr = NULL;
+            g_autofree char *dev_state_buf = NULL;
+
+            assert(use_packets);
+
+            if (p->next_packet_size > 0) {
+                dev_state_buf = g_malloc(p->next_packet_size);
+
+                ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, &local_err);
+                if (ret != 0) {
+                    break;
+                }
+            }
+
+            idstr = g_strndup(p->packet_dev_state->idstr, sizeof(p->packet_dev_state->idstr));
+            ret = qemu_loadvm_load_state_buffer(idstr,
+                                                p->packet_dev_state->instance_id,
+                                                dev_state_buf, p->next_packet_size,
+                                                &local_err);
             if (ret != 0) {
                 break;
             }
@@ -1190,6 +1273,11 @@ static void *multifd_recv_thread(void *opaque)
 
         if (use_packets) {
             if (flags & MULTIFD_FLAG_SYNC) {
+                if (is_device_state) {
+                    error_setg(&local_err, "multifd: received SYNC device state packet");
+                    break;
+                }
+
                 qemu_sem_post(&multifd_recv_state->sem_sync);
                 qemu_sem_wait(&p->sem_sync);
             }
@@ -1258,6 +1346,7 @@ int multifd_recv_setup(Error **errp)
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
         }
         p->name = g_strdup_printf("mig/dst/recv_%d", i);
         p->normal = g_new0(ram_addr_t, page_count);
diff --git a/migration/multifd.h b/migration/multifd.h
index a3e35196d179..a8f3e4838c01 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
 #define MULTIFD_FLAG_QPL (4 << 1)
 #define MULTIFD_FLAG_UADK (8 << 1)
 
+/*
+ * If set it means that this packet contains device state
+ * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
+ */
+#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
+
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
 
@@ -52,6 +58,11 @@ typedef struct {
     uint32_t magic;
     uint32_t version;
     uint32_t flags;
+} __attribute__((packed)) MultiFDPacketHdr_t;
+
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
     /* maximum number of allocated pages */
     uint32_t pages_alloc;
     /* non zero pages */
@@ -72,6 +83,16 @@ typedef struct {
     uint64_t offset[];
 } __attribute__((packed)) MultiFDPacket_t;
 
+typedef struct {
+    MultiFDPacketHdr_t hdr;
+
+    char idstr[256] QEMU_NONSTRING;
+    uint32_t instance_id;
+
+    /* size of the next packet that contains the actual data */
+    uint32_t next_packet_size;
+} __attribute__((packed)) MultiFDPacketDeviceState_t;
+
 typedef struct {
     /* number of used pages */
     uint32_t num;
@@ -89,6 +110,13 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+typedef struct {
+    char *idstr;
+    uint32_t instance_id;
+    char *buf;
+    size_t buf_len;
+} MultiFDDeviceState_t;
+
 typedef enum {
     MULTIFD_PAYLOAD_NONE,
     MULTIFD_PAYLOAD_RAM,
@@ -204,8 +232,9 @@ typedef struct {
 
     /* thread local variables. No locking required */
 
-    /* pointer to the packet */
+    /* pointers to the possible packet types */
     MultiFDPacket_t *packet;
+    MultiFDPacketDeviceState_t *packet_dev_state;
     /* size of the next packet that contains pages */
     uint32_t next_packet_size;
     /* packets received through this channel */

