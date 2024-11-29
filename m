Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 232169D0580
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Nov 2024 20:24:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkqu-0003Sd-QH; Sun, 17 Nov 2024 14:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqq-0003HO-24
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:28 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqn-0005w9-3Y
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:22:27 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkqi-00000002GVB-3S6p; Sun, 17 Nov 2024 20:22:20 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 14/24] migration/multifd: Make MultiFDSendData a struct
Date: Sun, 17 Nov 2024 20:20:09 +0100
Message-ID: <90a4097cce137a99a913566c46ff736fd36e7d25.1731773021.git.maciej.szmigiero@oracle.com>
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

From: Peter Xu <peterx@redhat.com>

The newly introduced device state buffer can be used for either storing
VFIO's read() raw data, but already also possible to store generic device
states.  After noticing that device states may not easily provide a max
buffer size (also the fact that RAM MultiFDPages_t after all also want to
have flexibility on managing offset[] array), it may not be a good idea to
stick with union on MultiFDSendData.. as it won't play well with such
flexibility.

Switch MultiFDSendData to a struct.

It won't consume a lot more space in reality, after all the real buffers
were already dynamically allocated, so it's so far only about the two
structs (pages, device_state) that will be duplicated, but they're small.

With this, we can remove the pretty hard to understand alloc size logic.
Because now we can allocate offset[] together with the SendData, and
properly free it when the SendData is freed.

Signed-off-by: Peter Xu <peterx@redhat.com>
[MSS: Make sure to clear possible device state payload before freeing
MultiFDSendData, remove placeholders for other patches not included]
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 migration/multifd-device-state.c |  5 -----
 migration/multifd-nocomp.c       | 13 ++++++-------
 migration/multifd.c              | 25 +++++++------------------
 migration/multifd.h              | 14 +++++++++-----
 4 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 7741a64fbd4d..8cf5a6c2668c 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -16,11 +16,6 @@ static QemuMutex queue_job_mutex;
 
 static MultiFDSendData *device_state_send;
 
-size_t multifd_device_state_payload_size(void)
-{
-    return sizeof(MultiFDDeviceState_t);
-}
-
 void multifd_device_state_send_setup(void)
 {
     qemu_mutex_init(&queue_job_mutex);
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 23564ce9aea9..90c0927b9bcb 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -23,15 +23,14 @@
 
 static MultiFDSendData *multifd_ram_send;
 
-size_t multifd_ram_payload_size(void)
+void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
-    uint32_t n = multifd_ram_page_count();
+    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
+}
 
-    /*
-     * We keep an array of page offsets at the end of MultiFDPages_t,
-     * add space for it in the allocation.
-     */
-    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+void multifd_ram_payload_free(MultiFDPages_t *pages)
+{
+    g_clear_pointer(&pages->offset, g_free);
 }
 
 void multifd_ram_save_setup(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 56419af417cc..4b03253f739e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -105,26 +105,12 @@ struct {
 
 MultiFDSendData *multifd_send_data_alloc(void)
 {
-    size_t max_payload_size, size_minus_payload;
+    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
 
-    /*
-     * MultiFDPages_t has a flexible array at the end, account for it
-     * when allocating MultiFDSendData. Use max() in case other types
-     * added to the union in the future are larger than
-     * (MultiFDPages_t + flex array).
-     */
-    max_payload_size = MAX(multifd_ram_payload_size(),
-                           multifd_device_state_payload_size());
-    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
-
-    /*
-     * Account for any holes the compiler might insert. We can't pack
-     * the structure because that misaligns the members and triggers
-     * Waddress-of-packed-member.
-     */
-    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
+    multifd_ram_payload_alloc(&new->u.ram);
+    /* Device state allocates its payload on-demand */
 
-    return g_malloc0(size_minus_payload + max_payload_size);
+    return new;
 }
 
 void multifd_send_data_clear(MultiFDSendData *data)
@@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
         return;
     }
 
+    /* This also free's device state payload */
     multifd_send_data_clear(data);
 
+    multifd_ram_payload_free(&data->u.ram);
+
     g_free(data);
 }
 
diff --git a/migration/multifd.h b/migration/multifd.h
index dec7d9404434..05ddfb4bf119 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -99,9 +99,13 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
+    /*
+     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
+     * sure the pointer is always valid!
+     */
     RAMBlock *block;
-    /* offset of each page */
-    ram_addr_t offset[];
+    /* offset array of each page, managed by multifd */
+    ram_addr_t *offset;
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
@@ -124,7 +128,7 @@ typedef enum {
     MULTIFD_PAYLOAD_DEVICE_STATE,
 } MultiFDPayloadType;
 
-typedef union MultiFDPayload {
+typedef struct MultiFDPayload {
     MultiFDPages_t ram;
     MultiFDDeviceState_t device_state;
 } MultiFDPayload;
@@ -373,11 +377,11 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(void);
-size_t multifd_ram_payload_size(void);
+void multifd_ram_payload_alloc(MultiFDPages_t *pages);
+void multifd_ram_payload_free(MultiFDPages_t *pages);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
 
-size_t multifd_device_state_payload_size(void);
 void multifd_device_state_send_setup(void);
 void multifd_device_state_clear(MultiFDDeviceState_t *device_state);
 void multifd_device_state_send_cleanup(void);

